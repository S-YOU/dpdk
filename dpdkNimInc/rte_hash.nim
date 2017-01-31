const
  RTE_HASH_ENTRIES_MAX* = (1 shl 30)
  RTE_HASH_NAMESIZE* = 32
  RTE_HASH_LOOKUP_BULK_MAX* = 64
  RTE_HASH_LOOKUP_MULTI_MAX* = RTE_HASH_LOOKUP_BULK_MAX
  RTE_HASH_EXTRA_FLAGS_TRANS_MEM_SUPPORT* = 0x00000001
  RTE_HASH_EXTRA_FLAGS_MULTI_WRITER_ADD* = 0x00000002

type
  hash_sig_t* = uint32
  rte_hash_function* = proc (key: pointer; key_len: uint32; init_val: uint32): uint32 {.cdecl.}
  rte_hash_cmp_eq_t* = proc (key1: pointer; key2: pointer; key_len: csize): cint {.cdecl.}
  rte_hash_parameters* = object
    name*: cstring
    entries*: uint32
    reserved*: uint32
    key_len*: uint32
    hash_func*: rte_hash_function
    hash_func_init_val*: uint32
    socket_id*: cint
    extra_flag*: uint8

  rte_hash* = object
  

proc rte_hash_create*(params: ptr rte_hash_parameters): ptr rte_hash {.importc, header: "rte_hash.h".}
proc rte_hash_set_cmp_func*(h: ptr rte_hash; `func`: rte_hash_cmp_eq_t) {.importc, header: "rte_hash.h".}
proc rte_hash_find_existing*(name: cstring): ptr rte_hash {.importc, header: "rte_hash.h".}
proc rte_hash_free*(h: ptr rte_hash) {.importc, header: "rte_hash.h".}
proc rte_hash_reset*(h: ptr rte_hash) {.importc, header: "rte_hash.h".}
proc rte_hash_add_key_data*(h: ptr rte_hash; key: pointer; data: pointer): cint {.importc, header: "rte_hash.h".}
proc rte_hash_add_key_with_hash_data*(h: ptr rte_hash; key: pointer; sig: hash_sig_t;
                                     data: pointer): int32 {.importc, header: "rte_hash.h".}
proc rte_hash_add_key*(h: ptr rte_hash; key: pointer): int32 {.importc, header: "rte_hash.h".}
proc rte_hash_add_key_with_hash*(h: ptr rte_hash; key: pointer; sig: hash_sig_t): int32 {.importc, header: "rte_hash.h".}
proc rte_hash_del_key*(h: ptr rte_hash; key: pointer): int32 {.importc, header: "rte_hash.h".}
proc rte_hash_del_key_with_hash*(h: ptr rte_hash; key: pointer; sig: hash_sig_t): int32 {.importc, header: "rte_hash.h".}
proc rte_hash_get_key_with_position*(h: ptr rte_hash; position: int32;
                                    key: ptr pointer): cint {.importc, header: "rte_hash.h".}
proc rte_hash_lookup_data*(h: ptr rte_hash; key: pointer; data: ptr pointer): cint {.importc, header: "rte_hash.h".}
proc rte_hash_lookup_with_hash_data*(h: ptr rte_hash; key: pointer; sig: hash_sig_t;
                                    data: ptr pointer): cint {.importc, header: "rte_hash.h".}
proc rte_hash_lookup*(h: ptr rte_hash; key: pointer): int32 {.importc, header: "rte_hash.h".}
proc rte_hash_lookup_with_hash*(h: ptr rte_hash; key: pointer; sig: hash_sig_t): int32 {.importc, header: "rte_hash.h".}
proc rte_hash_hash*(h: ptr rte_hash; key: pointer): hash_sig_t {.importc, header: "rte_hash.h".}
proc rte_hash_lookup_bulk_data*(h: ptr rte_hash; keys: ptr pointer; num_keys: uint32;
                               hit_mask: ptr uint64; data: ptr pointer): cint {.importc, header: "rte_hash.h".}
proc rte_hash_lookup_bulk*(h: ptr rte_hash; keys: ptr pointer; num_keys: uint32;
                          positions: ptr int32): cint {.importc, header: "rte_hash.h".}
proc rte_hash_iterate*(h: ptr rte_hash; key: ptr pointer; data: ptr pointer;
                      next: ptr uint32): int32 {.importc, header: "rte_hash.h".}
