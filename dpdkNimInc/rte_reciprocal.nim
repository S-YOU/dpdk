type
  rte_reciprocal* = object
    m*: uint32
    sh1*: uint8
    sh2*: uint8


proc rte_reciprocal_divide*(a: uint32; R: rte_reciprocal): uint32 {.inline, importc, header: "rte_reciprocal.h".}
proc rte_reciprocal_value*(d: uint32): rte_reciprocal {.importc, header: "rte_reciprocal.h".}
