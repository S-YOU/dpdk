type
  rte_port_source_params* = object
    mempool*: ptr rte_mempool
    file_name*: cstring
    n_bytes_per_pkt*: uint32

  rte_port_sink_params* = object
    file_name*: cstring
    max_n_pkts*: uint32

