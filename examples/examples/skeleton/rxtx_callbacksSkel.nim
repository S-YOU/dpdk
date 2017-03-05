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

import os
import strutils

import "dpdk"

const
  RX_RING_SIZE = 128.uint16
  TX_RING_SIZE* = 512.uint16
  NUM_MBUFS* = 8191.cuint
  MBUF_CACHE_SIZE* = 250.cuint
  BURST_SIZE* = 32.uint16

var nb_ports: uint8

proc port_init(port: uint8; mbuf_pool: ptr rte_mempool): cint {.exportc: "port_init", cdecl.} =

  var port_conf_default: rte_eth_conf
  port_conf_default.rxmode.max_rx_pkt_len = ETHER_MAX_LEN

  var port_conf: rte_eth_conf = port_conf_default

  const
    rx_rings: uint16 = 1
    tx_rings: uint16 = 1

  var retval: cint


  if port >= rte_eth_dev_count():
    return - 1

  retval = rte_eth_dev_configure(port, rx_rings, tx_rings, addr(port_conf))

  if retval != 0:
    return retval
  else:
    echo "rte_eth_dev_configure() ok"

  var q: uint16 = 0
  var socket_id: cuint = (rte_eth_dev_socket_id(port)).cuint
  while q < rx_rings:
    retval = rte_eth_rx_queue_setup(port, q,
      RX_RING_SIZE,
      socket_id, nil, mbuf_pool)

    if retval < 0:
      return retval

    inc(q)

  # always make sure to reset our counters
  q = 0
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
  return 0

proc lcore_main() {.exportc: "lcore_main", cdecl.} =
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

      var bufs: array[BURST_SIZE, ptr rte_mbuf]

      var nb_rx: uint16 = rte_eth_rx_burst(port,
        0.uint16,
        bufs[0].addr,
    
        BURST_SIZE)

      if 0.uint16 != nb_rx:
        echo "nb_rx = ", nb_rx

      if unlikely(nb_rx == 0):
        continue

      var ind = 0.uint16
      while ind< nb_rx:
        inc(ind)

      var nb_tx: uint16 = rte_eth_tx_burst(port xor 1,
        0.uint16,
        bufs[0].addr,
        nb_rx)

      echo "nb_tx = ", nb_tx
      
      if unlikely(nb_tx < nb_rx):
        var buf: uint16
        echo "D"

        buf = nb_tx
        while buf < nb_rx:
          rte_pktmbuf_free(bufs[buf][].addr)
          inc(buf)

      inc(port)

proc go(argc: var cint; argv: var cstringArray): cint =
  var mbuf_pool: ptr rte_mempool
  var portid: uint8

  ##  init EAL
  var ret: cint = rte_eal_init(argc, argv)
  echo "argc = ", argc, "argv[0], 1 = ", argv[0], ", ", argv[1]
  
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

  echo "\nhere = ", NUM_MBUFS * nb_ports.cuint, ", ", 
    MBUF_CACHE_SIZE, ", ",
    0.uint16, ", ",
    RTE_MBUF_DEFAULT_BUF_SIZE.uint16, ", ",
    socket_id

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
    echo "\nport_init() portid = ", portid
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
