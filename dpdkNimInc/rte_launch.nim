type
  rte_lcore_state_t* = enum
    WAIT, RUNNING, FINISHED


type
  lcore_function_t* = proc (a2: pointer): cint {.cdecl.}

proc rte_eal_remote_launch*(f: ptr lcore_function_t; arg: pointer; slave_id: cuint): cint {.importc, header: "rte_launch.h".}
type
  rte_rmt_call_master_t* = enum
    SKIP_MASTER = 0, CALL_MASTER


proc rte_eal_mp_remote_launch*(f: ptr lcore_function_t; arg: pointer;
                              call_master: rte_rmt_call_master_t): cint {.importc, header: "rte_launch.h".}
proc rte_eal_get_lcore_state*(slave_id: cuint): rte_lcore_state_t {.importc, header: "rte_launch.h".}
proc rte_eal_wait_lcore*(slave_id: cuint): cint {.importc, header: "rte_launch.h".}
proc rte_eal_mp_wait_lcore*() {.importc, header: "rte_launch.h".}
