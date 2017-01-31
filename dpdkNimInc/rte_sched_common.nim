proc rte_sched_min_val_2_u32*(x: uint32; y: uint32): uint32 {.inline, importc, header: "rte_sched_common.h".}
proc rte_min_pos_4_u16*(x: ptr uint16): uint32 {.inline, importc, header: "rte_sched_common.h".}
proc rte_get_gcd*(a: uint32; b: uint32): uint32 {.inline, importc, header: "rte_sched_common.h".}
proc rte_get_lcd*(a: uint32; b: uint32): uint32 {.inline, importc, header: "rte_sched_common.h".}
