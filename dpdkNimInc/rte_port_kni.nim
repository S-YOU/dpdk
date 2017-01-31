type
  rte_port_kni_reader_params* = object
    kni*: ptr rte_kni

  rte_port_kni_writer_params* = object
    kni*: ptr rte_kni
    tx_burst_sz*: uint32

  rte_port_kni_writer_nodrop_params* = object
    kni*: ptr rte_kni
    tx_burst_sz*: uint32
    n_retries*: uint32

