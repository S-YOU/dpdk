type
  memory_info* {.importc: "struct memory_info", header: "rte_dom0_common.h".} = object
    name*: array[256, char]
    size*: uint64

  memseg_info* {.importc: "struct memseg_info", header: "rte_dom0_common.h".} = object
    idx*: uint32
    pfn*: uint64
    size*: uint64
    mfn*: array[(4096 div 2), uint64]

  memblock_info* {.importc: "struct memblock_info", header: "rte_dom0_common.h".} = object
    exchange_flag*: uint8
    used*: uint8
    vir_addr*: uint64
    pfn*: uint64
    mfn*: uint64

