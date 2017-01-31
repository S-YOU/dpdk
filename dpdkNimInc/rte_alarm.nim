type
  rte_eal_alarm_callback* = proc (arg: pointer) {.cdecl.}

proc rte_eal_alarm_set*(us: uint64; cb: rte_eal_alarm_callback; cb_arg: pointer): cint {.importc, header: "rte_alarm.h".}
proc rte_eal_alarm_cancel*(cb_fn: rte_eal_alarm_callback; cb_arg: pointer): cint {.importc, header: "rte_alarm.h".}
