proc rte_pmd_debug_trace*(func_name: cstring; fmt: cstring) {.inline, varargs, importc, header: "rte_dev.h".}
type
  rte_driver_list* {.importc: "struct rte_driver_list", header: "rte_dev.h".} = object
    tqh_first*: ptr rte_driver
    tqh_last*: ptr ptr rte_driver

  rte_dev_init_t* = proc (name: cstring; args: cstring): cint {.cdecl.}
  rte_dev_uninit_t* = proc (name: cstring): cint {.cdecl.}
  pmd_type* = enum
    PMD_VDEV = 0, PMD_PDEV = 1

  INNER_C_STRUCT_647670934* = object
    tqe_next*: ptr rte_driver
    tqe_prev*: ptr ptr rte_driver

  rte_driver* {.importc: "struct rte_driver", header: "rte_dev.h".} = object
    next*: INNER_C_STRUCT_647670934
    `type`*: pmd_type
    name*: cstring
    init*: ptr rte_dev_init_t
    uninit*: ptr rte_dev_uninit_t


proc rte_eal_driver_register*(driver: ptr rte_driver) {.importc, header: "rte_dev.h".}
proc rte_eal_driver_unregister*(driver: ptr rte_driver) {.importc, header: "rte_dev.h".}
proc rte_eal_dev_init*(): cint {.importc, header: "rte_dev.h".}
proc rte_eal_vdev_init*(name: cstring; args: cstring): cint {.importc, header: "rte_dev.h".}
proc rte_eal_vdev_uninit*(name: cstring): cint {.importc, header: "rte_dev.h".}
