const
  RTE_PIPELINE_TABLE_MAX* = 64
  RTE_PIPELINE_PORT_IN_MAX* = 64
  RTE_PIPELINE_PORT_OUT_MAX* = 64

const
  RTE_PIPELINE_MAX_NAME_SZ* = 124

type
  rte_pipeline_action* = enum
    RTE_PIPELINE_ACTION_DROP = 0, RTE_PIPELINE_ACTION_PORT,
    RTE_PIPELINE_ACTION_PORT_META, RTE_PIPELINE_ACTION_TABLE, RTE_PIPELINE_ACTIONS

  INNER_C_UNION_771960961* = object {.union.}
    port_id*: uint32
    table_id*: uint32

  rte_pipeline_table_entry* {.importc: "struct rte_pipeline_table_entry", header: "rte_pipeline.h".} = object
    action*: rte_pipeline_action
    ano_1840054312*: INNER_C_UNION_771960961
    action_data*: array[0, uint8]

  rte_pipeline_port_in_action_handler* = proc (p: ptr rte_pipeline;
      pkts: ptr ptr rte_mbuf; n: uint32; arg: pointer): cint {.cdecl.}

  rte_pipeline_port_out_action_handler* = proc (p: ptr rte_pipeline;
      pkts: ptr ptr rte_mbuf; pkts_mask: uint64; arg: pointer): cint {.cdecl.}

  rte_pipeline_table_action_handler_hit* = proc (p: ptr rte_pipeline;
      pkts: ptr ptr rte_mbuf; pkts_mask: uint64;
      entries: ptr ptr rte_pipeline_table_entry; arg: pointer): cint {.cdecl.}

  rte_pipeline_table_action_handler_miss* = proc (p: ptr rte_pipeline;
      pkts: ptr ptr rte_mbuf; pkts_mask: uint64;
      entry: ptr rte_pipeline_table_entry; arg: pointer): cint {.cdecl.}

# from lib/librte_pipeline/rte_pipeline.c
  rte_port_in* = object
    ops*: rte_port_in_ops      ##  Input parameters
    f_action*: rte_pipeline_port_in_action_handler
    arg_ah*: pointer
    burst_size*: uint32      ##  The table to which this port is connected
    table_id*: uint32        ##  Handle to low-level port
    h_port*: pointer           ##  List of enabled ports
    next*: ptr rte_port_in      ##  Statistics
    n_pkts_dropped_by_ah*: uint64

  rte_port_out* = object
    ops*: rte_port_out_ops     ##  Input parameters
    f_action*: rte_pipeline_port_out_action_handler
    arg_ah*: pointer           ##  Handle to low-level port
    h_port*: pointer           ##  Statistics
    n_pkts_dropped_by_ah*: uint64

  rte_table* = object
    ops*: rte_table_ops        ##  Input parameters
    f_action_hit*: rte_pipeline_table_action_handler_hit
    f_action_miss*: rte_pipeline_table_action_handler_miss
    arg_ah*: pointer
    default_entry*: ptr rte_pipeline_table_entry
    entry_size*: uint32
    table_next_id*: uint32
    table_next_id_valid*: uint32 ##  Handle to the low-level table object
    h_table*: pointer          ##  Statistics
    n_pkts_dropped_by_lkp_hit_ah*: uint64
    n_pkts_dropped_by_lkp_miss_ah*: uint64
    n_pkts_dropped_lkp_hit*: uint64
    n_pkts_dropped_lkp_miss*: uint64

  rte_pipeline* = object
    name*: array[RTE_PIPELINE_MAX_NAME_SZ, char] ##  Input parameters
    socket_id*: cint
    offset_port_id*: uint32  ##  Internal tables
    ports_in*: array[RTE_PIPELINE_PORT_IN_MAX, rte_port_in]
    ports_out*: array[RTE_PIPELINE_PORT_OUT_MAX, rte_port_out]
    tables*: array[RTE_PIPELINE_TABLE_MAX, rte_table] ##  Occupancy of internal tables
    num_ports_in*: uint32
    num_ports_out*: uint32
    num_tables*: uint32      ##  List of enabled ports
    enabled_port_in_mask*: uint64
    port_in_next*: ptr rte_port_in ##  Pipeline run structures
    pkts*: array[RTE_PORT_IN_BURST_SIZE_MAX, ptr rte_mbuf]
    entries*: array[RTE_PORT_IN_BURST_SIZE_MAX, ptr rte_pipeline_table_entry]
    action_mask0*: array[RTE_PIPELINE_ACTIONS, uint64]
    action_mask1*: array[RTE_PIPELINE_ACTIONS, uint64]
    pkts_mask*: uint64
    n_pkts_ah_drop*: uint64
    pkts_drop_mask*: uint64

  rte_pipeline_params* {.importc: "struct rte_pipeline_params", header: "rte_pipeline.h".} = object
    name*: cstring
    socket_id*: cint
    offset_port_id*: uint32

  rte_pipeline_port_in_stats* {.importc: "struct rte_pipeline_port_in_stats", header: "rte_pipeline.h".} = object
    stats*: rte_port_in_stats
    n_pkts_dropped_by_ah*: uint64

  rte_pipeline_port_out_stats* {.importc: "struct rte_pipeline_port_out_stats", header: "rte_pipeline.h".} = object
    stats*: rte_port_out_stats
    n_pkts_dropped_by_ah*: uint64

  rte_pipeline_table_stats* {.importc: "struct rte_pipeline_table_stats", header: "rte_pipeline.h".} = object
    stats*: rte_table_stats
    n_pkts_dropped_by_lkp_hit_ah*: uint64
    n_pkts_dropped_by_lkp_miss_ah*: uint64
    n_pkts_dropped_lkp_hit*: uint64
    n_pkts_dropped_lkp_miss*: uint64


