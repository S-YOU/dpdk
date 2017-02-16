proc rte_rwlock_read_lock_tm*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
proc rte_rwlock_read_unlock_tm*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
proc rte_rwlock_write_lock_tm*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
proc rte_rwlock_write_unlock_tm*(rwl: ptr rte_rwlock_t) {.inline, importc, header: "rte_rwlock.h".}
