/*-
 *   BSD LICENSE
 *
 *   Copyright(c) 2010-2015 Intel Corporation. All rights reserved.
 *   All rights reserved.
 *
 *   Redistribution and use in source and binary forms, with or without
 *   modification, are permitted provided that the following conditions
 *   are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in
 *       the documentation and/or other materials provided with the
 *       distribution.
 *     * Neither the name of Intel Corporation nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdint.h>
#include <inttypes.h>
#include <rte_eal.h>
#include <rte_ethdev.h>
#include <rte_cycles.h>
#include <rte_lcore.h>
#include <rte_mbuf.h>
#include <rte_vect.h>
#include <time.h>

#define RX_RING_SIZE 128
#define TX_RING_SIZE 512

#define NUM_MBUFS 8191
#define MBUF_CACHE_SIZE 250
#define BURST_SIZE 32


clock_t start;
clock_t finish;


static const struct rte_eth_conf port_conf_default = {
	.rxmode = { .max_rx_pkt_len = ETHER_MAX_LEN, },
};

static unsigned nb_ports;

static struct {
	uint64_t total_cycles;
	uint64_t total_pkts;
} latency_numbers;


static uint16_t
add_timestamps(uint8_t port __rte_unused, uint16_t qidx __rte_unused,
		struct rte_mbuf **pkts, uint16_t nb_pkts,
		uint16_t max_pkts __rte_unused, void *_ __rte_unused)
{
	unsigned i;
	uint64_t now = rte_rdtsc();

	for (i = 0; i < nb_pkts; i++) {
		pkts[i]->udata64 = now;
  }

	return nb_pkts;
}

char keep_going = 1;

static uint16_t
calc_latency(uint8_t port __rte_unused, uint16_t qidx __rte_unused,
		struct rte_mbuf **pkts, uint16_t nb_pkts, void *_ __rte_unused)
{
	uint64_t cycles = 0;
	uint64_t now = rte_rdtsc();
	unsigned i;
  
	for (i = 0; i < nb_pkts; i++)
		cycles += now - pkts[i]->udata64;
	latency_numbers.total_cycles += cycles;
	latency_numbers.total_pkts += nb_pkts;

  if (keep_going) {
    printf(" l = %lu, %lu\n", latency_numbers.total_cycles,
      latency_numbers.total_pkts);
  }

	if (latency_numbers.total_pkts > (1000 * 1000ULL)) {
		printf("\naverage latency = %"PRIu64" cycles\n",
		  latency_numbers.total_cycles / latency_numbers.total_pkts);

		latency_numbers.total_cycles = latency_numbers.total_pkts = 0;

    keep_going = 0;

    finish = clock();
    int diff = finish - start;

    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time elapsed: %d.%d s\n",
      msec / 1000, msec % 1000);

    // reset start time
    start = finish;
      
	}
	return nb_pkts;
}

/*
 * Initialises a given port using global settings and with the rx buffers
 * coming from the mbuf_pool passed as parameter
 */
static inline int
port_init(uint8_t port, struct rte_mempool *mbuf_pool)
{
	struct rte_eth_conf port_conf = port_conf_default;
	const uint16_t rx_rings = 1, tx_rings = 1;
	int retval;
	uint16_t q;

	if (port >= rte_eth_dev_count())
		return -1;

	retval = rte_eth_dev_configure(port, rx_rings, tx_rings, &port_conf);
	if (retval != 0)
		return retval;

	for (q = 0; q < rx_rings; q++) {
		retval = rte_eth_rx_queue_setup(port, q, RX_RING_SIZE,
				rte_eth_dev_socket_id(port), NULL, mbuf_pool);
		if (retval < 0)
			return retval;
	}

	for (q = 0; q < tx_rings; q++) {
		retval = rte_eth_tx_queue_setup(port, q, TX_RING_SIZE,
				rte_eth_dev_socket_id(port), NULL);
		if (retval < 0)
			return retval;
	}

	retval  = rte_eth_dev_start(port);
	if (retval < 0)
		return retval;

	struct ether_addr addr;

	rte_eth_macaddr_get(port, &addr);
	printf("Port %u MAC: %02"PRIx8" %02"PRIx8" %02"PRIx8
			" %02"PRIx8" %02"PRIx8" %02"PRIx8"\n",
			(unsigned)port,
			addr.addr_bytes[0], addr.addr_bytes[1],
			addr.addr_bytes[2], addr.addr_bytes[3],
			addr.addr_bytes[4], addr.addr_bytes[5]);

	rte_eth_promiscuous_enable(port);
  void *ptr = rte_eth_add_rx_callback(port, 0, add_timestamps, NULL);

	if (NULL == ptr) {
    printf("Error: rte_eth_add_rx_callback()\n");
  } else {
    printf("rte_eth_add_rx_callback() ok %p\n", ptr); 
  }

  ptr = rte_eth_add_tx_callback(port, 0, calc_latency, NULL);
	if (NULL == ptr) {
    printf("Error: rte_eth_add_tx_callback()\n");
  } else {
    printf("rte_eth_add_tx_callback() ok %p\n", ptr); 
  }

	return 0;
}

/*
 * Main thread that does the work, reading from INPUT_PORT
 * and writing to OUTPUT_PORT
 */
