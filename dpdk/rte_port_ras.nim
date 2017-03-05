type
  rte_port_ring_writer_ras_params* {.importc: "struct rte_port_ring_writer_ras_params", header: "rte_port_ras.h".} = object
    ring*: ptr rte_ring
    tx_burst_sz*: uint32

