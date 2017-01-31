type
  rte_table_acl_params* = object
    name*: cstring
    n_rules*: uint32
    n_rule_fields*: uint32
    field_format*: array[64, rte_acl_field_def]

  rte_table_acl_rule_add_params* = object
    priority*: int32
    field_value*: array[64, rte_acl_field]

  rte_table_acl_rule_delete_params* = object
    field_value*: array[64, rte_acl_field]

