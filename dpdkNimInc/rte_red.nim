const
  RTE_RED_SCALING* = 10
  RTE_RED_S* = (1 shl 22)
  RTE_RED_MAX_TH_MAX* = 1023
  RTE_RED_WQ_LOG2_MIN* = 1
  RTE_RED_WQ_LOG2_MAX* = 12
  RTE_RED_MAXP_INV_MIN* = 1
  RTE_RED_MAXP_INV_MAX* = 255
  RTE_RED_2POW16* = (1 shl 16)
  RTE_RED_WQ_LOG2_NUM* = (RTE_RED_WQ_LOG2_MAX - RTE_RED_WQ_LOG2_MIN + 1)

type
  rte_red_params* = object
    min_th*: uint16
    max_th*: uint16
    maxp_inv*: uint16
    wq_log2*: uint16

  rte_red_config* = object
    min_th*: uint32
    max_th*: uint32
    pa_const*: uint32
    maxp_inv*: uint8
    wq_log2*: uint8

  rte_red* = object
    avg*: uint32
    count*: uint32
    q_time*: uint64


proc rte_red_rt_data_init*(red: ptr rte_red): cint {.importc, header: "rte_red.h".}
proc rte_red_config_init*(red_cfg: ptr rte_red_config; wq_log2: uint16;
                         min_th: uint16; max_th: uint16; maxp_inv: uint16): cint {.importc, header: "rte_red.h".}
proc rte_fast_rand*(): uint32 {.inline, importc, header: "rte_red.h".}
proc rte_red_enqueue_empty*(red_cfg: ptr rte_red_config; red: ptr rte_red;
                           time: uint64): cint {.inline, importc, header: "rte_red.h".}
proc rte_red_enqueue_nonempty*(red_cfg: ptr rte_red_config; red: ptr rte_red; q: cuint): cint {.inline, importc, header: "rte_red.h".}

proc rte_red_enqueue*(red_cfg: ptr rte_red_config; red: ptr rte_red; q: cuint;
                     time: uint64): cint {.inline, importc, header: "rte_red.h".}
proc rte_red_mark_queue_empty*(red: ptr rte_red; time: uint64) {.inline, importc, header: "rte_red.h".}
