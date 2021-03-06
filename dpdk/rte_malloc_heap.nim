

type
  # malloc_elem.h
  INNER_C_STRUCT_374384622* = object
    le_next*: ptr malloc_elem
    le_prev*: ptr ptr malloc_elem
    
  elem_state* = enum
    ELEM_FREE = 0, ELEM_BUSY, ELEM_PAD

  malloc_elem* {.importc: "struct malloc_elem", header: "cDecStructs.h".} = object
    heap*: ptr malloc_heap
    prev*: ptr malloc_elem
    free_list*: INNER_C_STRUCT_374384622
    ms*: ptr rte_memseg
    state*: elem_state
    pad*: uint32
    size*: csize

  # rte_malloc_heap.h
  INNER_C_STRUCT_1320030258* = object
    lh_first*: ptr malloc_elem

  malloc_heap* {.importc: "struct malloc_heap", header: "rte_malloc_heap.h".} = object
    lock*: rte_spinlock_t
    free_head*: array[13, INNER_C_STRUCT_1320030258]
    alloc_count*: cuint
    total_size*: csize

