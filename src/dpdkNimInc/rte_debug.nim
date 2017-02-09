proc rte_panic(formatstr: cstring): void {.importc: "rte_panic", varargs, header: "rte_debug.h".}
proc rte_dump_stack*() {.importc, header: "rte_debug.h".}
proc rte_dump_registers*() {.importc, header: "rte_debug.h".}
