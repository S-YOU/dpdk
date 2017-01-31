type
  pthread_t* = culong
  cpu_mask* = culong 
  cpu_set_t* = object 
    bits*: array[1024 div (8 * sizeof((cpu_mask))), cpu_mask]
  rte_cpuset_t* = cpu_set_t


type
  lcore_config* = object
    detected*: cuint
    thread_id*: pthread_t
    pipe_master2slave*: array[2, cint]
    pipe_slave2master*: array[2, cint]
    f*: ptr lcore_function_t
    arg*: pointer
    ret*: cint
    state*: rte_lcore_state_t
    socket_id*: cuint
    core_id*: cuint
    core_index*: cint
    cpuset*: rte_cpuset_t


proc rte_lcore_id*(): cuint {.inline, importc, header: "rte_lcore.h".}
proc rte_get_master_lcore*(): cuint {.inline, importc, header: "rte_lcore.h".}
proc rte_lcore_count*(): cuint {.inline, importc, header: "rte_lcore.h".}
proc rte_lcore_index*(lcore_id: cint): cint {.inline, importc, header: "rte_lcore.h".}
proc rte_socket_id*(): cuint {.importc, header: "rte_lcore.h".}
proc rte_lcore_to_socket_id*(lcore_id: cuint): cuint {.inline, importc, header: "rte_lcore.h".}
proc rte_lcore_is_enabled*(lcore_id: cuint): cint {.inline, importc, header: "rte_lcore.h".}
proc rte_get_next_lcore*(i: cuint; skip_master: cint; wrap: cint): cuint {.inline, importc, header: "rte_lcore.h".}
proc rte_thread_set_affinity*(cpusetp: ptr rte_cpuset_t): cint {.importc, header: "rte_lcore.h".}
proc rte_thread_get_affinity*(cpusetp: ptr rte_cpuset_t) {.importc, header: "rte_lcore.h".}
proc rte_thread_setname*(id: pthread_t; name: cstring): cint {.importc, header: "rte_lcore.h".}
