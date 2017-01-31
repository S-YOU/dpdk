const
  NSEC_PER_SEC* = 1000000000

type
  rte_timecounter* = object
    cycle_last*: uint64
    nsec*: uint64
    nsec_mask*: uint64
    nsec_frac*: uint64
    cc_mask*: uint64
    cc_shift*: uint32


proc rte_cyclecounter_cycles_to_ns*(tc: ptr rte_timecounter; cycles: uint64): uint64 {.inline, importc, header: "rte_time.h".}

proc rte_timecounter_update*(tc: ptr rte_timecounter; cycle_now: uint64): uint64 {.inline, importc, header: "rte_time.h".}

proc rte_timespec_to_ns*(ts: ptr timespec): uint64 {.inline, importc, header: "rte_time.h".}
proc rte_ns_to_timespec*(nsec: uint64): timespec {.inline, importc, header: "rte_time.h".}
