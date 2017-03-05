proc rte_srand*(seedval: uint64) {.inline, importc, header: "rte_random.h".}
proc rte_rand*(): uint64 {.inline, importc, header: "rte_random.h".}
