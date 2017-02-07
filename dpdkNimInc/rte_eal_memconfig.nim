type
  rte_mem_config* {.importc: "struct rte_mem_config", header: "rte_eal_memconfig.h".} = object
    magic*: uint32
    nchannel*: uint32
    nrank*: uint32
    mlock*: rte_rwlock_t
    qlock*: rte_rwlock_t
    mplock*: rte_rwlock_t
    memzone_cnt*: uint32
    memseg*: array[RTE_MAX_MEMSEG, rte_memseg]
    memzone*: array[RTE_MAX_MEMZONE, rte_memzone]
    tailq_head*: array[RTE_MAX_TAILQ, rte_tailq_head]
    malloc_heaps*: array[RTE_MAX_NUMA_NODES, malloc_heap]
    mem_cfg_addr*: uint64


proc rte_eal_mcfg_wait_complete*(mcfg: ptr rte_mem_config) {.inline, importc, header: "rte_eal_memconfig.h".}
