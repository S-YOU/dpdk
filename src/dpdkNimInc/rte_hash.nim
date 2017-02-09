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
  rte_hash_parameters* {.importc: "struct rte_hash_parameters", header: "rte_hash.h".} = object
    name*: cstring
    entries*: uint32
    reserved*: uint32
    key_len*: uint32
    hash_func*: rte_hash_function
    hash_func_init_val*: uint32
    socket_id*: cint
    extra_flag*: uint8

#  start lib/librte_hash/rte_cuckoo_hash.h

const
  LCORE_CACHE_SIZE* = 64
  RTE_HASH_BUCKET_ENTRIES* =  4

type
  add_key_case* = enum
    ADD_KEY_SINGLEWRITER = 0, ADD_KEY_MULTIWRITER, ADD_KEY_MULTIWRITER_TM

  cmp_jump_table_case* = enum
    KEY_CUSTOM = 0, KEY_16_BYTES, KEY_32_BYTES, KEY_48_BYTES, KEY_64_BYTES,
    KEY_80_BYTES, KEY_96_BYTES, KEY_112_BYTES, KEY_128_BYTES, KEY_OTHER_BYTES,
    NUM_KEY_CMP_CASES

  lcore_cache* {.importc: "struct lcore_cache", header: "cDecStructs.h".} = object
    len*: cuint                ## *< Cache len
    objs*: array[LCORE_CACHE_SIZE, pointer] ## *< Cache objects
  
  INNER_C_STRUCT_3131063974* = object
    current*: hash_sig_t
    alt*: hash_sig_t

  INNER_C_UNION_2350476769* = object {.union.}
    ano_3124053143*: INNER_C_STRUCT_3131063974
    sig*: uint64

  rte_hash_signatures* {.importc: "struct rte_hash_signatures", header: "cDecStructs.h".} = object
    ano_3140576151*: INNER_C_UNION_2350476769

  rte_hash_bucket* {.importc: "struct rte_hash_bucket", header: "cDecStructs.h".} = object
    signatures*: array[RTE_HASH_BUCKET_ENTRIES, rte_hash_signatures] ##  Includes dummy key index that always contains index 0
    key_idx*: array[RTE_HASH_BUCKET_ENTRIES + 1, uint32]
    flag*: array[RTE_HASH_BUCKET_ENTRIES, uint8]

  rte_hash* {.importc: "struct rte_hash", header: "cDecStructs.h".} = object
    name*: array[RTE_HASH_NAMESIZE, char] ## *< Name of the hash.
    entries*: uint32         ## *< Total table entries.
    num_buckets*: uint32     ## *< Number of buckets in table.
    key_len*: uint32         ## *< Length of hash key.
    hash_func*: rte_hash_function ## *< Function used to calculate hash.
    hash_func_init_val*: uint32 ## *< Init value used by hash_func.
    rte_hash_custom_cmp_eq*: rte_hash_cmp_eq_t ## *< Custom function used to compare keys.
    cmp_jump_table_idx*: cmp_jump_table_case ## *< Indicates which compare function to use.
    bucket_bitmask*: uint32  ## *< Bitmask for getting bucket index
                            ##             from hash signature.
    key_entry_size*: uint32  ## *< Size of each key entry.
    free_slots*: ptr rte_ring   ## *< Ring that stores all indexes
                           ##             of the free slots in the key table
    key_store*: pointer        ## *< Table storing all keys and data
    buckets*: ptr rte_hash_bucket ## *< Table with buckets storing all the
                               ##               hash values and key indexes
                               ##               to the key table
    hw_trans_mem_support*: uint8 ## *< Hardware transactional
                                 ##               memory support
    local_free_slots*: ptr lcore_cache ## *< Local cache per lcore, storing some indexes of the free slots
    add_key*: add_key_case     ## *< Multi-writer hash add behavior
    multiwriter_lock*: ptr rte_spinlock_t ## *< Multi-writer spinlock for w/o TM
  
# end lib/librte_hash/rte_cuckoo_hash.h 

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
