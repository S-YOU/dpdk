const
  RTE_JOBSTATS_NAMESIZE* = 32

type
  rte_job_update_period_cb_t* = proc (job: ptr rte_jobstats; job_result: int64) {.cdecl.}
  rte_jobstats* = object
    period*: uint64
    min_period*: uint64
    max_period*: uint64
    target*: int64
    update_period_cb*: rte_job_update_period_cb_t
    exec_time*: uint64
    min_exec_time*: uint64
    max_exec_time*: uint64
    exec_cnt*: uint64
    name*: array[32, char]
    context*: ptr rte_jobstats_context

  rte_jobstats_context* = object
    state_time*: uint64
    loop_executed_jobs*: uint64
    exec_time*: uint64
    min_exec_time*: uint64
    max_exec_time*: uint64
    management_time*: uint64
    min_management_time*: uint64
    max_management_time*: uint64
    start_time*: uint64
    job_exec_cnt*: uint64
    loop_cnt*: uint64


proc rte_jobstats_context_init*(ctx: ptr rte_jobstats_context): cint {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_context_start*(ctx: ptr rte_jobstats_context) {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_context_finish*(ctx: ptr rte_jobstats_context) {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_context_reset*(ctx: ptr rte_jobstats_context) {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_init*(job: ptr rte_jobstats; name: cstring; min_period: uint64;
                       max_period: uint64; initial_period: uint64;
                       target: int64): cint {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_set_target*(job: ptr rte_jobstats; target: int64) {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_start*(ctx: ptr rte_jobstats_context; job: ptr rte_jobstats): cint {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_abort*(job: ptr rte_jobstats): cint {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_finish*(job: ptr rte_jobstats; job_value: int64): cint {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_set_period*(job: ptr rte_jobstats; period: uint64;
                             saturate: uint8) {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_set_min*(job: ptr rte_jobstats; period: uint64) {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_set_max*(job: ptr rte_jobstats; period: uint64) {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_set_update_period_function*(job: ptr rte_jobstats;
    update_period_cb: rte_job_update_period_cb_t) {.importc, header: "rte_jobstats.h".}
proc rte_jobstats_reset*(job: ptr rte_jobstats) {.importc, header: "rte_jobstats.h".}
