const
  RTE_XBEGIN_STARTED* = (not 0)
  RTE_XABORT_EXPLICIT* = (1 shl 0)
  RTE_XABORT_RETRY* = (1 shl 1)
  RTE_XABORT_CONFLICT* = (1 shl 2)
  RTE_XABORT_CAPACITY* = (1 shl 3)
  RTE_XABORT_DEBUG* = (1 shl 4)
  RTE_XABORT_NESTED* = (1 shl 5)

proc rte_xbegin*(): cuint {.inline, importc, header: "rte_rtm.h".}
proc rte_xend*() {.inline, importc, header: "rte_rtm.h".}
proc rte_xtest*(): cint {.inline, importc, header: "rte_rtm.h".}
