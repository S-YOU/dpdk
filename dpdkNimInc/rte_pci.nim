type
  rte_devtype* = enum
    RTE_DEVTYPE_WHITELISTED_PCI, RTE_DEVTYPE_BLACKLISTED_PCI, RTE_DEVTYPE_VIRTUAL


type
  INNER_C_STRUCT_2839750623* = object
    tqe_next*: ptr rte_devargs
    tqe_prev*: ptr ptr rte_devargs

  rte_pci_addr* {.importc: "struct rte_pci_addr", header: "rte_pci.h".} = object
    domain*: uint16
    bus*: uint8
    devid*: uint8
    function*: uint8

  INNER_C_STRUCT_2074183052* = object
    `addr`*: rte_pci_addr

  INNER_C_STRUCT_2098967565* = object
    drv_name*: array[32, char]

  INNER_C_UNION_2065921546* = object {.union.}
    pci*: INNER_C_STRUCT_2074183052
    virt*: INNER_C_STRUCT_2098967565

  rte_devargs* {.importc: "struct rte_devargs", header: "rte_pci.h".} = object
    next*: INNER_C_STRUCT_2839750623
    `type`*: rte_devtype
    ano_2115490571*: INNER_C_UNION_2065921546
    args*: cstring

  rte_devargs_list* {.importc: "struct rte_devargs_list", header: "rte_pci.h".} = object
    tqh_first*: ptr rte_devargs
    tqh_last*: ptr ptr rte_devargs


proc rte_eal_parse_devargs_str*(devargs_str: cstring; drvname: cstringArray;
                               drvargs: cstringArray): cint {.importc, header: "rte_devargs.h".}
proc rte_eal_devargs_add*(devtype: rte_devtype; devargs_str: cstring): cint {.importc, header: "rte_devargs.h".}
proc rte_eal_devargs_type_count*(devtype: rte_devtype): cuint {.importc, header: "rte_devargs.h".}
proc rte_eal_devargs_dump*(f: ptr FILE) {.importc, header: "rte_devargs.h".}

const
  PCI_FMT_NVAL* = 4
  PCI_RESOURCE_FMT_NVAL* = 3
  PCI_MAX_RESOURCE* = 6
  PCI_ANY_ID* = (0x0000FFFF)
  RTE_CLASS_ANY_ID* = (0x00FFFFFF)
  RTE_PCI_DRV_NEED_MAPPING* = 0x00000001
  RTE_PCI_DRV_FORCE_UNBIND* = 0x00000004
  RTE_PCI_DRV_INTR_LSC* = 0x00000008
  RTE_PCI_DRV_DETACHABLE* = 0x00000010

proc pci_get_sysfs_path*(): cstring {.importc, header: "rte_pci.h".}
type
  rte_pci_resource* = object
    phys_addr*: uint64
    len*: uint64
    `addr`*: pointer

  rte_pci_id* = object
    class_id*: uint32
    vendor_id*: uint16
    device_id*: uint16
    subsystem_vendor_id*: uint16
    subsystem_device_id*: uint16

  rte_kernel_driver* = enum
    RTE_KDRV_UNKNOWN = 0, RTE_KDRV_IGB_UIO, RTE_KDRV_VFIO, RTE_KDRV_UIO_GENERIC,
    RTE_KDRV_NIC_UIO, RTE_KDRV_NONE


