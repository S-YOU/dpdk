const
  RTE_PDUMP_FLAG_RX* = 1
  RTE_PDUMP_FLAG_TX* = 2
  RTE_PDUMP_FLAG_RXTX* = (RTE_PDUMP_FLAG_RX or RTE_PDUMP_FLAG_TX)

type
  rte_pdump_socktype* = enum
    RTE_PDUMP_SOCKET_SERVER = 1, RTE_PDUMP_SOCKET_CLIENT = 2


proc rte_pdump_init*(path: cstring): cint {.importc, header: "rte_pdump.h".}
proc rte_pdump_uninit*(): cint {.importc, header: "rte_pdump.h".}
proc rte_pdump_enable*(port: uint8; queue: uint16; flags: uint32;
                      ring: ptr rte_ring; mp: ptr rte_mempool; filter: pointer): cint {.importc, header: "rte_pdump.h".}
proc rte_pdump_disable*(port: uint8; queue: uint16; flags: uint32): cint {.importc, header: "rte_pdump.h".}
proc rte_pdump_enable_by_deviceid*(device_id: cstring; queue: uint16;
                                  flags: uint32; ring: ptr rte_ring;
                                  mp: ptr rte_mempool; filter: pointer): cint {.importc, header: "rte_pdump.h".}
proc rte_pdump_disable_by_deviceid*(device_id: cstring; queue: uint16;
                                   flags: uint32): cint {.importc, header: "rte_pdump.h".}
proc rte_pdump_set_socket_dir*(path: cstring; `type`: rte_pdump_socktype): cint {.importc, header: "rte_pdump.h".}
