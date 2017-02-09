
proc rte_memdump*(f: ptr FILE; title: cstring; buf: pointer; len: cuint) {.importc, header: "rte_hexdump.h".}
