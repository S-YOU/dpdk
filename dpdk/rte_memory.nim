type                                                                         
  rte_page_sizes* = enum                                                     
    RTE_PGSIZE_4K = 1 shl 12, RTE_PGSIZE_64K = 1 shl 16, RTE_PGSIZE_256K = 1 shl 18,
    RTE_PGSIZE_2M = 1 shl 21, RTE_PGSIZE_16M = 1 shl 24, RTE_PGSIZE_256M = 1 shl 28, 
    RTE_PGSIZE_512M = 1 shl 29, RTE_PGSIZE_1G = 1 shl 30, RTE_PGSIZE_4G = 1 shl 32,
    RTE_PGSIZE_16G = 1 shl 34                                                
    

const
  SOCKET_ID_ANY* = - 1                                                       
  RTE_CACHE_LINE_MASK* = (RTE_CACHE_LINE_SIZE - 1)                           


type
  phys_addr_t* = uint64
  INNER_C_UNION_2659748374* = object {.union.}
    `addr`*: pointer
    addr_64*: uint64

  rte_memseg* = object
    phys_addr*: phys_addr_t
    ano_2676271381*: INNER_C_UNION_2659748374
    len*: csize
    hugepage_sz*: uint64
    socket_id*: int32
    nchannel*: uint32
    nrank*: uint32


when RTE_CACHE_LINE_SIZE == 64:                                              
  const
    RTE_CACHE_LINE_SIZE_LOG2* = 6                                            
elif RTE_CACHE_LINE_SIZE == 128:                                             
  const                                                                      
    RTE_CACHE_LINE_SIZE_LOG2* = 7                                            
const
  RTE_CACHE_LINE_MIN_SIZE* = 64 

proc rte_mem_lock_page*(virt: pointer): cint {.importc, header: "rte_memory.h".}
proc rte_mem_virt2phy*(virt: pointer): phys_addr_t {.importc, header: "rte_memory.h".}
proc rte_eal_get_physmem_layout*(): ptr rte_memseg {.importc, header: "rte_memory.h".}
proc rte_dump_physmem_layout*(f: ptr FILE) {.importc, header: "rte_memory.h".}
proc rte_eal_get_physmem_size*(): uint64 {.importc, header: "rte_memory.h".}
proc rte_memory_get_nchannel*(): cuint {.importc, header: "rte_memory.h".}
proc rte_memory_get_nrank*(): cuint {.importc, header: "rte_memory.h".}
proc rte_xen_dom0_supported*(): cint {.inline, importc, header: "rte_memory.h".}
proc rte_mem_phy2mch*(memseg_id: int32; phy_addr: phys_addr_t): phys_addr_t {.inline, importc, header: "rte_memory.h".}
