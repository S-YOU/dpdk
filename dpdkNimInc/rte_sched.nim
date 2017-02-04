
# orig rte_sched.nim
const
  RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE* = 4
  RTE_SCHED_QUEUES_PER_TRAFFIC_CLASS* = 4
  RTE_SCHED_QUEUES_PER_PIPE* = (
    RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE * RTE_SCHED_QUEUES_PER_TRAFFIC_CLASS)
  RTE_SCHED_PIPE_PROFILES_PER_PORT* = 256
  RTE_SCHED_FRAME_OVERHEAD_DEFAULT* = 24

# from lib/librte_sched/rte_sched.c
const
  RTE_SCHED_GRINDER_PCACHE_SIZE* = (64 div RTE_SCHED_QUEUES_PER_PIPE)

type
  grinder_state* = enum
    e_GRINDER_PREFETCH_PIPE = 0, e_GRINDER_PREFETCH_TC_QUEUE_ARRAYS,
    e_GRINDER_PREFETCH_MBUF, e_GRINDER_READ_MBUF

  rte_sched_pipe_profile* = object
    tb_period*: uint32       ##  Token bucket (TB)
    tb_credits_per_period*: uint32
    tb_size*: uint32         ##  Pipe traffic classes
    tc_period*: uint32
    tc_credits_per_period*: array[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE, uint32]
    tc_ov_weight*: uint8     ##  Pipe queues
    wrr_cost*: array[RTE_SCHED_QUEUES_PER_PIPE, uint8]

  rte_sched_queue_extra* = object
    stats*: rte_sched_queue_stats ## #ifdef RTE_SCHED_RED
                                ##   struct rte_red red;
                                ## #endif
  
  rte_sched_queue* = object
    qw*: uint16
    qr*: uint16

  rte_sched_pipe* = object
    tb_time*: uint64         ##  Token bucket (TB)
    ##  time of last update
    tb_credits*: uint32      ##  Pipe profile and flags
    profile*: uint32         ##  Traffic classes (TCs)
    tc_time*: uint64         ##  time of next update
    tc_credits*: array[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE, uint32] ##  Weighted Round Robin (WRR)
    wrr_tokens*: array[RTE_SCHED_QUEUES_PER_PIPE, uint8] ##  TC oversubscription
    tc_ov_credits*: uint32
    tc_ov_period_id*: uint8
    reserved*: array[3, uint8]

  rte_sched_subport* = object
    tb_time*: uint64         ##  Token bucket (TB)
    ##  time of last update
    tb_period*: uint32
    tb_credits_per_period*: uint32
    tb_size*: uint32
    tb_credits*: uint32      ##  Traffic classes (TCs)
    tc_time*: uint64         ##  time of next update
    tc_credits_per_period*: array[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE, uint32]
    tc_credits*: array[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE, uint32]
    tc_period*: uint32       ##  TC oversubscription
    tc_ov_wm*: uint32
    tc_ov_wm_min*: uint32
    tc_ov_wm_max*: uint32
    tc_ov_period_id*: uint8
    tc_ov*: uint8
    tc_ov_n*: uint32
    tc_ov_rate*: cdouble       ##  Statistics
    stats*: rte_sched_subport_stats

  rte_sched_grinder* = object
    pcache_qmask*: array[RTE_SCHED_GRINDER_PCACHE_SIZE, uint16] ##  Pipe cache
    pcache_qindex*: array[RTE_SCHED_GRINDER_PCACHE_SIZE, uint32]
    pcache_w*: uint32
    pcache_r*: uint32        ##  Current pipe
    state*: grinder_state
    productive*: uint32
    pindex*: uint32
    subport*: ptr rte_sched_subport
    pipe*: ptr rte_sched_pipe
    pipe_params*: ptr rte_sched_pipe_profile ##  TC cache
    tccache_qmask*: array[4, uint8]
    tccache_qindex*: array[4, uint32]
    tccache_w*: uint32
    tccache_r*: uint32       ##  Current TC
    tc_index*: uint32
    queue*: array[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE, ptr rte_sched_queue]
    qbase*: array[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE, ptr ptr rte_mbuf]
    qindex*: array[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE, uint32]
    qsize*: uint16
    qmask*: uint32
    qpos*: uint32
    pkt*: ptr rte_mbuf          ##  WRR
    wrr_tokens*: array[RTE_SCHED_QUEUES_PER_TRAFFIC_CLASS, uint16]
    wrr_mask*: array[RTE_SCHED_QUEUES_PER_TRAFFIC_CLASS, uint16]
    wrr_cost*: array[RTE_SCHED_QUEUES_PER_TRAFFIC_CLASS, uint8]

  rte_sched_port* = object
    n_subports_per_port*: uint32 ##  User parameters
    n_pipes_per_subport*: uint32
    rate*: uint32
    mtu*: uint32
    frame_overhead*: uint32
    qsize*: array[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE, uint16]
    n_pipe_profiles*: uint32
    pipe_tc3_rate_max*: uint32 ## #ifdef RTE_SCHED_RED
                               ##   struct rte_red_config red_config[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE][e_RTE_METER_COLORS];
                               ## #endif
                               ##  Timing
    time_cpu_cycles*: uint64 ##  Current CPU time measured in CPU cyles
    time_cpu_bytes*: uint64  ##  Current CPU time measured in bytes
    time*: uint64            ##  Current NIC TX time measured in bytes
    inv_cycles_per_byte*: rte_reciprocal ##  CPU cycles per byte
                                       ##  Scheduling loop detection
    pipe_loop*: uint32
    pipe_exhaustion*: uint32 ##  Bitmap
    bmp*: ptr rte_bitmap
    grinder_base_bmp_pos*: array[RTE_SCHED_PORT_N_GRINDERS, uint32] ##  Grinders
    grinder*: array[RTE_SCHED_PORT_N_GRINDERS, rte_sched_grinder]
    busy_grinders*: uint32
    pkts_out*: ptr ptr rte_mbuf
    n_pkts_out*: uint32      ##  Queue base calculation
    qsize_add*: array[RTE_SCHED_QUEUES_PER_PIPE, uint32]
    qsize_sum*: uint32       ##  Large data structures
    subport*: ptr rte_sched_subport
    pipe*: ptr rte_sched_pipe
    queue*: ptr rte_sched_queue
    queue_extra*: ptr rte_sched_queue_extra
    pipe_profiles*: ptr rte_sched_pipe_profile
    bmp_array*: ptr uint8
    queue_array*: ptr ptr rte_mbuf
    memory*: array[0, uint8]

