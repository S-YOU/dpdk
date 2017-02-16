const
  RTE_LPM6_MAX_DEPTH* = 128
  RTE_LPM6_IPV6_ADDR_SIZE* = 16
  RTE_LPM6_NAMESIZE* = 32

 # start lib/librte_lpm/rte_lpm6.c 
const
  RTE_LPM6_TBL24_NUM_ENTRIES* = (1 shl 24)

type

  rte_lpm6_rule* {.importc: "struct rte_lpm6_rule", header: "cDecStructs.h".} = object
    ip*: array[RTE_LPM6_IPV6_ADDR_SIZE, uint8] ## *< Rule IP address.
    next_hop*: uint8         ## *< Rule next hop.
    depth*: uint8            ## *< Rule depth.
  
  rte_lpm6_tbl_entry* {.importc: "struct rte_lpm6_tbl_entry", header: "cDecStructs.h".} = object
    next_hop* {.bitsize: 21.}: uint32 ## *< Next hop / next table to be checked.
    depth* {.bitsize: 8.}: uint32 ## *< Rule depth.
                                ##  Flags.
    valid* {.bitsize: 1.}: uint32 ## *< Validation flag.
    valid_group* {.bitsize: 1.}: uint32 ## *< Group validation flag.
    ext_entry* {.bitsize: 1.}: uint32 ## *< External entry.

  rte_lpm6* {.importc: "struct rte_lpm6", header: "cDecStructs.h".} = object
    name*: array[RTE_LPM6_NAMESIZE, char] ##  LPM metadata.
    ## *< Name of the lpm.
    max_rules*: uint32       ## *< Max number of rules.
    used_rules*: uint32      ## *< Used rules so far.
    number_tbl8s*: uint32    ## *< Number of tbl8s to allocate.
    next_tbl8*: uint32       ## *< Next tbl8 to be used.
                       ##  LPM Tables.
    rules_tbl*: ptr rte_lpm6_rule ## *< LPM rules.
    tbl24*: array[RTE_LPM6_TBL24_NUM_ENTRIES, rte_lpm6_tbl_entry] ## *< LPM tbl24 table.
    tbl8*: array[0, rte_lpm6_tbl_entry] ## *< LPM tbl8 table.
  # end lib/librte_lpm/rte_lpm6.c

  rte_lpm6_config* {.importc: "struct rte_lpm6_config", header: "rte_lpm6.h".} = object
    max_rules*: uint32
    number_tbl8s*: uint32
    flags*: cint


proc rte_lpm6_create*(name: cstring; socket_id: cint; config: ptr rte_lpm6_config): ptr rte_lpm6 {.importc, header: "rte_lpm6.h".}
proc rte_lpm6_find_existing*(name: cstring): ptr rte_lpm6 {.importc, header: "rte_lpm6.h".}
proc rte_lpm6_free*(lpm: ptr rte_lpm6) {.importc, header: "rte_lpm6.h".}
proc rte_lpm6_add*(lpm: ptr rte_lpm6; ip: ptr uint8; depth: uint8; next_hop: uint8): cint {.importc, header: "rte_lpm6.h".}
proc rte_lpm6_is_rule_present*(lpm: ptr rte_lpm6; ip: ptr uint8; depth: uint8;
                              next_hop: ptr uint8): cint {.importc, header: "rte_lpm6.h".}
proc rte_lpm6_delete*(lpm: ptr rte_lpm6; ip: ptr uint8; depth: uint8): cint {.importc, header: "rte_lpm6.h".}
proc rte_lpm6_delete_bulk_func*(lpm: ptr rte_lpm6; ips: ptr array[16, uint8];
                               depths: ptr uint8; n: cuint): cint {.importc, header: "rte_lpm6.h".}
proc rte_lpm6_delete_all*(lpm: ptr rte_lpm6) {.importc, header: "rte_lpm6.h".}
proc rte_lpm6_lookup*(lpm: ptr rte_lpm6; ip: ptr uint8; next_hop: ptr uint8): cint {.importc, header: "rte_lpm6.h".}
proc rte_lpm6_lookup_bulk_func*(lpm: ptr rte_lpm6; ips: ptr array[16, uint8];
                               next_hops: ptr int16; n: cuint): cint {.importc, header: "rte_lpm6.h".}
