type
  rte_table_stats* {.importc: "struct rte_table_stats", header: "rte_table.h".} = object
    n_pkts_in*: uint64
    n_pkts_lookup_miss*: uint64

  rte_table_op_create* = proc (params: pointer; socket_id: cint; entry_size: uint32): pointer {.cdecl.}
  rte_table_op_free* = proc (table: pointer): cint {.cdecl.}
  rte_table_op_entry_add* = proc (table: pointer; key: pointer; entry: pointer;
                               key_found: ptr cint; entry_ptr: ptr pointer): cint {.cdecl.}
  rte_table_op_entry_delete* = proc (table: pointer; key: pointer; key_found: ptr cint;
                                  entry: pointer): cint {.cdecl.}
  rte_table_op_entry_add_bulk* = proc (table: pointer; keys: ptr pointer;
                                    entries: ptr pointer; n_keys: uint32;
                                    key_found: ptr cint; entries_ptr: ptr pointer): cint {.cdecl.}
  rte_table_op_entry_delete_bulk* = proc (table: pointer; keys: ptr pointer;
                                       n_keys: uint32; key_found: ptr cint;
                                       entries: ptr pointer): cint {.cdecl.}
  rte_table_op_lookup* = proc (table: pointer; pkts: ptr ptr rte_mbuf;
                            pkts_mask: uint64; lookup_hit_mask: ptr uint64;
                            entries: ptr pointer): cint {.cdecl.}
  rte_table_op_stats_read* = proc (table: pointer; stats: ptr rte_table_stats;
                                clear: cint): cint {.cdecl.}
  rte_table_ops* = object
    f_create*: rte_table_op_create
    f_free*: rte_table_op_free
    f_add*: rte_table_op_entry_add
    f_delete*: rte_table_op_entry_delete
    f_add_bulk*: rte_table_op_entry_add_bulk
    f_delete_bulk*: rte_table_op_entry_delete_bulk
    f_lookup*: rte_table_op_lookup
    f_stats*: rte_table_op_stats_read

