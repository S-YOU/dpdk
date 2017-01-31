# -
##    BSD LICENSE
## 
##    Copyright(c) 2010-2014 Intel Corporation. All rights reserved.
##    All rights reserved.
## 
##    Redistribution and use in source and binary forms, with or without
##    modification, are permitted provided that the following conditions
##    are met:
## 
##      * Redistributions of source code must retain the above copyright
##        notice, this list of conditions and the following disclaimer.
##      * Redistributions in binary form must reproduce the above copyright
##        notice, this list of conditions and the following disclaimer in
##        the documentation and/or other materials provided with the
##        distribution.
##      * Neither the name of Intel Corporation nor the names of its
##        contributors may be used to endorse or promote products derived
##        from this software without specific prior written permission.
## 
##    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
##    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
##    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
##    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
##    OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
##    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
##    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
##    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
##    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
##    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
##    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
## 

# gcc -I /usr/local/share/dpdk//x86_64-native-linuxapp-gcc/include -c rte_error_wrapper.c
# ar rvs rte_error_wrapper.a rte_error_wrapper.o
# nim c --cincludes:./ -l:rte_error_wrapper.a --passC:\"$c_compiler_options\" --passL:\"$linker_options\" $nim_files

import os
import strutils

include "dpdk.nim"

const
  RX_RING_SIZE = 128.uint16
  TX_RING_SIZE* = 512.uint16
  NUM_MBUFS* = 8191.cuint
  MBUF_CACHE_SIZE* = 250.cuint
  BURST_SIZE* = 32.uint16

var port_conf_default: rte_eth_conf
port_conf_default.rxmode.max_rx_pkt_len = ETHER_MAX_LEN

var nb_ports: uint8

type
  latency_numbers_t = object
    total_cycles: uint64
    total_pkts:  uint64

var latency_numbers: latency_numbers_t

proc rte_eal_get_configuration*(): ptr rte_config = nil

# use exportc and cdecl pragma to export all C callbacks to C
proc add_timestamps(port: uint8; qidx: uint16; 
  pkts: ptr ptr rte_mbuf; nb_pkts: uint16; 
  max_pkts: uint16; _: pointer): uint16 {.exportc: "add_timestamps", cdecl.} =

  var i: cuint
  var now: uint64 = rte_rdtsc()
  i = 0
  while i < nb_pkts:

    var rte_mbuf_ptr: ptr rte_mbuf = 
      cast[ptr ptr rte_mbuf](cast[ByteAddress](pkts) + 
            (i.int*sizeof(pkts[])))[]

    rte_mbuf_ptr[].ano_100312171.udata64 = now

    inc(i)
  return nb_pkts

proc calc_latency(port: uint8; qidx: uint16; pkts: ptr ptr rte_mbuf;
  nb_pkts: uint16; _: pointer): uint16 
  {.exportc: "calc_latency", cdecl.} =

  var cycles: uint64 = 0
  var now: uint64 = rte_rdtsc()
  var i: cuint
  i = 0

  while i < nb_pkts:
    var rte_mbuf_ptr: ptr rte_mbuf = 
      cast[ptr ptr rte_mbuf](cast[ByteAddress](pkts) + 
            (i.int*sizeof(pkts[])))[]

    cycles += rte_mbuf_ptr[].ano_100312171.udata64;
    inc(i)

  latency_numbers.total_cycles += cycles
  latency_numbers.total_pkts += nb_pkts

  if latency_numbers.total_pkts > (100 * 1000 * 1000).uint64:
    echo "Latency = %", 
      latency_numbers.total_cycles div latency_numbers.total_pkts,
      " cycles\n"
           
    latency_numbers.total_cycles = 0
    latency_numbers.total_pkts = 0

  return nb_pkts

