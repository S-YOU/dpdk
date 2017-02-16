proc rte_cpu_get_flag_name*(feature: rte_cpu_flag_t): cstring {.importc, header: "rte_cpuflags.h".}
proc rte_cpu_get_flag_enabled*(feature: rte_cpu_flag_t): cint {.importc, header: "rte_cpuflags.h".}
proc rte_cpu_check_supported*() {.importc, header: "rte_cpuflags.h".}