static  __attribute__((noreturn)) void
lcore_main(void)
{
	uint8_t port;

	for (port = 0; port < nb_ports; port++)
		if (rte_eth_dev_socket_id(port) > 0 &&
				rte_eth_dev_socket_id(port) !=
						(int)rte_socket_id())
			printf("WARNING, port %u is on remote NUMA node to "
					"polling thread.\n\tPerformance will "
					"not be optimal.\n", port);

	printf("\nCore %u forwarding packets. [Ctrl+C to quit]\n",
			rte_lcore_id());
  int first = 1;
	for (;;) {
		for (port = 0; port < nb_ports; port++) {
			struct rte_mbuf *bufs[BURST_SIZE];
      
      if (1 == first) {
        printf("%d, %d, %p, %d\n", port, 0, bufs, BURST_SIZE);
        first = 0;
      }
      
			const uint16_t nb_rx = rte_eth_rx_burst(port, 0,
					bufs, BURST_SIZE);

      if (0 != nb_rx) {
//        printf("nb_rx = %d\n", nb_rx);
      }

			if (unlikely(nb_rx == 0))
				continue;

			const uint16_t nb_tx = rte_eth_tx_burst(port ^ 1, 0,
					bufs, nb_rx);

			if (unlikely(nb_tx < nb_rx)) {
				uint16_t buf;
        printf("D");

				for (buf = nb_tx; buf < nb_rx; buf++)
					rte_pktmbuf_free(bufs[buf]);
			}
		}
	}
}

static void testL() {
  printf("unlikely(1) ");
  if (unlikely(1)) {
    printf(" true");
  } else {
    printf(" false");
  }

  printf("\nunlikely(0) ");
  if (unlikely(0)) {
    printf(" true");
  } else {
    printf(" false");
  }

  int a = 0;
  printf("\nunlikely(a == 0) ");
  if (unlikely(a == 0)) {
    printf(" true");
  } else {
    printf(" false");
  }
  printf("\n");

  rte_xmm_t rte_xmmo;
  printf("sizeof(xmm_t) = %lu, sizeof(long long) = %lu, sizeof(long) = %lu, sizeof(int) = %lu, sizeof(char) = %lu\n",
    sizeof(xmm_t), sizeof(long long), sizeof(long), sizeof(int), sizeof(char));

  printf("sizeof(rte_xmmo.x) = %lu, %lu, %lu, %lu, %lu, %lu\n",
    sizeof(rte_xmmo.x),
    sizeof(rte_xmmo.u8),
    sizeof(rte_xmmo.u16),
    sizeof(rte_xmmo.u32),
    sizeof(rte_xmmo.u64),
    sizeof(rte_xmmo.pd));
  printf("sizeof(struct rte_mempool) = %lu, sizeof(latency_numbers) = %lu, sizeof(struct rte_eth_conf) = %lu, sizeof(struct rte_mbuf) = %lu, sizeof(struct ether_addr) = %lu, sizeof(struct rte_eth_dev) = %lu, sizeof(struct rte_eth_rxtx_callback) = %lu\n",
    sizeof(struct rte_mempool),
    sizeof(latency_numbers),
    sizeof(struct rte_eth_conf),
    sizeof(struct rte_mbuf),
    sizeof(struct ether_addr),
    sizeof(struct rte_eth_dev),
    sizeof(struct rte_eth_rxtx_callback)
    );
  #ifdef RTE_ETHDEV_RXTX_CALLBACKS
    printf("  RTE_ETHDEV_RXTX_CALLBACKS\n");
  #endif

  #ifdef RTE_LIBRTE_ETHDEV_DEBUG
    printf("RTE_LIBRTE_ETHDEV_DEBUG\n");
  #endif

  struct rte_mbuf m;
  printf("&rte_mbuf = %p, &(rte_mbuf.vlan_tci_outer) = %p, &(rte_mbuf.cacheline1) = %p, &(rte_mbuf.udata64) = %p\n",
    &m, &(m.vlan_tci_outer), &(m.cacheline1), &(m.udata64));
}
/*
 * unlikely(1)  true
 * unlikely(0)  false
 */

typedef int bits_t;
#define	RTE_ACL_BIT_SET_SIZE	((UINT8_MAX + 1) / (sizeof(bits_t) * CHAR_BIT))

/* Main function, does initialisation and calls the per-lcore functions */
int
main(int argc, char *argv[])
{
  testL();
  start = clock();
  printf("start = %lu", start);

	struct rte_mempool *mbuf_pool;
	uint8_t portid;

	/* init EAL */
	int ret = rte_eal_init(argc, argv);

	if (ret < 0)
		rte_exit(EXIT_FAILURE, "Error with EAL initialization\n");
	argc -= ret;
	argv += ret;

	nb_ports = rte_eth_dev_count();
	if (nb_ports < 2 || (nb_ports & 1))
		rte_exit(EXIT_FAILURE, "Error: number of ports must be even\n");

  printf("here = %d, %d, %d, %d, %d\n", NUM_MBUFS * nb_ports,
    MBUF_CACHE_SIZE,
    0,
    RTE_MBUF_DEFAULT_BUF_SIZE,
    rte_socket_id());

	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL",
		NUM_MBUFS * nb_ports, MBUF_CACHE_SIZE, 0,
		RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
	if (mbuf_pool == NULL)
		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");

  printf("mbuf_pool = %p", mbuf_pool);

	/* initialize all ports */
	for (portid = 0; portid < nb_ports; portid++)
		if (port_init(portid, mbuf_pool) != 0)
			rte_exit(EXIT_FAILURE, "Cannot init port %"PRIu8"\n",
					portid);

	if (rte_lcore_count() > 1)
		printf("\nWARNING: Too much enabled lcores - "
			"App uses only 1 lcore\n");

	/* call lcore_main on master core only */
	lcore_main();
	return 0;
}
