const
  RTE_VER_PREFIX* = "DPDK"
  RTE_VER_YEAR* = 16
  RTE_VER_MONTH* = 7
  RTE_VER_MINOR* = 2
  RTE_VER_SUFFIX* = ""
  RTE_VER_RELEASE* = 16

proc rte_version*(): cstring {.inline, importc, header: "rte_version.h".}
