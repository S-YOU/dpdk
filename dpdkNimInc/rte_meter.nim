type
  rte_meter_color* = enum
    e_RTE_METER_GREEN = 0, e_RTE_METER_YELLOW, e_RTE_METER_RED, e_RTE_METER_COLORS


type
  rte_meter_srtcm_params* = object
    cir*: uint64
    cbs*: uint64
    ebs*: uint64

  rte_meter_trtcm_params* = object
    cir*: uint64
    pir*: uint64
    cbs*: uint64
    pbs*: uint64

  rte_meter_srtcm* = object
    time*: uint64
    tc*: uint64
    te*: uint64
    cbs*: uint64
    ebs*: uint64
    cir_period*: uint64
    cir_bytes_per_period*: uint64 

  rte_meter_trtcm* = object
    time_tc*: uint64
    time_tp*: uint64
    tc*: uint64
    tp*: uint64
    cbs*: uint64
    pbs*: uint64
    cir_period*: uint64
    cir_bytes_per_period*: uint64
    pir_period*: uint64
    pir_bytes_per_period*: uint64
  

proc rte_meter_srtcm_config*(m: ptr rte_meter_srtcm;
                            params: ptr rte_meter_srtcm_params): cint {.importc, header: "rte_meter.h".}
proc rte_meter_trtcm_config*(m: ptr rte_meter_trtcm;
                            params: ptr rte_meter_trtcm_params): cint {.importc, header: "rte_meter.h".}
proc rte_meter_srtcm_color_blind_check*(m: ptr rte_meter_srtcm; time: uint64;
                                       pkt_len: uint32): rte_meter_color {.inline, importc, header: "rte_meter.h".}
proc rte_meter_srtcm_color_aware_check*(m: ptr rte_meter_srtcm; time: uint64;
                                       pkt_len: uint32;
                                       pkt_color: rte_meter_color): rte_meter_color {.inline, importc, header: "rte_meter.h".}

proc rte_meter_trtcm_color_blind_check*(m: ptr rte_meter_trtcm; time: uint64;
                                       pkt_len: uint32): rte_meter_color {.inline, importc, header: "rte_meter.h".}
proc rte_meter_trtcm_color_aware_check*(m: ptr rte_meter_trtcm; time: uint64;
                                       pkt_len: uint32;
                                       pkt_color: rte_meter_color): rte_meter_color {.inline, importc, header: "rte_meter.h".}
