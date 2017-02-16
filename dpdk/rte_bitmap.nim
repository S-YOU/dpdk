const
  RTE_BITMAP_OPTIMIZATIONS* = 1
  RTE_BITMAP_SLAB_BIT_SIZE* = 64
  RTE_BITMAP_SLAB_BIT_SIZE_LOG2* = 6
  RTE_BITMAP_SLAB_BIT_MASK* = (RTE_BITMAP_SLAB_BIT_SIZE - 1)
  RTE_BITMAP_CL_BIT_SIZE* = (RTE_CACHE_LINE_SIZE * 8)
  RTE_BITMAP_CL_BIT_SIZE_LOG2* = (RTE_CACHE_LINE_SIZE_LOG2 + 3)
  RTE_BITMAP_CL_BIT_MASK* = (RTE_BITMAP_CL_BIT_SIZE - 1)
  RTE_BITMAP_CL_SLAB_SIZE* = (RTE_BITMAP_CL_BIT_SIZE div
      RTE_BITMAP_SLAB_BIT_SIZE)
  RTE_BITMAP_CL_SLAB_SIZE_LOG2* = (
    RTE_BITMAP_CL_BIT_SIZE_LOG2 - RTE_BITMAP_SLAB_BIT_SIZE_LOG2)
  RTE_BITMAP_CL_SLAB_MASK* = (RTE_BITMAP_CL_SLAB_SIZE - 1)


type
  rte_bitmap* {.importc: "struct rte_bitmap", header: "rte_bitmap.h".} = object
    array1*: ptr uint64
    array2*: ptr uint64
    array1_size*: uint32
    array2_size*: uint32
    index1*: uint32
    offset1*: uint32
    index2*: uint32
    go2*: uint32
    memory*: array[0, uint8]


proc rte_bsf64*(slab: uint64; pos: ptr uint32): cint {.inline, importc, header: "rte_bitmap.h".}
proc rte_bitmap_get_memory_footprint*(n_bits: uint32): uint32 {.inline, importc, header: "rte_bitmap.h".}
proc rte_bitmap_init*(n_bits: uint32; mem: ptr uint8; mem_size: uint32): ptr rte_bitmap {.inline, importc, header: "rte_bitmap.h".}

proc rte_bitmap_free*(bmp: ptr rte_bitmap): cint {.inline, importc, header: "rte_bitmap.h".}
proc rte_bitmap_reset*(bmp: ptr rte_bitmap) {.inline, importc, header: "rte_bitmap.h".}
proc rte_bitmap_prefetch0*(bmp: ptr rte_bitmap; pos: uint32) {.inline, importc, header: "rte_bitmap.h".}
proc rte_bitmap_get*(bmp: ptr rte_bitmap; pos: uint32): uint64 {.inline, importc, header: "rte_bitmap.h".}
proc rte_bitmap_set*(bmp: ptr rte_bitmap; pos: uint32) {.inline, importc, header: "rte_bitmap.h".}
proc rte_bitmap_set_slab*(bmp: ptr rte_bitmap; pos: uint32; slab: uint64) {.inline, importc, header: "rte_bitmap.h".}
proc rte_bitmap_clear*(bmp: ptr rte_bitmap; pos: uint32) {.inline, importc, header: "rte_bitmap.h".}
proc rte_bitmap_scan*(bmp: ptr rte_bitmap; pos: ptr uint32; slab: ptr uint64): cint {.inline, importc, header: "rte_bitmap.h".}

