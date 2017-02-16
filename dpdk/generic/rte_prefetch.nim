proc rte_prefetch0*(p: pointer) {.inline, importc, header: "rte_prefetch.h".}
proc rte_prefetch1*(p: pointer) {.inline, importc, header: "rte_prefetch.h".}
proc rte_prefetch2*(p: pointer) {.inline, importc, header: "rte_prefetch.h".}
proc rte_prefetch_non_temporal*(p: pointer) {.inline, importc, header: "rte_prefetch.h".}
