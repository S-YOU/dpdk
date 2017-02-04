const
  RTE_ACL_MAX_CATEGORIES* = 16
  RTE_ACL_RESULTS_MULTIPLIER* = (XMM_SIZE div sizeof((uint32)))
  RTE_ACL_MAX_LEVELS* = 64
  RTE_ACL_MAX_FIELDS* = 64
  RTE_ACL_INVALID_USERDATA* = 0
  RTE_ACL_NAMESIZE* = 32

type
  rte_acl_field_types* {.importc: "union rte_acl_field_types", header: "rte_acl.h".} = object {.union.}
    u8*: uint8
    u16*: uint16
    u32*: uint32
    u64*: uint64


const
  RTE_ACL_FIELD_TYPE_MASK* = 0
  RTE_ACL_FIELD_TYPE_RANGE* = 1
  RTE_ACL_FIELD_TYPE_BITMASK* = 2

type
  rte_acl_field_def* {.importc: "union rte_acl_field_def", header: "rte_acl.h".} = object
    `type`*: uint8
    size*: uint8
    field_index*: uint8
    input_index*: uint8
    offset*: uint32

  rte_acl_config* {.importc: "union rte_acl_config", header: "rte_acl.h".} = object
    num_categories*: uint32
    num_fields*: uint32
    defs*: array[64, rte_acl_field_def]
    max_size*: csize

  rte_acl_field* {.importc: "union rte_acl_field", header: "rte_acl.h".} = object
    value*: rte_acl_field_types
    mask_range*: rte_acl_field_types


const
  RTE_ACL_TYPE_SHIFT* = 29
  RTE_ACL_MAX_INDEX* = 536870911
  RTE_ACL_MAX_PRIORITY* = RTE_ACL_MAX_INDEX
  RTE_ACL_MIN_PRIORITY* = 0

type
  rte_acl_rule_data* {.importc: "union rte_acl_rule_data", header: "rte_acl.h".} = object
    category_mask*: uint32
    priority*: int32
    userdata*: uint32

  rte_acl_rule* = object
    data*: rte_acl_rule_data
    field*: array[0, rte_acl_field]

  rte_acl_param* {.importc: "union rte_acl_param", header: "rte_acl.h".} = object
    name*: cstring
    socket_id*: cint
    rule_size*: uint32
    max_rule_num*: uint32

  rte_acl_classify_alg* = enum
    RTE_ACL_CLASSIFY_DEFAULT = 0, RTE_ACL_CLASSIFY_SCALAR = 1,
    RTE_ACL_CLASSIFY_SSE = 2, RTE_ACL_CLASSIFY_AVX2 = 3, RTE_ACL_CLASSIFY_NEON = 4,
    RTE_ACL_CLASSIFY_NUM

## lib/librte_acl/acl.h
## * MAX number of tries per one ACL context.
type
  bits_t* = cint

const
  RTE_ACL_MAX_TRIES* = 8

## * Max number of characters in PM name.

const
  RTE_ACL_DFA_SIZE* = (UINT8_MAX + 1)
  RTE_ACL_QUAD_SIZE* = 4
  RTE_ACL_DFA_GR64_SIZE* = 64
  RTE_ACL_DFA_GR64_NUM* = (RTE_ACL_DFA_SIZE div RTE_ACL_DFA_GR64_SIZE)
  RTE_ACL_BIT_SET_SIZE = 8

type
  rte_acl_bitset* = object
    bits*: array[RTE_ACL_BIT_SET_SIZE, bits_t]

  rte_acl_ptr_set* = object
    values*: rte_acl_bitset    ##  input values associated with ptr
    `ptr`*: ptr rte_acl_node    ##  transition to next node
  
  rte_acl_match_results* = object
    results*: array[RTE_ACL_MAX_CATEGORIES, uint32]
    priority*: array[RTE_ACL_MAX_CATEGORIES, int32]

  INNER_C_UNION_3260750428* = object {.union.}
    transitions*: array[RTE_ACL_QUAD_SIZE, char] ##  boundaries for ranged node
    dfa_gr64*: array[RTE_ACL_DFA_GR64_NUM, uint8]

  rte_acl_node* = object
    node_index*: uint64      ##  index for this node
    level*: uint32           ##  level 0-n in the trie
    ref_count*: uint32       ##  ref count for this node
    values*: rte_acl_bitset    ##  set of all values that map to another node
                          ##  (union of bits in each transition.
                          ## 
    num_ptrs*: uint32        ##  number of ptr_set in use
    max_ptrs*: uint32        ##  number of allocated ptr_set
    min_add*: uint32         ##  number of ptr_set per allocation
    ptrs*: ptr rte_acl_ptr_set  ##  transitions array for this node
    match_flag*: int32
    match_index*: int32      ##  index to match data
    node_type*: uint32
    fanout*: int32           ##  number of ranges (transitions w/ consecutive bits)
    id*: int32
    mrt*: ptr rte_acl_match_results ##  only valid when match_flag != 0
    ano_3285534940*: INNER_C_UNION_3260750428
    next*: ptr rte_acl_node     ##  free list link or pointer to duplicate node during merge
    prev*: ptr rte_acl_node     ##  points to node from which this node was duplicated
  
  rte_acl_trie* = object
    `type`*: uint32
    count*: uint32
    root_index*: uint32
    data_index*: ptr uint32
    num_data_indexes*: uint32

  rte_acl_bld_trie* = object
    trie*: ptr rte_acl_node

  rte_acl_ctx* = object
    name*: array[RTE_ACL_NAMESIZE, char] ## * Name of the ACL context.
    socket_id*: int32        ## * Socket ID to allocate memory from.
    alg*: rte_acl_classify_alg
    rules*: pointer
    max_rules*: uint32
    rule_sz*: uint32
    num_rules*: uint32
    num_categories*: uint32
    num_tries*: uint32
    match_index*: uint32
    no_match*: uint64
    idle*: uint64
    trans_table*: ptr uint64
    data_indexes*: ptr uint32
    trie*: array[RTE_ACL_MAX_TRIES, rte_acl_trie]
    mem*: pointer
    mem_sz*: csize
    config*: rte_acl_config    ##  copy of build config.
 

# rte_acl.nim
proc rte_acl_create*(param: ptr rte_acl_param): ptr rte_acl_ctx {.importc, header: "rte_acl.h".}
proc rte_acl_find_existing*(name: cstring): ptr rte_acl_ctx {.importc, header: "rte_acl.h".}
proc rte_acl_free*(ctx: ptr rte_acl_ctx) {.importc, header: "rte_acl.h".}
proc rte_acl_add_rules*(ctx: ptr rte_acl_ctx; rules: ptr rte_acl_rule; num: uint32): cint {.importc, header: "rte_acl.h".}
proc rte_acl_reset_rules*(ctx: ptr rte_acl_ctx) {.importc, header: "rte_acl.h".}
proc rte_acl_build*(ctx: ptr rte_acl_ctx; cfg: ptr rte_acl_config): cint {.importc, header: "rte_acl.h".}
proc rte_acl_reset*(ctx: ptr rte_acl_ctx) {.importc, header: "rte_acl.h".}

proc rte_acl_dump*(ctx: ptr rte_acl_ctx) {.importc, header: "rte_acl.h".}
proc rte_acl_list_dump*() {.importc, header: "rte_acl.h".}
