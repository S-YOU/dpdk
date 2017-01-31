const
  RTE_FBK_HASH_INIT_VAL_DEFAULT* = 0xFFFFFFFF
  RTE_FBK_HASH_ENTRIES_MAX* = (1 shl 20)
  RTE_FBK_HASH_ENTRIES_PER_BUCKET_MAX* = 256
  RTE_FBK_HASH_NAMESIZE* = 32

type
  rte_fbk_hash_fn* = proc (key: uint32; init_val: uint32): uint32 {.cdecl.}
  rte_fbk_hash_params* = object
    name*: cstring
    entries*: uint32
    entries_per_bucket*: uint32
    socket_id*: cint
    hash_func*: rte_fbk_hash_fn
    init_val*: uint32

  INNER_C_STRUCT_1465896896* = object
    is_entry*: uint16
    value*: uint16
    key*: uint32

  rte_fbk_hash_entry* = object {.union.}
    whole_entry*: uint64
    entry*: INNER_C_STRUCT_1465896896

  rte_fbk_hash_table* = object
    name*: array[32, char]
    entries*: uint32
    entries_per_bucket*: uint32
    used_entries*: uint32
    bucket_mask*: uint32
    bucket_shift*: uint32
    hash_func*: rte_fbk_hash_fn
    init_val*: uint32
    t*: array[0, rte_fbk_hash_entry]


proc rte_fbk_hash_get_bucket*(ht: ptr rte_fbk_hash_table; key: uint32): uint32 {.inline, importc, header: "rte_fbk_hash.h".}

proc rte_fbk_hash_add_key_with_bucket*(ht: ptr rte_fbk_hash_table; key: uint32;
                                      value: uint16; bucket: uint32): cint {.inline, importc, header: "rte_fbk_hash.h".}

proc rte_fbk_hash_add_key*(ht: ptr rte_fbk_hash_table; key: uint32; value: uint16): cint {.inline, importc, header: "rte_fbk_hash.h".}

proc rte_fbk_hash_delete_key_with_bucket*(ht: ptr rte_fbk_hash_table; key: uint32;
    bucket: uint32): cint {.inline, importc, header: "rte_fbk_hash.h".}
proc rte_fbk_hash_delete_key*(ht: ptr rte_fbk_hash_table; key: uint32): cint {.inline, importc, header: "rte_fbk_hash.h".}
proc rte_fbk_hash_lookup_with_bucket*(ht: ptr rte_fbk_hash_table; key: uint32;
                                     bucket: uint32): cint {.inline, importc, header: "rte_fbk_hash.h".}
proc rte_fbk_hash_lookup*(ht: ptr rte_fbk_hash_table; key: uint32): cint {.inline, importc, header: "rte_fbk_hash.h".}
proc rte_fbk_hash_clear_all*(ht: ptr rte_fbk_hash_table) {.inline, importc, header: "rte_fbk_hash.h".}
proc rte_fbk_hash_get_load_factor*(ht: ptr rte_fbk_hash_table): cdouble {.inline, importc, header: "rte_fbk_hash.h".}
proc rte_fbk_hash_find_existing*(name: cstring): ptr rte_fbk_hash_table {.importc, header: "rte_fbk_hash.h".}
proc rte_fbk_hash_create*(params: ptr rte_fbk_hash_params): ptr rte_fbk_hash_table {.importc, header: "rte_fbk_hash.h".}
proc rte_fbk_hash_free*(ht: ptr rte_fbk_hash_table) {.importc, header: "rte_fbk_hash.h".}
