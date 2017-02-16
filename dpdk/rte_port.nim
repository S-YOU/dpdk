const
  RTE_PORT_IN_BURST_SIZE_MAX* = 64

type
  rte_port_in_stats* {.importc: "struct rte_port_in_stats", header: "rte_port.h".} = object
    n_pkts_in*: uint64
    n_pkts_drop*: uint64

  rte_port_in_op_create* = proc (params: pointer; socket_id: cint): pointer {.cdecl.}
  rte_port_in_op_free* = proc (port: pointer): cint {.cdecl.}
  rte_port_in_op_rx* = proc (port: pointer; pkts: ptr ptr rte_mbuf; n_pkts: uint32): cint {.cdecl.}
  rte_port_in_op_stats_read* = proc (port: pointer; stats: ptr rte_port_in_stats;
                                  clear: cint): cint {.cdecl.}
  rte_port_in_ops* {.importc: "struct rte_port_in_ops", header: "rte_port.h".} = object
    f_create*: rte_port_in_op_create
    f_free*: rte_port_in_op_free
    f_rx*: rte_port_in_op_rx
    f_stats*: rte_port_in_op_stats_read

  rte_port_out_stats* {.importc: "struct rte_port_out_stats", header: "rte_port.h".} = object
    n_pkts_in*: uint64
    n_pkts_drop*: uint64

  rte_port_out_op_create* = proc (params: pointer; socket_id: cint): pointer {.cdecl.}
  rte_port_out_op_free* = proc (port: pointer): cint {.cdecl.}
  rte_port_out_op_tx* = proc (port: pointer; pkt: ptr rte_mbuf): cint {.cdecl.}
  rte_port_out_op_tx_bulk* = proc (port: pointer; pkt: ptr ptr rte_mbuf;
                                pkts_mask: uint64): cint {.cdecl.}
  rte_port_out_op_flush* = proc (port: pointer): cint {.cdecl.}
  rte_port_out_op_stats_read* = proc (port: pointer; stats: ptr rte_port_out_stats;
                                   clear: cint): cint {.cdecl.}
  rte_port_out_ops* {.importc: "struct rte_port_out_ops", header: "rte_port.h".} = object
    f_create*: rte_port_out_op_create
    f_free*: rte_port_out_op_free
    f_tx*: rte_port_out_op_tx
    f_tx_bulk*: rte_port_out_op_tx_bulk
    f_flush*: rte_port_out_op_flush
    f_stats*: rte_port_out_op_stats_read

