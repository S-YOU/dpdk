proc rte_is_aligned*(`ptr`: pointer; align: cuint): cint {.inline, importc, header: "rte_common.h".}
proc rte_is_power_of_2*(n: uint32): cint {.inline, importc, header: "rte_common.h".}
proc rte_align32pow2*(x: uint32): uint32 {.inline, importc, header: "rte_common.h".}
proc rte_align64pow2*(v: uint64): uint64 {.inline, importc, header: "rte_common.h".}
proc rte_pause*() {.inline, importc, header: "rte_common.h".}
proc rte_bsf32*(v: uint32): uint32 {.inline, importc, header: "rte_common.h".}
proc rte_str_to_size*(str: cstring): uint64 {.inline, importc, header: "rte_common.h".}
proc rte_exit*(exit_code: cint; format: cstring) {.varargs, importc, header: "rte_common.h".}