proc port_init(port: uint8; mbuf_pool: ptr rte_mempool): cint {.inline.} =
  var port_conf: rte_eth_conf = port_conf_default
  const
    rx_rings: uint16 = 1
    tx_rings: uint16 = 1

  var retval: cint
  var q: uint16

  if port >= rte_eth_dev_count():
    return - 1

  retval = rte_eth_dev_configure(port, rx_rings, tx_rings, addr(port_conf))

  if retval != 0:
    return retval

  echo "port = ", port, " rx_rings = ", rx_rings

  var socket_id: cuint = (rte_eth_dev_socket_id(port)).cuint
  while q < rx_rings:
    retval = rte_eth_rx_queue_setup(port, q,
      RX_RING_SIZE,
      socket_id, nil, mbuf_pool)

    if retval < 0:
      return retval

    inc(q)

  while q < tx_rings:
    retval = rte_eth_tx_queue_setup(port, q, 
      TX_RING_SIZE, socket_id, nil)

    if retval < 0:
      return retval

    inc(q)

  retval = rte_eth_dev_start(port)
  if retval < 0:
    return retval

  var `addr`: ether_addr
  rte_eth_macaddr_get(port, addr(`addr`))
  echo "Port ", port, " MAC: ", 
    intToStr((addr.addr_bytes[0]).int, 2), " ", 
    intToStr((addr.addr_bytes[1]).int, 2), " ",
    intToStr((addr.addr_bytes[2]).int, 2), " ",
    intToStr((addr.addr_bytes[3]).int, 2), " ",
    intToStr((addr.addr_bytes[4]).int, 2), " ",
    intToStr((addr.addr_bytes[5]).int, 2)

  rte_eth_promiscuous_enable(port)
  var void_ptr = rte_eth_add_rx_callback(port,
    0.uint16,
    add_timestamps,
    cast[pointer](nil))

  void_ptr = rte_eth_add_tx_callback(port,
    0.uint16,
    calc_latency,
    cast[pointer](nil))

  return 0

proc lcore_main() =
  var port: uint8
  port = 0
  while port < nb_ports:
    if rte_eth_dev_socket_id(port) > 0 and
       rte_eth_dev_socket_id(port) != (rte_socket_id()).cint:

      echo "WARNING, port ", port, " is on remote NUMA node to polling thread.\n\tPerformance will not be optimal.\n"
             
    inc(port)

  echo "\nCore ", rte_lcore_id(), " forwarding packets. [Ctrl+C to quit]\n"

  while true:
    port = 0
    while port < nb_ports:
      var bufs = newSeq[ptr rte_mbuf](BURST_SIZE)
      var pp_rte_mbuf: ptr ptr rte_mbuf =
        cast[ptr ptr rte_mbuf](bufs)

      var nb_rx: uint16 = rte_eth_rx_burst(port,
        0.uint16,
        pp_rte_mbuf,
        BURST_SIZE)

      if unlikely(nb_rx == 0):
        continue

      var nb_tx: uint16 = rte_eth_tx_burst(port xor 1,
        0.uint16,
        pp_rte_mbuf,
        nb_rx)

      if unlikely(nb_tx < nb_rx):
        var buf: uint16
        buf = nb_tx
        while buf < nb_rx:
          # get bufs[buf] from pp_rte_mbuf
          var p_rte_mbuf: ptr rte_mbuf =
            cast[ptr ptr rte_mbuf](cast[ByteAddress](pp_rte_mbuf) +
              (buf).int*sizeof(pp_rte_mbuf[]))[]

          rte_pktmbuf_free(p_rte_mbuf)
          inc(buf)

      inc(port)

proc go(argc: var cint; argv: var cstringArray): cint =
  var mbuf_pool: ptr rte_mempool
  var portid: uint8

  ##  init EAL
  var ret: cint = rte_eal_init(argc, argv)
  
  if ret < 0: 
    rte_exit(EXIT_FAILURE, "Error with EAL initialization\n")
  else:
    echo "rte_eal_init() ok"

  nb_ports = rte_eth_dev_count()
  echo "nb_ports = ", nb_ports
  if (nb_ports < 2) or (1 == (nb_ports and 1)):
    rte_exit(EXIT_FAILURE, "Error: number of ports must be even\n")

  var str: cstring = "MBUF_POOL"
  var socket_id: cint = (rte_socket_id()).cint

  mbuf_pool = rte_pktmbuf_pool_create(str,
    NUM_MBUFS * nb_ports.cuint,
    MBUF_CACHE_SIZE,
    0.uint16,
    RTE_MBUF_DEFAULT_BUF_SIZE.uint16,
    socket_id)

  if mbuf_pool == nil:
    # this is how we get rte_errno, and print out the message
    # we use get_rte_errno() from rte_error_wrapper.h
    echo "[", rte_strerror(get_rte_errno()), "]\n"
    rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n")
  else:
    echo "rte_pktmbuf_pool_create() ok\n"

  portid = 0
  while portid < nb_ports:
    if port_init(portid, mbuf_pool) != 0:
      rte_exit(EXIT_FAILURE, "Cannot init port " & $portid & "\n")
    inc(portid)

  if (rte_lcore_count()).int > 1:
    echo "\nWAWARNING: Too much enabled lcores - App uses only 1 lcore\n"

  lcore_main()
  return 0

when isMainModule:

  # convert argc and argv compatible with C's main()
  var argc: cint = (paramCount() + 1).cint

  var argv: cstringArray = allocCStringArray(["dummy"])

  var i = 0
  while i < argc:
    argv[i] = paramStr(i)
    inc(i)

  # we have go() instead of main()
  var ret: cint = go(argc, argv)

  deallocCStringArray(argv)
