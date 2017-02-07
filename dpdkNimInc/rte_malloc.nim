type
  rte_malloc_socket_stats* {.importc: "struct rte_malloc_socket_stats", header: "rte_malloc.h".} = object
    heap_totalsz_bytes*: csize
    heap_freesz_bytes*: csize
    greatest_free_size*: csize
    free_count*: cuint
    alloc_count*: cuint
    heap_allocsz_bytes*: csize


proc rte_malloc*(`type`: cstring; size: csize; align: cuint): pointer {.importc, header: "rte_malloc.h".}
proc rte_zmalloc*(`type`: cstring; size: csize; align: cuint): pointer {.importc, header: "rte_malloc.h".}
proc rte_calloc*(`type`: cstring; num: csize; size: csize; align: cuint): pointer {.importc, header: "rte_malloc.h".}
proc rte_realloc*(`ptr`: pointer; size: csize; align: cuint): pointer {.importc, header: "rte_malloc.h".}
proc rte_malloc_socket*(`type`: cstring; size: csize; align: cuint; socket: cint): pointer {.importc, header: "rte_malloc.h".}
proc rte_zmalloc_socket*(`type`: cstring; size: csize; align: cuint; socket: cint): pointer {.importc, header: "rte_malloc.h".}
proc rte_calloc_socket*(`type`: cstring; num: csize; size: csize; align: cuint;
                       socket: cint): pointer {.importc, header: "rte_malloc.h".}
proc rte_free*(`ptr`: pointer) {.importc, header: "rte_malloc.h".}
proc rte_malloc_validate*(`ptr`: pointer; size: ptr csize): cint {.importc, header: "rte_malloc.h".}
proc rte_malloc_get_socket_stats*(socket: cint;
                                 socket_stats: ptr rte_malloc_socket_stats): cint {.importc, header: "rte_malloc.h".}
proc rte_malloc_dump_stats*(f: ptr FILE; `type`: cstring) {.importc, header: "rte_malloc.h".}
proc rte_malloc_set_limit*(`type`: cstring; max: csize): cint {.importc, header: "rte_malloc.h".}
proc rte_malloc_virt2phy*(`addr`: pointer): phys_addr_t {.importc, header: "rte_malloc.h".}
