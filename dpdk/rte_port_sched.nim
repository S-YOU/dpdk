type
  rte_port_sched_reader_params* {.importc: "struct rte_port_sched_reader_params", header: "rte_port_sched.h".} = object
    sched*: ptr rte_sched_port

  rte_port_sched_writer_params* {.importc: "struct rte_port_sched_writer_params", header: "rte_port_sched.h".} = object
    sched*: ptr rte_sched_port
    tx_burst_sz*: uint32

