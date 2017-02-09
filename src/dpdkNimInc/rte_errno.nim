proc rte_strerror*(errnum: cint): cstring {.importc, header: "rte_errno.h".}
const
  RTE_MIN_ERRNO* = 1000
  E_RTE_SECONDARY* = 1001
  E_RTE_NO_CONFIG* = 1002
  RTE_MAX_ERRNO* = 1003
