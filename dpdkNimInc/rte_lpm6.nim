const
  RTE_LPM6_MAX_DEPTH* = 128
  RTE_LPM6_IPV6_ADDR_SIZE* = 16
  RTE_LPM6_NAMESIZE* = 32

type
  rte_lpm6* = object
  
  rte_lpm6_config* = object
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