proc rte_pipeline_create*(params: ptr rte_pipeline_params): ptr rte_pipeline {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_free*(p: ptr rte_pipeline): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_check*(p: ptr rte_pipeline): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_run*(p: ptr rte_pipeline): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_flush*(p: ptr rte_pipeline): cint {.importc, header: "rte_pipeline.h".}
type



  rte_pipeline_table_params* = object
    ops*: ptr rte_table_ops
    arg_create*: pointer
    f_action_hit*: rte_pipeline_table_action_handler_hit
    f_action_miss*: rte_pipeline_table_action_handler_miss
    arg_ah*: pointer
    action_data_size*: uint32


proc rte_pipeline_table_create*(p: ptr rte_pipeline;
                               params: ptr rte_pipeline_table_params;
                               table_id: ptr uint32): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_table_default_entry_add*(p: ptr rte_pipeline; table_id: uint32;
    default_entry: ptr rte_pipeline_table_entry;
    default_entry_ptr: ptr ptr rte_pipeline_table_entry): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_table_default_entry_delete*(p: ptr rte_pipeline;
    table_id: uint32; entry: ptr rte_pipeline_table_entry): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_table_entry_add*(p: ptr rte_pipeline; table_id: uint32;
                                  key: pointer;
                                  entry: ptr rte_pipeline_table_entry;
                                  key_found: ptr cint;
                                  entry_ptr: ptr ptr rte_pipeline_table_entry): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_table_entry_delete*(p: ptr rte_pipeline; table_id: uint32;
                                     key: pointer; key_found: ptr cint;
                                     entry: ptr rte_pipeline_table_entry): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_table_entry_add_bulk*(p: ptr rte_pipeline; table_id: uint32;
                                       keys: ptr pointer; entries: ptr ptr rte_pipeline_table_entry;
                                       n_keys: uint32; key_found: ptr cint;
    entries_ptr: ptr ptr rte_pipeline_table_entry): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_table_entry_delete_bulk*(p: ptr rte_pipeline; table_id: uint32;
    keys: ptr pointer; n_keys: uint32; key_found: ptr cint;
    entries: ptr ptr rte_pipeline_table_entry): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_table_stats_read*(p: ptr rte_pipeline; table_id: uint32;
                                   stats: ptr rte_pipeline_table_stats; clear: cint): cint {.importc, header: "rte_pipeline.h".}
type
  rte_pipeline_port_in_params* = object
    ops*: ptr rte_port_in_ops
    arg_create*: pointer
    f_action*: rte_pipeline_port_in_action_handler
    arg_ah*: pointer
    burst_size*: uint32


proc rte_pipeline_port_in_create*(p: ptr rte_pipeline;
                                 params: ptr rte_pipeline_port_in_params;
                                 port_id: ptr uint32): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_port_in_connect_to_table*(p: ptr rte_pipeline; port_id: uint32;
    table_id: uint32): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_port_in_enable*(p: ptr rte_pipeline; port_id: uint32): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_port_in_disable*(p: ptr rte_pipeline; port_id: uint32): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_port_in_stats_read*(p: ptr rte_pipeline; port_id: uint32;
                                     stats: ptr rte_pipeline_port_in_stats;
                                     clear: cint): cint {.importc, header: "rte_pipeline.h".}
type
  rte_pipeline_port_out_params* = object
    ops*: ptr rte_port_out_ops
    arg_create*: pointer
    f_action*: rte_pipeline_port_out_action_handler
    arg_ah*: pointer


proc rte_pipeline_port_out_create*(p: ptr rte_pipeline;
                                  params: ptr rte_pipeline_port_out_params;
                                  port_id: ptr uint32): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_port_out_stats_read*(p: ptr rte_pipeline; port_id: uint32;
                                      stats: ptr rte_pipeline_port_out_stats;
                                      clear: cint): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_port_out_packet_insert*(p: ptr rte_pipeline; port_id: uint32;
    pkt: ptr rte_mbuf): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_ah_packet_hijack*(p: ptr rte_pipeline; pkts_mask: uint64): cint {.importc, header: "rte_pipeline.h".}
proc rte_pipeline_ah_packet_drop*(p: ptr rte_pipeline; pkts_mask: uint64): cint {.importc, header: "rte_pipeline.h".}
