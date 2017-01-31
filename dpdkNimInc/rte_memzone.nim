const
  RTE_MEMZONE_2MB* = 0x00000001
  RTE_MEMZONE_1GB* = 0x00000002
  RTE_MEMZONE_16MB* = 0x00000100
  RTE_MEMZONE_16GB* = 0x00000200
  RTE_MEMZONE_256KB* = 0x00010000
  RTE_MEMZONE_256MB* = 0x00020000
  RTE_MEMZONE_512MB* = 0x00040000
  RTE_MEMZONE_4GB* = 0x00080000
  RTE_MEMZONE_SIZE_HINT_ONLY* = 0x00000004
  RTE_MEMZONE_NAMESIZE* = 32

type
  INNER_C_UNION_480891241* = object {.union.}
    `addr`*: pointer
    addr_64*: uint64

  rte_memzone* = object
    name*: array[32, char]
    phys_addr*: phys_addr_t
    ano_497414248*: INNER_C_UNION_480891241
    len*: csize
    hugepage_sz*: uint64
    socket_id*: int32
    flags*: uint32
    memseg_id*: uint32


proc rte_memzone_reserve*(name: cstring; len: csize; socket_id: cint; flags: cuint): ptr rte_memzone {.importc, header: "rte_memzone.h".}
proc rte_memzone_reserve_aligned*(name: cstring; len: csize; socket_id: cint;
                                 flags: cuint; align: cuint): ptr rte_memzone {.importc, header: "rte_memzone.h".}
proc rte_memzone_reserve_bounded*(name: cstring; len: csize; socket_id: cint;
                                 flags: cuint; align: cuint; bound: cuint): ptr rte_memzone {.importc, header: "rte_memzone.h".}
proc rte_memzone_free*(mz: ptr rte_memzone): cint {.importc, header: "rte_memzone.h".}
proc rte_memzone_lookup*(name: cstring): ptr rte_memzone {.importc, header: "rte_memzone.h".}
proc rte_memzone_dump*(f: ptr FILE) {.importc, header: "rte_memzone.h".}
proc rte_memzone_walk*(`func`: proc (a2: ptr rte_memzone; arg: pointer); arg: pointer) {.importc, header: "rte_memzone.h".}
