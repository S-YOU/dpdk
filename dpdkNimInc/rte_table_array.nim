type
  rte_table_array_params* {.importc: "struct rte_table_array_params", header: "rte_table_array.h".} = object
    n_entries*: uint32
    offset*: uint32

  rte_table_array_key* {.importc: "struct rte_table_array_key", header: "rte_table_array.h".} = object
    pos*: uint32

