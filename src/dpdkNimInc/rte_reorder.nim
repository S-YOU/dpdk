# start lib/librte_reorder/rte_reorder.c
const
  RTE_REORDER_NAMESIZE* = 32

type
  cir_buffer* {.importc: "struct cir_buffer", header: "cDecStructs.h".} = object
    size*: cuint               ## *< Number of entries that can be stored
    mask*: cuint               ## *< [buffer_size - 1]: used for wrap-around
    head*: cuint               ## *< insertion point in buffer
    tail*: cuint               ## *< extraction point in buffer
    entries*: ptr ptr rte_mbuf

  rte_reorder_buffer* {.importc: "struct rte_reorder_buffer", header: "cDecStructs.h".} = object
    name*: array[RTE_REORDER_NAMESIZE, char]
    min_seqn*: uint32        ## *< Lowest seq. number that can be in the buffer
    memsize*: cuint            ## *< memory area size of reorder buffer
    ready_buf*: cir_buffer     ## *< temp buffer for dequeued entries
    order_buf*: cir_buffer     ## *< buffer used to reorder entries
    is_initialized*: cint
# end lib/librte_reorder/rte_reorder.c

proc rte_reorder_create*(name: cstring; socket_id: cuint; size: cuint): ptr rte_reorder_buffer {.importc, header: "rte_reorder.h".}
proc rte_reorder_init*(b: ptr rte_reorder_buffer; bufsize: cuint; name: cstring;
                      size: cuint): ptr rte_reorder_buffer {.importc, header: "rte_reorder.h".}
proc rte_reorder_find_existing*(name: cstring): ptr rte_reorder_buffer {.importc, header: "rte_reorder.h".}
proc rte_reorder_reset*(b: ptr rte_reorder_buffer) {.importc, header: "rte_reorder.h".}
proc rte_reorder_free*(b: ptr rte_reorder_buffer) {.importc, header: "rte_reorder.h".}
proc rte_reorder_insert*(b: ptr rte_reorder_buffer; mbuf: ptr rte_mbuf): cint {.importc, header: "rte_reorder.h".}
proc rte_reorder_drain*(b: ptr rte_reorder_buffer; mbufs: ptr ptr rte_mbuf;
                       max_mbufs: cuint): cuint {.importc, header: "rte_reorder.h".}
