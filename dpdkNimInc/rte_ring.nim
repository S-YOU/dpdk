const
  RTE_TAILQ_RING_NAME* = "RTE_RING"
  RTE_RING_MZ_PREFIX* = "RG_"
  RTE_RING_NAMESIZE* = (RTE_MEMZONE_NAMESIZE - sizeof((RTE_RING_MZ_PREFIX)) + 1)
  RING_F_SP_ENQ* = 0x00000001
  RING_F_SC_DEQ* = 0x00000002
  RTE_RING_QUOT_EXCEED* = (1 shl 31)
  RTE_RING_SZ_MASK* = (0x0FFFFFFF)

type
  rte_ring_queue_behavior* = enum
    RTE_RING_QUEUE_FIXED = 0, RTE_RING_QUEUE_VARIABLE


type
  prod_910459801* = object
    watermark*: uint32
    sp_enqueue*: uint32
    size*: uint32
    mask*: uint32
    head*: uint32
    tail*: uint32

  cons_2860190097* = object
    sc_dequeue*: uint32
    size*: uint32
    mask*: uint32
    head*: uint32
    tail*: uint32

  rte_ring* = object
    name*: array[32, char]
    flags*: cint
    memzone*: ptr rte_memzone
    prod*: prod_910459801
    cons*: cons_2860190097
    ring*: array[0, pointer]


proc rte_ring_get_memsize*(count: cuint): int64 {.importc, header: "rte_ring.h".}
proc rte_ring_init*(r: ptr rte_ring; name: cstring; count: cuint; flags: cuint): cint {.importc, header: "rte_ring.h".}
proc rte_ring_create*(name: cstring; count: cuint; socket_id: cint; flags: cuint): ptr rte_ring {.importc, header: "rte_ring.h".}
proc rte_ring_free*(r: ptr rte_ring) {.importc, header: "rte_ring.h".}
proc rte_ring_set_water_mark*(r: ptr rte_ring; count: cuint): cint {.importc, header: "rte_ring.h".}
proc rte_ring_dump*(f: ptr FILE; r: ptr rte_ring) {.importc, header: "rte_ring.h".}
proc rte_ring_mp_enqueue_bulk*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_sp_enqueue_bulk*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_enqueue_bulk*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_mp_enqueue*(r: ptr rte_ring; obj: pointer): cint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_sp_enqueue*(r: ptr rte_ring; obj: pointer): cint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_enqueue*(r: ptr rte_ring; obj: pointer): cint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_mc_dequeue_bulk*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_sc_dequeue_bulk*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_dequeue_bulk*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_mc_dequeue*(r: ptr rte_ring; obj_p: ptr pointer): cint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_sc_dequeue*(r: ptr rte_ring; obj_p: ptr pointer): cint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_dequeue*(r: ptr rte_ring; obj_p: ptr pointer): cint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_full*(r: ptr rte_ring): cint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_empty*(r: ptr rte_ring): cint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_count*(r: ptr rte_ring): cuint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_free_count*(r: ptr rte_ring): cuint {.inline, importc, header: "rte_ring.h".}
proc rte_ring_list_dump*(f: ptr FILE) {.importc, header: "rte_ring.h".}
proc rte_ring_lookup*(name: cstring): ptr rte_ring {.importc, header: "rte_ring.h".}
proc rte_ring_mp_enqueue_burst*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cuint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_sp_enqueue_burst*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cuint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_enqueue_burst*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cuint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_mc_dequeue_burst*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cuint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_sc_dequeue_burst*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cuint {.inline, importc, header: "rte_ring.h".}

proc rte_ring_dequeue_burst*(r: ptr rte_ring; obj_table: ptr pointer; n: cuint): cuint {.inline, importc, header: "rte_ring.h".}

