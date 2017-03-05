const
  RTE_LPM_NAMESIZE* = 32
  RTE_LPM_MAX_DEPTH* = 32
  RTE_LPM_TBL24_NUM_ENTRIES* = (1 shl 24)
  RTE_LPM_TBL8_GROUP_NUM_ENTRIES* = 256
  RTE_LPM_MAX_TBL8_NUM_GROUPS* = (1 shl 24)
  RTE_LPM_TBL8_NUM_GROUPS* = 256
  RTE_LPM_TBL8_NUM_ENTRIES* = (
    RTE_LPM_TBL8_NUM_GROUPS * RTE_LPM_TBL8_GROUP_NUM_ENTRIES)
  RTE_LPM_VALID_EXT_ENTRY_BITMASK* = 0x03000000
  RTE_LPM_LOOKUP_SUCCESS* = 0x01000000
  RTE_LPM_MASKX4_RES* = 0x00FFFFFF00FFFFFF'u64

type
  INNER_C_UNION_1531442* = object {.union.}
    next_hop*: uint8
    group_idx*: uint8

  rte_lpm_tbl_entry_v20* {.importc: "struct rte_lpm_tbl_entry_v20", header: "rte_lpm.h".} = object
    ano_18054446*: INNER_C_UNION_1531442
    valid* {.bitsize: 1.}: uint8
    valid_group* {.bitsize: 1.}: uint8
    depth* {.bitsize: 6.}: uint8

  rte_lpm_tbl_entry* {.importc: "struct rte_lpm_tbl_entry", header: "rte_lpm.h".} = object
    next_hop* {.bitsize: 24.}: uint32
    valid* {.bitsize: 1.}: uint32
    valid_group* {.bitsize: 1.}: uint32
    depth* {.bitsize: 6.}: uint32

  rte_lpm_config* {.importc: "struct rte_lpm_config", header: "rte_lpm.h".} = object
    max_rules*: uint32
    number_tbl8s*: uint32
    flags*: cint

  rte_lpm_rule_v20* {.importc: "struct rte_lpm_rule_v20", header: "rte_lpm.h".} = object
    ip*: uint32
    next_hop*: uint8

  rte_lpm_rule* {.importc: "struct rte_lpm_rule", header: "rte_lpm.h".} = object
    ip*: uint32
    next_hop*: uint32

  rte_lpm_rule_info* {.importc: "struct rte_lpm_rule_info", header: "rte_lpm.h".} = object
    used_rules*: uint32
    first_rule*: uint32

  rte_lpm_v20* {.importc: "struct rte_lpm_v20", header: "rte_lpm.h".} = object
    name*: array[32, char]
    max_rules*: uint32
    rule_info*: array[32, rte_lpm_rule_info]
    tbl24*: array[(1 shl 24), rte_lpm_tbl_entry_v20]
    tbl8*: array[(256 * 256), rte_lpm_tbl_entry_v20]
    rules_tbl*: array[0, rte_lpm_rule_v20]

  rte_lpm* {.importc: "struct rte_lpm", header: "rte_lpm.h".} = object
    name*: array[32, char]
    max_rules*: uint32
    number_tbl8s*: uint32
    rule_info*: array[32, rte_lpm_rule_info]
    tbl24*: array[(1 shl 24), rte_lpm_tbl_entry]
    tbl8*: ptr rte_lpm_tbl_entry
    rules_tbl*: ptr rte_lpm_rule


proc rte_lpm_create*(name: cstring; socket_id: cint; config: ptr rte_lpm_config): ptr rte_lpm {.importc, header: "rte_lpm.h".}
proc rte_lpm_create_v20*(name: cstring; socket_id: cint; max_rules: cint; flags: cint): ptr rte_lpm_v20 {.importc, header: "rte_lpm.h".}
proc rte_lpm_create_v1604*(name: cstring; socket_id: cint; config: ptr rte_lpm_config): ptr rte_lpm {.importc, header: "rte_lpm.h".}
proc rte_lpm_find_existing*(name: cstring): ptr rte_lpm {.importc, header: "rte_lpm.h".}
proc rte_lpm_find_existing_v20*(name: cstring): ptr rte_lpm_v20 {.importc, header: "rte_lpm.h".}
proc rte_lpm_find_existing_v1604*(name: cstring): ptr rte_lpm {.importc, header: "rte_lpm.h".}
proc rte_lpm_free*(lpm: ptr rte_lpm) {.importc, header: "rte_lpm.h".}
proc rte_lpm_free_v20*(lpm: ptr rte_lpm_v20) {.importc, header: "rte_lpm.h".}
proc rte_lpm_free_v1604*(lpm: ptr rte_lpm) {.importc, header: "rte_lpm.h".}
proc rte_lpm_add*(lpm: ptr rte_lpm; ip: uint32; depth: uint8; next_hop: uint32): cint {.importc, header: "rte_lpm.h".}
proc rte_lpm_add_v20*(lpm: ptr rte_lpm_v20; ip: uint32; depth: uint8;
                     next_hop: uint8): cint {.importc, header: "rte_lpm.h".}
proc rte_lpm_add_v1604*(lpm: ptr rte_lpm; ip: uint32; depth: uint8;
                       next_hop: uint32): cint {.importc, header: "rte_lpm.h".}
proc rte_lpm_is_rule_present*(lpm: ptr rte_lpm; ip: uint32; depth: uint8;
                             next_hop: ptr uint32): cint {.importc, header: "rte_lpm.h".}
proc rte_lpm_is_rule_present_v20*(lpm: ptr rte_lpm_v20; ip: uint32; depth: uint8;
                                 next_hop: ptr uint8): cint {.importc, header: "rte_lpm.h".}
proc rte_lpm_is_rule_present_v1604*(lpm: ptr rte_lpm; ip: uint32; depth: uint8;
                                   next_hop: ptr uint32): cint {.importc, header: "rte_lpm.h".}
proc rte_lpm_delete*(lpm: ptr rte_lpm; ip: uint32; depth: uint8): cint {.importc, header: "rte_lpm.h".}
proc rte_lpm_delete_v20*(lpm: ptr rte_lpm_v20; ip: uint32; depth: uint8): cint {.importc, header: "rte_lpm.h".}
proc rte_lpm_delete_v1604*(lpm: ptr rte_lpm; ip: uint32; depth: uint8): cint {.importc, header: "rte_lpm.h".}
proc rte_lpm_delete_all*(lpm: ptr rte_lpm) {.importc, header: "rte_lpm.h".}
proc rte_lpm_delete_all_v20*(lpm: ptr rte_lpm_v20) {.importc, header: "rte_lpm.h".}
proc rte_lpm_delete_all_v1604*(lpm: ptr rte_lpm) {.importc, header: "rte_lpm.h".}
proc rte_lpm_lookup*(lpm: ptr rte_lpm; ip: uint32; next_hop: ptr uint32): cint {.inline, importc, header: "rte_lpm.h".}

proc rte_lpm_lookup_bulk_func*(lpm: ptr rte_lpm; ips: ptr uint32;
                              next_hops: ptr uint32; n: cuint): cint {.inline, importc, header: "rte_lpm.h".}

# get from rte_lpm_sse.nim
#proc rte_lpm_lookupx4*(lpm: ptr rte_lpm; ip: xmm_t; hop: array[4, uint32];
#                      defv: uint32) {.inline, importc, header: "rte_lpm.h".}

