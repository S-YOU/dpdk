type
  rte_devtype* = enum
    RTE_DEVTYPE_WHITELISTED_PCI, RTE_DEVTYPE_BLACKLISTED_PCI, RTE_DEVTYPE_VIRTUAL


type
  INNER_C_STRUCT_2839750623* = object
    tqe_next*: ptr rte_devargs
    tqe_prev*: ptr ptr rte_devargs

  INNER_C_STRUCT_2074183052* = object
    `addr`*: rte_pci_addr

  INNER_C_STRUCT_2098967565* = object
    drv_name*: array[32, char]

  INNER_C_UNION_2065921546* = object {.union.}
    pci*: INNER_C_STRUCT_2074183052
    virt*: INNER_C_STRUCT_2098967565

  rte_devargs* {.importc: "struct rte_devargs", header: "rte_devargs.h".} = object
    next*: INNER_C_STRUCT_2839750623
    `type`*: rte_devtype
    ano_2115490571*: INNER_C_UNION_2065921546
    args*: cstring

  rte_devargs_list* = object
    tqh_first*: ptr rte_devargs
    tqh_last*: ptr ptr rte_devargs


proc rte_eal_parse_devargs_str*(devargs_str: cstring; drvname: cstringArray;
                               drvargs: cstringArray): cint {.importc, header: "rte_devargs.h".}
proc rte_eal_devargs_add*(devtype: rte_devtype; devargs_str: cstring): cint {.importc, header: "rte_devargs.h".}
proc rte_eal_devargs_type_count*(devtype: rte_devtype): cuint {.importc, header: "rte_devargs.h".}
proc rte_eal_devargs_dump*(f: ptr FILE) {.importc, header: "rte_devargs.h".}
