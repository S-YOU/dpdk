const
  RTE_JHASH_GOLDEN_RATIO* = 0xDEADBEEF
  LOWER8b_MASK* = (0x000000FF)
  LOWER16b_MASK* = (0x0000FFFF)
  LOWER24b_MASK* = (0x00FFFFFF)

proc rte_jhash_2hashes*(key: pointer; length: uint32; pc: ptr uint32;
                       pb: ptr uint32) {.inline, importc, header: "rte_jhash.h".}
proc rte_jhash_32b_2hashes*(k: ptr uint32; length: uint32; pc: ptr uint32;
                           pb: ptr uint32) {.inline, importc, header: "rte_jhash.h".}
proc rte_jhash*(key: pointer; length: uint32; initval: uint32): uint32 {.inline, importc, header: "rte_jhash.h".}
proc rte_jhash_32b*(k: ptr uint32; length: uint32; initval: uint32): uint32 {.inline, importc, header: "rte_jhash.h".}

proc rte_jhash_3words*(a: uint32; b: uint32; c: uint32; initval: uint32): uint32 {.inline, importc, header: "rte_jhash.h".}

proc rte_jhash_2words*(a: uint32; b: uint32; initval: uint32): uint32 {.inline, importc, header: "rte_jhash.h".}
proc rte_jhash_1word*(a: uint32; initval: uint32): uint32 {.inline, importc, header: "rte_jhash.h".}
