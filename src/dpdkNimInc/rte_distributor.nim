const
  RTE_DISTRIBUTOR_NAMESIZE* = 32

# start lib/librte_distributor/rte_distributor.c
const
  RTE_DISTRIB_MAX_WORKERS* = 64
  RTE_DISTRIB_BACKLOG_SIZE* = 8
  RTE_DISTRIB_MAX_RETURNS* = 128

type
  rte_distributor_returned_pkts* {.importc: "struct rte_distributor_returned_pkts", header: "cDecStructs.h".} = object
    start*: cuint
    count*: cuint
    mbufs*: array[RTE_DISTRIB_MAX_RETURNS, ptr rte_mbuf]

  rte_distributor_buffer* {.importc: "union rte_distributor_buffer", header: "cDecStructs.h", union.} = object
    bufptr64*: int64
    pad*: array[RTE_CACHE_LINE_SIZE * 3, char]

  rte_distributor_backlog* {.importc: "struct rte_distributor_backlog", header: "cDecStructs.h".}= object
    start*: cuint
    count*: cuint
    pkts*: array[RTE_DISTRIB_BACKLOG_SIZE, int64]

  INNER_C_STRUCT_1369232736* = object
    tqe_next*: ptr rte_distributor
    tqe_prev*: ptr ptr rte_distributor

  rte_distributor* {.importc: "struct rte_distributor", header: "cDecStructs.h".} = object
    next*: INNER_C_STRUCT_1369232736 ## *< Next in list.
    name*: array[RTE_DISTRIBUTOR_NAMESIZE, char] ## *< Name of the ring.
    num_workers*: cuint        ## *< Number of workers polling
    in_flight_tags*: array[RTE_DISTRIB_MAX_WORKERS, uint32] ## *< Tracks the tag being processed per core
    in_flight_bitmask*: uint64 ## *< on/off bits for in-flight tags.
                               ##  Note that if RTE_DISTRIB_MAX_WORKERS is larger than 64 then
                               ##  the bitmask has to expand.
                               ## 
    backlog*: array[RTE_DISTRIB_MAX_WORKERS, rte_distributor_backlog]
    bufs*: array[RTE_DISTRIB_MAX_WORKERS, rte_distributor_buffer]
    returns*: rte_distributor_returned_pkts

# end lib/librte_distributor/rte_distributor.c

proc rte_distributor_create*(name: cstring; socket_id: cuint; num_workers: cuint): ptr rte_distributor {.importc, header: "rte_distributor.h".}
proc rte_distributor_process*(d: ptr rte_distributor; mbufs: ptr ptr rte_mbuf;
                             num_mbufs: cuint): cint {.importc, header: "rte_distributor.h".}
proc rte_distributor_returned_pkts_nim*(d: ptr rte_distributor; mbufs: ptr ptr rte_mbuf;
                                   max_mbufs: cuint): cint {.importc: "rte_distributor_returned_pkts", header: "rte_distributor.h".}
proc rte_distributor_flush*(d: ptr rte_distributor): cint {.importc, header: "rte_distributor.h".}
proc rte_distributor_clear_returns*(d: ptr rte_distributor) {.importc, header: "rte_distributor.h".}
proc rte_distributor_get_pkt*(d: ptr rte_distributor; worker_id: cuint;
                             oldpkt: ptr rte_mbuf): ptr rte_mbuf {.importc, header: "rte_distributor.h".}
proc rte_distributor_return_pkt*(d: ptr rte_distributor; worker_id: cuint;
                                mbuf: ptr rte_mbuf): cint {.importc, header: "rte_distributor.h".}
proc rte_distributor_request_pkt*(d: ptr rte_distributor; worker_id: cuint;
                                 oldpkt: ptr rte_mbuf) {.importc, header: "rte_distributor.h".}
proc rte_distributor_poll_pkt*(d: ptr rte_distributor; worker_id: cuint): ptr rte_mbuf {.importc, header: "rte_distributor.h".}
