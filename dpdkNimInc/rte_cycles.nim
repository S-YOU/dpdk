proc rte_rdtsc*(): uint64 {.inline, importc, header: "rte_cycles.h".}
proc rte_rdtsc_precise*(): uint64 {.inline, importc, header: "rte_cycles.h".}
proc rte_get_tsc_cycles*(): uint64 {.inline, importc, header: "rte_cycles.h".}
