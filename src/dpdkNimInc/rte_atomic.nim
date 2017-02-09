proc rte_atomic16_cmpset*(dst: ptr uint16; exp: uint16; src: uint16): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic16_test_and_set*(v: ptr rte_atomic16_t): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic16_inc*(v: ptr rte_atomic16_t) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic16_dec*(v: ptr rte_atomic16_t) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic16_inc_and_test*(v: ptr rte_atomic16_t): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic16_dec_and_test*(v: ptr rte_atomic16_t): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic32_cmpset*(dst: ptr uint32; exp: uint32; src: uint32): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic32_test_and_set*(v: ptr rte_atomic32_t): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic32_inc*(v: ptr rte_atomic32_t) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic32_dec*(v: ptr rte_atomic32_t) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic32_inc_and_test*(v: ptr rte_atomic32_t): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic32_dec_and_test*(v: ptr rte_atomic32_t): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_cmpset*(dst: ptr uint64; exp: uint64; src: uint64): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_init*(v: ptr rte_atomic64_t) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_read*(v: ptr rte_atomic64_t): int64 {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_set*(v: ptr rte_atomic64_t; new_value: int64) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_add*(v: ptr rte_atomic64_t; inc: int64) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_sub*(v: ptr rte_atomic64_t; dec: int64) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_inc*(v: ptr rte_atomic64_t) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_dec*(v: ptr rte_atomic64_t) {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_add_return*(v: ptr rte_atomic64_t; inc: int64): int64 {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_sub_return*(v: ptr rte_atomic64_t; dec: int64): int64 {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_inc_and_test*(v: ptr rte_atomic64_t): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_dec_and_test*(v: ptr rte_atomic64_t): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_test_and_set*(v: ptr rte_atomic64_t): cint {.inline, importc, header: "rte_atomic.h".}
proc rte_atomic64_clear*(v: ptr rte_atomic64_t) {.inline, importc, header: "rte_atomic.h".}
