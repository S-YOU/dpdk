type
  rte_reorder_buffer* = object
  

proc rte_reorder_create*(name: cstring; socket_id: cuint; size: cuint): ptr rte_reorder_buffer {.importc, header: "rte_reorder.h".}
proc rte_reorder_init*(b: ptr rte_reorder_buffer; bufsize: cuint; name: cstring;
                      size: cuint): ptr rte_reorder_buffer {.importc, header: "rte_reorder.h".}
proc rte_reorder_find_existing*(name: cstring): ptr rte_reorder_buffer {.importc, header: "rte_reorder.h".}
proc rte_reorder_reset*(b: ptr rte_reorder_buffer) {.importc, header: "rte_reorder.h".}
proc rte_reorder_free*(b: ptr rte_reorder_buffer) {.importc, header: "rte_reorder.h".}
proc rte_reorder_insert*(b: ptr rte_reorder_buffer; mbuf: ptr rte_mbuf): cint {.importc, header: "rte_reorder.h".}
proc rte_reorder_drain*(b: ptr rte_reorder_buffer; mbufs: ptr ptr rte_mbuf;
                       max_mbufs: cuint): cuint {.importc, header: "rte_reorder.h".}
