const
  RTE_TAILQ_NAMESIZE* = 32

type
  INNER_C_STRUCT_541577717* = object
    tqe_next*: ptr rte_tailq_entry
    tqe_prev*: ptr ptr rte_tailq_entry

  rte_tailq_entry* = object
    next*: INNER_C_STRUCT_541577717
    data*: pointer

  rte_tailq_entry_head* = object
    tqh_first*: ptr rte_tailq_entry
    tqh_last*: ptr ptr rte_tailq_entry

  rte_tailq_head* = object
    tailq_head*: rte_tailq_entry_head
    name*: array[32, char]

  INNER_C_STRUCT_1755603680* = object
    tqe_next*: ptr rte_tailq_elem
    tqe_prev*: ptr ptr rte_tailq_elem

  rte_tailq_elem* = object
    head*: ptr rte_tailq_head
    next*: INNER_C_STRUCT_1755603680
    name*: array[32, char]


proc rte_dump_tailq*(f: ptr FILE) {.importc, header: "rte_tailq.h".}
proc rte_eal_tailq_lookup*(name: cstring): ptr rte_tailq_head {.importc, header: "rte_tailq.h".}
proc rte_eal_tailq_register*(t: ptr rte_tailq_elem): cint {.importc, header: "rte_tailq.h".}
