const
  RTE_TIMER_STOP* = 0
  RTE_TIMER_PENDING* = 1
  RTE_TIMER_RUNNING* = 2
  RTE_TIMER_CONFIG* = 3
  RTE_TIMER_NO_OWNER* = - 2
  MAX_SKIPLIST_DEPTH* = 10

type
  rte_timer_type* = enum
    SINGLE, PERIODICAL


type
  INNER_C_STRUCT_1761507430* = object
    state*: uint16
    owner*: int16

  rte_timer_status* = object {.union.}
    ano_651049294*: INNER_C_STRUCT_1761507430
    u32*: uint32

  rte_timer_cb_t* = proc (a2: ptr rte_timer; a3: pointer) {.cdecl.}
  rte_timer* = object
    expire*: uint64
    sl_next*: array[10, ptr rte_timer]
    status*: rte_timer_status
    period*: uint64
    f*: rte_timer_cb_t
    arg*: pointer


proc rte_timer_subsystem_init*() {.importc, header: "rte_timer.h".}
proc rte_timer_init*(tim: ptr rte_timer) {.importc, header: "rte_timer.h".}
proc rte_timer_reset*(tim: ptr rte_timer; ticks: uint64; `type`: rte_timer_type;
                     tim_lcore: cuint; fct: rte_timer_cb_t; arg: pointer): cint {.importc, header: "rte_timer.h".}
proc rte_timer_reset_sync*(tim: ptr rte_timer; ticks: uint64;
                          `type`: rte_timer_type; tim_lcore: cuint;
                          fct: rte_timer_cb_t; arg: pointer) {.importc, header: "rte_timer.h".}
proc rte_timer_stop*(tim: ptr rte_timer): cint {.importc, header: "rte_timer.h".}
proc rte_timer_stop_sync*(tim: ptr rte_timer) {.importc, header: "rte_timer.h".}
proc rte_timer_pending*(tim: ptr rte_timer): cint {.importc, header: "rte_timer.h".}
proc rte_timer_manage*() {.importc, header: "rte_timer.h".}
proc rte_timer_dump_stats*(f: ptr FILE) {.importc, header: "rte_timer.h".}
