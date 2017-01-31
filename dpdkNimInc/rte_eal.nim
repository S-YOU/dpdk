const
  RTE_MAGIC* = 19820526
  RTE_MAX_THREAD_NAME_LEN* = 16

type
  rte_lcore_role_t* = enum
    ROLE_RTE, ROLE_OFF


type
  rte_proc_type_t* = enum
    RTE_PROC_AUTO = - 1, RTE_PROC_PRIMARY = 0, RTE_PROC_SECONDARY, RTE_PROC_INVALID


type
  rte_config* = object
    master_lcore*: uint32
    lcore_count*: uint32
    lcore_role*: array[RTE_MAX_LCORE, rte_lcore_role_t]
    process_type*: rte_proc_type_t
    mem_config*: ptr rte_mem_config


proc rte_eal_get_configuration*(): ptr rte_config {.cdecl.}
proc rte_eal_lcore_role*(lcore_id: cuint): rte_lcore_role_t {.importc, header: "rte_eal.h".}
proc rte_eal_process_type*(): rte_proc_type_t {.importc, header: "rte_eal.h".}
proc rte_eal_iopl_init*(): cint {.importc, header: "rte_eal.h".}
proc rte_eal_init*(argc: cint; argv: cstringArray): cint {.importc, header: "rte_eal.h".}
proc rte_eal_primary_proc_alive*(config_file_path: cstring): cint {.importc, header: "rte_eal.h".}
type
  rte_usage_hook_t* = proc (prgname: cstring) {.cdecl.}

proc rte_set_application_usage_hook*(usage_func: rte_usage_hook_t): rte_usage_hook_t {.importc, header: "rte_eal.h".}
proc rte_eal_has_hugepages*(): cint {.importc, header: "rte_eal.h".}
proc rte_sys_gettid*(): cint {.importc, header: "rte_eal.h".}
proc rte_gettid*(): cint {.inline, importc, header: "rte_eal.h".}
