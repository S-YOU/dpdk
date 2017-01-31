type
  rte_table_hash_op_hash* = proc (key: pointer; key_size: uint32; seed: uint64): uint64 {.cdecl.}
  rte_table_hash_ext_params* = object
    key_size*: uint32
    n_keys*: uint32
    n_buckets*: uint32
    n_buckets_ext*: uint32
    f_hash*: rte_table_hash_op_hash
    seed*: uint64
    signature_offset*: uint32
    key_offset*: uint32

  rte_table_hash_lru_params* = object
    key_size*: uint32
    n_keys*: uint32
    n_buckets*: uint32
    f_hash*: rte_table_hash_op_hash
    seed*: uint64
    signature_offset*: uint32
    key_offset*: uint32

  rte_table_hash_key8_lru_params* = object
    n_entries*: uint32
    f_hash*: rte_table_hash_op_hash
    seed*: uint64
    signature_offset*: uint32
    key_offset*: uint32
    key_mask*: ptr uint8

  rte_table_hash_key8_ext_params* = object
    n_entries*: uint32
    n_entries_ext*: uint32
    f_hash*: rte_table_hash_op_hash
    seed*: uint64
    signature_offset*: uint32
    key_offset*: uint32
    key_mask*: ptr uint8

  rte_table_hash_key16_lru_params* = object
    n_entries*: uint32
    f_hash*: rte_table_hash_op_hash
    seed*: uint64
    signature_offset*: uint32
    key_offset*: uint32
    key_mask*: ptr uint8

  rte_table_hash_key16_ext_params* = object
    n_entries*: uint32
    n_entries_ext*: uint32
    f_hash*: rte_table_hash_op_hash
    seed*: uint64
    signature_offset*: uint32
    key_offset*: uint32
    key_mask*: ptr uint8

  rte_table_hash_key32_lru_params* = object
    n_entries*: uint32
    f_hash*: rte_table_hash_op_hash
    seed*: uint64
    signature_offset*: uint32
    key_offset*: uint32

  rte_table_hash_key32_ext_params* = object
    n_entries*: uint32
    n_entries_ext*: uint32
    f_hash*: rte_table_hash_op_hash
    seed*: uint64
    signature_offset*: uint32
    key_offset*: uint32

