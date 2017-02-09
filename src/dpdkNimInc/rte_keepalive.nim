const
  RTE_KEEPALIVE_MAXCORES* = RTE_MAX_LCORE

type
  rte_keepalive_state* = enum
    RTE_KA_STATE_UNUSED = 0, RTE_KA_STATE_ALIVE = 1, RTE_KA_STATE_DEAD = 2,
    RTE_KA_STATE_GONE = 3, RTE_KA_STATE_MISSING = 4, RTE_KA_STATE_DOZING = 5,
    RTE_KA_STATE_SLEEP = 6

  rte_keepalive_failure_callback_t* = proc (data: pointer; id_core: cint) {.cdecl.}
  rte_keepalive_relay_callback_t* = proc (data: pointer; id_core: cint;
                                       core_state: rte_keepalive_state;
                                       last_seen: uint64) {.cdecl.}

  # lib/librte_eal/common/rte_keepalive.c
  rte_keepalive* {.importc: "struct rte_keepalive", header: "cDecStructs.h".} = object
    state_flags*: array[RTE_KEEPALIVE_MAXCORES, rte_keepalive_state] ## * Core Liveness.
    ## * Last-seen-alive timestamps
    last_alive*: array[RTE_KEEPALIVE_MAXCORES, uint64] ## *
                                                      ##  Cores to check.
                                                      ##  Indexed by core id, non-zero if the core should be checked.
                                                      ## 
    active_cores*: array[RTE_KEEPALIVE_MAXCORES, uint8] ## * Dead core handler.
    callback*: rte_keepalive_failure_callback_t ## *
                                              ##  Dead core handler app data.
                                              ##  Pointer is passed to dead core handler.
                                              ## 
    callback_data*: pointer
    tsc_initial*: uint64
    tsc_mhz*: uint64         ## * Core state relay handler.
    relay_callback*: rte_keepalive_relay_callback_t ## *
                                                  ##  Core state relay handler app data.
                                                  ##  Pointer is passed to live core handler.
                                                  ## 
    relay_callback_data*: pointer
  # lib/librte_eal/common/rte_keepalive.c

proc rte_keepalive_create*(callback: rte_keepalive_failure_callback_t;
                          data: pointer): ptr rte_keepalive {.importc, header: "rte_keepalive.h".}
proc rte_keepalive_dispatch_pings*(ptr_timer: pointer; ptr_data: pointer) {.importc, header: "rte_keepalive.h".}
proc rte_keepalive_register_core*(keepcfg: ptr rte_keepalive; id_core: cint) {.importc, header: "rte_keepalive.h".}
proc rte_keepalive_mark_alive*(keepcfg: ptr rte_keepalive) {.importc, header: "rte_keepalive.h".}
proc rte_keepalive_mark_sleep*(keepcfg: ptr rte_keepalive) {.importc, header: "rte_keepalive.h".}
proc rte_keepalive_register_relay_callback*(keepcfg: ptr rte_keepalive;
    callback: rte_keepalive_relay_callback_t; data: pointer) {.importc, header: "rte_keepalive.h".}
