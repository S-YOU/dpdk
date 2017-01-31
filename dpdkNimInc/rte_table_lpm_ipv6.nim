type
  rte_table_lpm_ipv6_params* = object
    name*: cstring
    n_rules*: uint32
    number_tbl8s*: uint32
    entry_unique_size*: uint32
    offset*: uint32

  rte_table_lpm_ipv6_key* = object
    ip*: array[16, uint8]
    depth*: uint8

