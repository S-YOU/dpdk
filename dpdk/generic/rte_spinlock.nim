type
  rte_spinlock_t* {.importc: "struct rte_spinlock_t", header: "rte_spinlock.h".} = object
    locked*: cint


proc rte_spinlock_init*(sl: ptr rte_spinlock_t) {.inline, importc, header: "rte_spinlock.h".}

# rte_config.h:11:#undef RTE_FORCE_INTRINSICS
# so use rte_spinlock.nim's version
#proc rte_spinlock_lock*(sl: ptr rte_spinlock_t) {.inline, importc, header: "rte_spinlock.h".}
#proc rte_spinlock_unlock*(sl: ptr rte_spinlock_t) {.inline, importc, header: "rte_spinlock.h".}
#proc rte_spinlock_trylock*(sl: ptr rte_spinlock_t): cint {.inline, importc, header: "rte_spinlock.h".}

proc rte_spinlock_is_locked*(sl: ptr rte_spinlock_t): cint {.inline, importc, header: "rte_spinlock.h".}
# proc rte_tm_supported*(): cint {.inline, importc, header: "rte_spinlock.h".}
#proc rte_spinlock_lock_tm*(sl: ptr rte_spinlock_t) {.inline, importc, header: "rte_spinlock.h".}
# proc rte_spinlock_unlock_tm*(sl: ptr rte_spinlock_t) {.inline, importc, header: "rte_spinlock.h".}
#proc rte_spinlock_trylock_tm*(sl: ptr rte_spinlock_t): cint {.inline, importc, header: "rte_spinlock.h".}
type
  rte_spinlock_recursive_t* {.importc: "struct rte_spinlock_recursive_t", header: "rte_spinlock.h".} = object
    sl*: rte_spinlock_t
    user*: cint
    count*: cint


proc rte_spinlock_recursive_init*(slr: ptr rte_spinlock_recursive_t) {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_recursive_lock*(slr: ptr rte_spinlock_recursive_t) {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_recursive_unlock*(slr: ptr rte_spinlock_recursive_t) {.inline, importc, header: "rte_spinlock.h".}
proc rte_spinlock_recursive_trylock*(slr: ptr rte_spinlock_recursive_t): cint {.inline, importc, header: "rte_spinlock.h".}

# use inlines from rte_spinlock.nim
# proc rte_spinlock_recursive_lock_tm*(slr: ptr rte_spinlock_recursive_t) {.inline, importc, header: "rte_spinlock.h".}
# proc rte_spinlock_recursive_unlock_tm*(slr: ptr rte_spinlock_recursive_t) {.inline, importc, header: "rte_spinlock.h".}
# proc rte_spinlock_recursive_trylock_tm*(slr: ptr rte_spinlock_recursive_t): cint {.inline, importc, header: "rte_spinlock.h".}

