type
  rte_table_lpm_params* {.importc: "struct rte_table_lpm_params", header: "rte_table_lpm.h".} = object
    name*: cstring
    n_rules*: uint32
    number_tbl8s*: uint32
    flags*: cint
    entry_unique_size*: uint32
    offset*: uint32

  rte_table_lpm_key* {.importc: "struct rte_table_lpm_key", header: "rte_table_lpm.h".} = object
    ip*: uint32
    depth*: uint8

