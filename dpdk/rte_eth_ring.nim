proc rte_eth_from_rings*(name: cstring; rx_queues: ptr ptr rte_ring;
                        nb_rx_queues: cuint; tx_queues: ptr ptr rte_ring;
                        nb_tx_queues: cuint; numa_node: cuint): cint {.importc, header: "rte_eth_ring.h".}
proc rte_eth_from_ring*(r: ptr rte_ring): cint {.importc, header: "rte_eth_ring.h".}
