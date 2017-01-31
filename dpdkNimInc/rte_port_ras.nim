type
  rte_port_ring_writer_ras_params* = object
    ring*: ptr rte_ring
    tx_burst_sz*: uint32

