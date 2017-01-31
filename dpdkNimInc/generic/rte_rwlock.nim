type
  rte_rwlock_t* = object
    cnt*: int32


proc rte_rwlock_init*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
proc rte_rwlock_read_lock*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
proc rte_rwlock_read_unlock*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
proc rte_rwlock_write_lock*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
proc rte_rwlock_write_unlock*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}

# use the inline declarations from rte_rwlock.nim
#proc rte_rwlock_read_lock_tm*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
#proc rte_rwlock_read_unlock_tm*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
#proc rte_rwlock_write_lock_tm*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
#proc rte_rwlock_write_unlock_tm*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
