type
  timer_source* = enum
    EAL_TIMER_TSC = 0, EAL_TIMER_HPET


proc rte_get_tsc_hz*(): uint64 {.importc, header: "rte_cycles.h".}
# use the one in rte_cycles.nim
#proc rte_get_tsc_cycles*(): uint64 {.inline, importc, header: "rte_cycles.h".}
proc rte_get_timer_cycles*(): uint64 {.inline, importc, header: "rte_cycles.h".}
proc rte_get_timer_hz*(): uint64 {.inline, importc, header: "rte_cycles.h".}
proc rte_delay_us*(us: cuint) {.importc, header: "rte_cycles.h".}
proc rte_delay_ms*(ms: cuint) {.inline, importc, header: "rte_cycles.h".}
