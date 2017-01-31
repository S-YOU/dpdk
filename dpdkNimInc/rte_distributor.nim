const
  RTE_DISTRIBUTOR_NAMESIZE* = 32

type
  rte_distributor* = object
  
proc rte_distributor_create*(name: cstring; socket_id: cuint; num_workers: cuint): ptr rte_distributor {.importc, header: "rte_distributor.h".}
proc rte_distributor_process*(d: ptr rte_distributor; mbufs: ptr ptr rte_mbuf;
                             num_mbufs: cuint): cint {.importc, header: "rte_distributor.h".}
proc rte_distributor_returned_pkts*(d: ptr rte_distributor; mbufs: ptr ptr rte_mbuf;
                                   max_mbufs: cuint): cint {.importc, header: "rte_distributor.h".}
proc rte_distributor_flush*(d: ptr rte_distributor): cint {.importc, header: "rte_distributor.h".}
proc rte_distributor_clear_returns*(d: ptr rte_distributor) {.importc, header: "rte_distributor.h".}
proc rte_distributor_get_pkt*(d: ptr rte_distributor; worker_id: cuint;
                             oldpkt: ptr rte_mbuf): ptr rte_mbuf {.importc, header: "rte_distributor.h".}
proc rte_distributor_return_pkt*(d: ptr rte_distributor; worker_id: cuint;
                                mbuf: ptr rte_mbuf): cint {.importc, header: "rte_distributor.h".}
proc rte_distributor_request_pkt*(d: ptr rte_distributor; worker_id: cuint;
                                 oldpkt: ptr rte_mbuf) {.importc, header: "rte_distributor.h".}
proc rte_distributor_poll_pkt*(d: ptr rte_distributor; worker_id: cuint): ptr rte_mbuf {.importc, header: "rte_distributor.h".}
