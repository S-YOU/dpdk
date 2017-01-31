# orig rte_port_sched.nim
type
  rte_port_sched_reader_params* = object
    sched*: ptr rte_sched_port

  rte_port_sched_writer_params* = object
    sched*: ptr rte_sched_port
    tx_burst_sz*: uint32