type
  INNER_C_STRUCT_4209222361* = object
    tqe_next*: ptr rte_pci_device
    tqe_prev*: ptr ptr rte_pci_device

  rte_pci_device* = object
    next*: INNER_C_STRUCT_4209222361
    `addr`*: rte_pci_addr
    id*: rte_pci_id
    mem_resource*: array[6, rte_pci_resource]
    intr_handle*: rte_intr_handle
    driver*: ptr rte_pci_driver
    max_vfs*: uint16
    numa_node*: cint
    devargs*: ptr rte_devargs
    kdrv*: rte_kernel_driver

  pci_devinit_t* = proc (a2: ptr rte_pci_driver; a3: ptr rte_pci_device): cint {.cdecl.}
  pci_devuninit_t* = proc (a2: ptr rte_pci_device): cint {.cdecl.}
  INNER_C_STRUCT_661788053* = object
    tqe_next*: ptr rte_pci_driver
    tqe_prev*: ptr ptr rte_pci_driver

  rte_pci_driver* = object
    next*: INNER_C_STRUCT_661788053
    name*: cstring
    devinit*: ptr pci_devinit_t
    devuninit*: ptr pci_devuninit_t
    id_table*: ptr rte_pci_id
    drv_flags*: uint32

  pci_map* = object
    `addr`*: pointer
    path*: cstring
    offset*: uint64
    size*: uint64
    phaddr*: uint64

  INNER_C_STRUCT_3332947932* = object
    tqe_next*: ptr mapped_pci_resource
    tqe_prev*: ptr ptr mapped_pci_resource

  mapped_pci_resource* = object
    next*: INNER_C_STRUCT_3332947932
    pci_addr*: rte_pci_addr
    path*: array[4096, char]
    nb_maps*: cint
    maps*: array[6, pci_map]

  mapped_pci_res_list* = object
    tqh_first*: ptr mapped_pci_resource
    tqh_last*: ptr ptr mapped_pci_resource


proc eal_parse_pci_BDF*(input: cstring; dev_addr: ptr rte_pci_addr): cint {.inline, importc, header: "rte_pci.h".}
proc eal_parse_pci_DomBDF*(input: cstring; dev_addr: ptr rte_pci_addr): cint {.inline, importc, header: "rte_pci.h".}
proc rte_eal_compare_pci_addr*(`addr`: ptr rte_pci_addr; addr2: ptr rte_pci_addr): cint {.inline, importc, header: "rte_pci.h".}

proc rte_eal_pci_scan*(): cint {.importc, header: "rte_pci.h".}
proc rte_eal_pci_probe*(): cint {.importc, header: "rte_pci.h".}
proc rte_eal_pci_map_device*(dev: ptr rte_pci_device): cint {.importc, header: "rte_pci.h".}
proc rte_eal_pci_unmap_device*(dev: ptr rte_pci_device) {.importc, header: "rte_pci.h".}
proc pci_map_resource*(requested_addr: pointer; fd: cint; offset: off_t; size: csize;
                      additional_flags: cint): pointer {.importc, header: "rte_pci.h".}
proc pci_unmap_resource*(requested_addr: pointer; size: csize) {.importc, header: "rte_pci.h".}
proc rte_eal_pci_probe_one*(`addr`: ptr rte_pci_addr): cint {.importc, header: "rte_pci.h".}
proc rte_eal_pci_detach*(`addr`: ptr rte_pci_addr): cint {.importc, header: "rte_pci.h".}
proc rte_eal_pci_dump*(f: ptr FILE) {.importc, header: "rte_pci.h".}
proc rte_eal_pci_register*(driver: ptr rte_pci_driver) {.importc, header: "rte_pci.h".}
proc rte_eal_pci_unregister*(driver: ptr rte_pci_driver) {.importc, header: "rte_pci.h".}
proc rte_eal_pci_read_config*(device: ptr rte_pci_device; buf: pointer; len: csize;
                             offset: off_t): cint {.importc, header: "rte_pci.h".}
proc rte_eal_pci_write_config*(device: ptr rte_pci_device; buf: pointer; len: csize;
                              offset: off_t): cint {.importc, header: "rte_pci.h".}
type
  rte_pci_ioport* = object
    dev*: ptr rte_pci_device
    base*: uint64
    len*: uint64


proc rte_eal_pci_ioport_map*(dev: ptr rte_pci_device; bar: cint; p: ptr rte_pci_ioport): cint {.importc, header: "rte_pci.h".}
proc rte_eal_pci_ioport_unmap*(p: ptr rte_pci_ioport): cint {.importc, header: "rte_pci.h".}
proc rte_eal_pci_ioport_read*(p: ptr rte_pci_ioport; data: pointer; len: csize;
                             offset: off_t) {.importc, header: "rte_pci.h".}
proc rte_eal_pci_ioport_write*(p: ptr rte_pci_ioport; data: pointer; len: csize;
                              offset: off_t) {.importc, header: "rte_pci.h".}
