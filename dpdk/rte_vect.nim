const
  XMM_SIZE = 16
  XMM_MASK = 15

type
  xmm_t = object
    b*: array[16, char]

  rte_xmm_t* {.importc: "union rte_xmm", header: "rte_vect.h", union.} = object
    x*: xmm_t
    u8*:  array[ XMM_SIZE div sizeof((uint8)), uint8]
    u16*: array[ XMM_SIZE div sizeof((uint16)), uint16]
    u32*: array[ XMM_SIZE div sizeof((uint32)), uint32]
    u64*: array[ XMM_SIZE div sizeof((uint64)), uint64]
    pd*:  array[ XMM_SIZE div sizeof((cdouble)), cdouble]

