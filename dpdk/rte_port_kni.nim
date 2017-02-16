type
  rte_port_kni_reader_params* {.importc: "struct rte_port_kni_reader_params", header: "rte_port_kni.h".} = object
    kni*: ptr rte_kni

  rte_port_kni_writer_params* {.importc: "struct rte_port_kni_writer_params", header: "rte_port_kni.h".} = object
    kni*: ptr rte_kni
    tx_burst_sz*: uint32

  rte_port_kni_writer_nodrop_params* {.importc: "struct rte_port_kni_writer_nodrop_params", header: "rte_port_kni.h".} = object
    kni*: ptr rte_kni
    tx_burst_sz*: uint32
    n_retries*: uint32