# orig rte_sched.nim
  rte_sched_subport_params* {.importc: "struct rte_sched_subport_params", header: "rte_sched.h".} = object
    tb_rate*: uint32
    tb_size*: uint32
    tc_rate*: array[4, uint32]
    tc_period*: uint32

  rte_sched_subport_stats* {.importc: "struct rte_sched_subport_stats", header: "rte_sched.h".} = object
    n_pkts_tc*: array[4, uint32]
    n_pkts_tc_dropped*: array[4, uint32]
    n_bytes_tc*: array[4, uint32]
    n_bytes_tc_dropped*: array[4, uint32]

  rte_sched_pipe_params* {.importc: "struct rte_sched_pipe_params", header: "rte_sched.h".} = object
    tb_rate*: uint32
    tb_size*: uint32
    tc_rate*: array[4, uint32]
    tc_period*: uint32
    wrr_weights*: array[(4 * 4), uint8]

  rte_sched_queue_stats* {.importc: "struct rte_sched_queue_stats", header: "rte_sched.h".} = object
    n_pkts*: uint32
    n_pkts_dropped*: uint32
    n_bytes*: uint32
    n_bytes_dropped*: uint32

  rte_sched_port_params* {.importc: "struct rte_sched_port_params", header: "rte_sched.h".} = object
    name*: cstring
    socket*: cint
    rate*: uint32
    mtu*: uint32
    frame_overhead*: uint32
    n_subports_per_port*: uint32
    n_pipes_per_subport*: uint32
    qsize*: array[4, uint16]
    pipe_profiles*: ptr rte_sched_pipe_params
    n_pipe_profiles*: uint32


proc rte_sched_port_config*(params: ptr rte_sched_port_params): ptr rte_sched_port {.importc, header: "rte_sched.h".}
proc rte_sched_port_free*(port: ptr rte_sched_port) {.importc, header: "rte_sched.h".}
proc rte_sched_subport_config*(port: ptr rte_sched_port; subport_id: uint32;
                              params: ptr rte_sched_subport_params): cint {.importc, header: "rte_sched.h".}
proc rte_sched_pipe_config*(port: ptr rte_sched_port; subport_id: uint32;
                           pipe_id: uint32; pipe_profile: int32): cint {.importc, header: "rte_sched.h".}
proc rte_sched_port_get_memory_footprint*(params: ptr rte_sched_port_params): uint32 {.importc, header: "rte_sched.h".}
proc rte_sched_subport_read_stats*(port: ptr rte_sched_port; subport_id: uint32;
                                  stats: ptr rte_sched_subport_stats;
                                  tc_ov: ptr uint32): cint {.importc, header: "rte_sched.h".}
proc rte_sched_queue_read_stats*(port: ptr rte_sched_port; queue_id: uint32;
                                stats: ptr rte_sched_queue_stats;
                                qlen: ptr uint16): cint {.importc, header: "rte_sched.h".}
proc rte_sched_port_pkt_write*(pkt: ptr rte_mbuf; subport: uint32; pipe: uint32;
                              traffic_class: uint32; queue: uint32;
                              color: rte_meter_color) {.importc, header: "rte_sched.h".}
proc rte_sched_port_pkt_read_tree_path*(pkt: ptr rte_mbuf; subport: ptr uint32;
                                       pipe: ptr uint32;
                                       traffic_class: ptr uint32;
                                       queue: ptr uint32) {.importc, header: "rte_sched.h".}
proc rte_sched_port_pkt_read_color*(pkt: ptr rte_mbuf): rte_meter_color {.importc, header: "rte_sched.h".}
proc rte_sched_port_enqueue*(port: ptr rte_sched_port; pkts: ptr ptr rte_mbuf;
                            n_pkts: uint32): cint {.importc, header: "rte_sched.h".}
proc rte_sched_port_dequeue*(port: ptr rte_sched_port; pkts: ptr ptr rte_mbuf;
                            n_pkts: uint32): cint {.importc, header: "rte_sched.h".}
