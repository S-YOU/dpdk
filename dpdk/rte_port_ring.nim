type
  rte_port_ring_reader_params* {.importc: "struct rte_port_ring_reader_params", header: "rte_port_ring.h".} = object
    ring*: ptr rte_ring

  rte_port_ring_writer_params* {.importc: "struct rte_port_ring_writer_params", header: "rte_port_ring.h".} = object
    ring*: ptr rte_ring
    tx_burst_sz*: uint32

  rte_port_ring_writer_nodrop_params* {.importc: "struct rte_port_ring_writer_nodrop_params", header: "rte_port_ring.h".} = object
    ring*: ptr rte_ring
    tx_burst_sz*: uint32
    n_retries*: uint32

