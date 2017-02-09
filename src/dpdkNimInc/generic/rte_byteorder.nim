proc rte_constant_bswap16*(x: uint16): uint16 {.inline, importc, header: "rte_byteorder.h".}
proc rte_constant_bswap32*(x: uint32): uint32 {.inline, importc, header: "rte_byteorder.h".}
proc rte_constant_bswap64*(x: uint64): uint64 {.inline, importc, header: "rte_byteorder.h".}
