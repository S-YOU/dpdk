const
  XMM_SIZE = 16
  XMM_MASK = 15

type
  xmm_tt* = object #{.union.}
    b*: array[16, char]

  m128i* = clonglong

  xmm_t* = m128i
  rte_xmm_t* {.importc: "struct rte_xmm_t", header: "rte_vect.h", union.} = object
    x*: xmm_t
    u8*: array[(sizeof((xmm_t))) div sizeof((uint8)), uint8]
    u16*: array[(sizeof((xmm_t))) div sizeof((uint16)), uint16]
    u32*: array[(sizeof((xmm_t))) div sizeof((uint32)), uint32]
    u64*: array[(sizeof((xmm_t))) div sizeof((uint64)), uint64]
    pd*: array[(sizeof((xmm_t))) div sizeof((cdouble)), cdouble]

