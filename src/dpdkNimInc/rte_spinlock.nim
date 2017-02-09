const
  RTE_RTM_MAX_RETRIES* = (10)
  RTE_XABORT_LOCK_BUSY* = (0x000000FF)

proc rte_spinlock_lock*(sl: ptr rte_spinlock_t) {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_unlock*(sl: ptr rte_spinlock_t) {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_trylock*(sl: ptr rte_spinlock_t): cint {.inline, importc, header: "rte_spinlock.h".}
proc rte_tm_supported*(): cint {.inline, importc, header: "rte_spinlock.h".}
proc rte_try_tm*(lock: ptr cint): cint {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_lock_tm*(sl: ptr rte_spinlock_t) {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_trylock_tm*(sl: ptr rte_spinlock_t): cint {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_unlock_tm*(sl: ptr rte_spinlock_t) {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_recursive_lock_tm*(slr: ptr rte_spinlock_recursive_t) {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_recursive_unlock_tm*(slr: ptr rte_spinlock_recursive_t) {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_recursive_trylock_tm*(slr: ptr rte_spinlock_recursive_t): cint {.inline, importc, header: "rte_spinlock.h".}

