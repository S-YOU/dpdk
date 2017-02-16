type
  power_management_env* = enum
    PM_ENV_NOT_SET, PM_ENV_ACPI_CPUFREQ, PM_ENV_KVM_VM


proc rte_power_set_env*(env: power_management_env): cint {.importc, header: "rte_power.h".}
proc rte_power_unset_env*() {.importc, header: "rte_power.h".}
proc rte_power_get_env*(): power_management_env {.importc, header: "rte_power.h".}
proc rte_power_init*(lcore_id: cuint): cint {.importc, header: "rte_power.h".}
proc rte_power_exit*(lcore_id: cuint): cint {.importc, header: "rte_power.h".}
type
  rte_power_freqs_t* = proc (lcore_id: cuint; freqs: ptr uint32; num: uint32): uint32 {.cdecl.}
  rte_power_get_freq_t* = proc (lcore_id: cuint): uint32 {.cdecl.}
  rte_power_set_freq_t* = proc (lcore_id: cuint; index: uint32): cint {.cdecl.}
  rte_power_freq_change_t* = proc (lcore_id: cuint): cint {.cdecl.}
