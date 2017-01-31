const
  RTE_MEMPOOL_HEADER_COOKIE1* = 0xBADBADBADADD2E55'i64
  RTE_MEMPOOL_HEADER_COOKIE2* = 0xF2EEF2EEDADD2E55'i64
  RTE_MEMPOOL_TRAILER_COOKIE* = 0xADD2E55BADBADBAD'i64
  RTE_MEMPOOL_MZ_PREFIX* = "MP_"
  RTE_MEMPOOL_NAMESIZE* = (RTE_RING_NAMESIZE - sizeof(RTE_MEMPOOL_MZ_PREFIX) + 1)
  MEMPOOL_PG_SHIFT_MAX* = (sizeof(ptr uint) * CHAR_BIT - 1)
  MEMPOOL_PG_NUM_DEFAULT* = 1
  RTE_MEMPOOL_ALIGN* = RTE_CACHE_LINE_SIZE
  RTE_MEMPOOL_ALIGN_MASK* = (RTE_MEMPOOL_ALIGN - 1)
  MEMPOOL_F_NO_SPREAD* = 0x00000001
  MEMPOOL_F_NO_CACHE_ALIGN* = 0x00000002
  MEMPOOL_F_SP_PUT* = 0x00000004
  MEMPOOL_F_SC_GET* = 0x00000008
  MEMPOOL_F_POOL_CREATED* = 0x00000010
  MEMPOOL_F_NO_PHYS_CONTIG* = 0x00000020
  RTE_MEMPOOL_OPS_NAMESIZE* = 32
  RTE_MEMPOOL_MAX_OPS_IDX* = 16

type
  rte_mempool_cache* = object
    size*: uint32
    flushthresh*: uint32
    len*: uint32
    objs*: array[RTE_MEMPOOL_CACHE_MAX_SIZE * 3, pointer]

  rte_mempool_objsz* = object
    elt_size*: uint32
    header_size*: uint32
    trailer_size*: uint32
    total_size*: uint32

  INNER_C_STRUCT_996886926* = object
    stqe_next*: ptr rte_mempool_objhdr

  rte_mempool_objhdr* = object
    next*: INNER_C_STRUCT_996886926
    mp*: ptr rte_mempool
    physaddr*: phys_addr_t

  rte_mempool_objhdr_list* = object
    stqh_first*: ptr rte_mempool_objhdr
    stqh_last*: ptr ptr rte_mempool_objhdr

  rte_mempool_memhdr_list* = object
    stqh_first*: ptr rte_mempool_memhdr
    stqh_last*: ptr ptr rte_mempool_memhdr

  rte_mempool_memchunk_free_cb_t* = proc (memhdr: ptr rte_mempool_memhdr;
                                       opaque: pointer) {.cdecl.}
  INNER_C_STRUCT_1355864016* = object
    stqe_next*: ptr rte_mempool_memhdr

  rte_mempool_memhdr* = object
    next*: INNER_C_STRUCT_1355864016
    mp*: ptr rte_mempool
    `addr`*: pointer
    phys_addr*: phys_addr_t
    len*: csize
    free_cb*: ptr rte_mempool_memchunk_free_cb_t
    opaque*: pointer

  INNER_C_UNION_2676130347* = object {.union.}
    pool_data*: pointer
    pool_id*: uint64

  rte_mempool* = object
    name*: array[32, char]
    ano_2692653354*: INNER_C_UNION_2676130347
    pool_config*: pointer
    mz*: ptr rte_memzone
    flags*: cint
    socket_id*: cint
    size*: uint32
    cache_size*: uint32
    elt_size*: uint32
    header_size*: uint32
    trailer_size*: uint32
    private_data_size*: cuint
    ops_index*: int32
    local_cache*: ptr rte_mempool_cache
    populated_size*: uint32
    elt_list*: rte_mempool_objhdr_list
    nb_mem_chunks*: uint32
    mem_list*: rte_mempool_memhdr_list


proc rte_mempool_from_obj*(obj: pointer): ptr rte_mempool {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_check_cookies*(mp: ptr rte_mempool; obj_table_const: ptr pointer;
                               n: cuint; free: cint) {.importc, header: "rte_mempool.h".}
type
  rte_mempool_alloc_t* = proc (mp: ptr rte_mempool): cint {.cdecl.}
  rte_mempool_free_t* = proc (mp: ptr rte_mempool) {.cdecl.}
  rte_mempool_enqueue_t* = proc (mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint): cint {.cdecl.}
  rte_mempool_dequeue_t* = proc (mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint): cint {.cdecl.}
  rte_mempool_get_count* = proc (mp: ptr rte_mempool): cuint {.cdecl.}
  rte_mempool_ops* = object
    name*: array[32, char]
    alloc*: rte_mempool_alloc_t
    free*: rte_mempool_free_t
    enqueue*: rte_mempool_enqueue_t
    dequeue*: rte_mempool_dequeue_t
    get_count*: rte_mempool_get_count

  rte_mempool_ops_table* = object
    sl*: rte_spinlock_t
    num_ops*: uint32
    ops*: array[16, rte_mempool_ops]


proc rte_mempool_get_ops*(ops_index: cint): ptr rte_mempool_ops {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_ops_alloc*(mp: ptr rte_mempool): cint {.importc, header: "rte_mempool.h".}
proc rte_mempool_ops_dequeue_bulk*(mp: ptr rte_mempool; obj_table: ptr pointer;
                                  n: cuint): cint {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_ops_enqueue_bulk*(mp: ptr rte_mempool; obj_table: ptr pointer;
                                  n: cuint): cint {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_ops_get_count*(mp: ptr rte_mempool): cuint {.importc, header: "rte_mempool.h".}
proc rte_mempool_ops_free*(mp: ptr rte_mempool) {.importc, header: "rte_mempool.h".}
proc rte_mempool_set_ops_byname*(mp: ptr rte_mempool; name: cstring;
                                pool_config: pointer): cint {.importc, header: "rte_mempool.h".}
proc rte_mempool_register_ops*(ops: ptr rte_mempool_ops): cint {.importc, header: "rte_mempool.h".}
type
  rte_mempool_obj_cb_t* = proc (mp: ptr rte_mempool; opaque: pointer; obj: pointer;
                             obj_idx: cuint) {.cdecl.}
  rte_mempool_obj_ctor_t* = rte_mempool_obj_cb_t
  rte_mempool_mem_cb_t* = proc (mp: ptr rte_mempool; opaque: pointer;
                             memhdr: ptr rte_mempool_memhdr; mem_idx: cuint) {.cdecl.}
  rte_mempool_ctor_t* = proc (a2: ptr rte_mempool; a3: pointer) {.cdecl.}

proc rte_mempool_create*(name: cstring; n: cuint; elt_size: cuint; cache_size: cuint;
                        private_data_size: cuint; mp_init: ptr rte_mempool_ctor_t;
                        mp_init_arg: pointer; obj_init: ptr rte_mempool_obj_cb_t;
                        obj_init_arg: pointer; socket_id: cint; flags: cuint): ptr rte_mempool {.importc, header: "rte_mempool.h".}
proc rte_mempool_xmem_create*(name: cstring; n: cuint; elt_size: cuint;
                             cache_size: cuint; private_data_size: cuint;
                             mp_init: ptr rte_mempool_ctor_t; mp_init_arg: pointer;
                             obj_init: ptr rte_mempool_obj_cb_t;
                             obj_init_arg: pointer; socket_id: cint; flags: cuint;
                             vaddr: pointer; paddr: ptr phys_addr_t;
                             pg_num: uint32; pg_shift: uint32): ptr rte_mempool {.importc, header: "rte_mempool.h".}
proc rte_mempool_create_empty*(name: cstring; n: cuint; elt_size: cuint;
                              cache_size: cuint; private_data_size: cuint;
                              socket_id: cint; flags: cuint): ptr rte_mempool {.importc, header: "rte_mempool.h".}
proc rte_mempool_free*(mp: ptr rte_mempool) {.importc, header: "rte_mempool.h".}
proc rte_mempool_populate_phys*(mp: ptr rte_mempool; vaddr: cstring;
                               paddr: phys_addr_t; len: csize;
                               free_cb: ptr rte_mempool_memchunk_free_cb_t;
                               opaque: pointer): cint {.importc, header: "rte_mempool.h".}
proc rte_mempool_populate_phys_tab*(mp: ptr rte_mempool; vaddr: cstring;
                                   paddr: ptr phys_addr_t; pg_num: uint32;
                                   pg_shift: uint32;
                                   free_cb: ptr rte_mempool_memchunk_free_cb_t;
                                   opaque: pointer): cint {.importc, header: "rte_mempool.h".}
proc rte_mempool_populate_virt*(mp: ptr rte_mempool; `addr`: cstring; len: csize;
                               pg_sz: csize;
                               free_cb: ptr rte_mempool_memchunk_free_cb_t;
                               opaque: pointer): cint {.importc, header: "rte_mempool.h".}
proc rte_mempool_populate_default*(mp: ptr rte_mempool): cint {.importc, header: "rte_mempool.h".}
proc rte_mempool_populate_anon*(mp: ptr rte_mempool): cint {.importc, header: "rte_mempool.h".}
proc rte_mempool_obj_iter*(mp: ptr rte_mempool; obj_cb: ptr rte_mempool_obj_cb_t;
                          obj_cb_arg: pointer): uint32 {.importc, header: "rte_mempool.h".}
proc rte_mempool_mem_iter*(mp: ptr rte_mempool; mem_cb: ptr rte_mempool_mem_cb_t;
                          mem_cb_arg: pointer): uint32 {.importc, header: "rte_mempool.h".}
proc rte_mempool_dump*(f: ptr FILE; mp: ptr rte_mempool) {.importc, header: "rte_mempool.h".}
proc rte_mempool_cache_create*(size: uint32; socket_id: cint): ptr rte_mempool_cache {.importc, header: "rte_mempool.h".}
proc rte_mempool_cache_free*(cache: ptr rte_mempool_cache) {.importc, header: "rte_mempool.h".}
proc rte_mempool_cache_flush*(cache: ptr rte_mempool_cache; mp: ptr rte_mempool) {.inline, importc, header: "rte_mempool.h".}

proc rte_mempool_default_cache*(mp: ptr rte_mempool; lcore_id: cuint): ptr rte_mempool_cache {.inline, importc, header: "rte_mempool.h".}

proc rte_mempool_generic_put*(mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint;
                             cache: ptr rte_mempool_cache; flags: cint) {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_mp_put_bulk*(mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint) {.inline, importc, header: "rte_mempool.h".}

proc rte_mempool_sp_put_bulk*(mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint) {.inline, importc, header: "rte_mempool.h".}

proc rte_mempool_put_bulk*(mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint) {.inline, importc, header: "rte_mempool.h".}

proc rte_mempool_mp_put*(mp: ptr rte_mempool; obj: pointer) {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_sp_put*(mp: ptr rte_mempool; obj: pointer) {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_put*(mp: ptr rte_mempool; obj: pointer) {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_generic_get*(mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint;
                             cache: ptr rte_mempool_cache; flags: cint): cint {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_mc_get_bulk*(mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint): cint {.inline, importc, header: "rte_mempool.h".}

proc rte_mempool_sc_get_bulk*(mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint): cint {.inline, importc, header: "rte_mempool.h".}

proc rte_mempool_get_bulk*(mp: ptr rte_mempool; obj_table: ptr pointer; n: cuint): cint {.inline, importc, header: "rte_mempool.h".}

proc rte_mempool_mc_get*(mp: ptr rte_mempool; obj_p: ptr pointer): cint {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_sc_get*(mp: ptr rte_mempool; obj_p: ptr pointer): cint {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_get*(mp: ptr rte_mempool; obj_p: ptr pointer): cint {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_avail_count*(mp: ptr rte_mempool): cuint {.importc, header: "rte_mempool.h".}
proc rte_mempool_count*(mp: ptr rte_mempool): cuint {.importc, header: "rte_mempool.h".}
proc rte_mempool_in_use_count*(mp: ptr rte_mempool): cuint {.importc, header: "rte_mempool.h".}
proc rte_mempool_free_count*(mp: ptr rte_mempool): cuint {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_full*(mp: ptr rte_mempool): cint {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_empty*(mp: ptr rte_mempool): cint {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_virt2phy*(mp: ptr rte_mempool; elt: pointer): phys_addr_t {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_audit*(mp: ptr rte_mempool) {.importc, header: "rte_mempool.h".}
proc rte_mempool_get_priv*(mp: ptr rte_mempool): pointer {.inline, importc, header: "rte_mempool.h".}
proc rte_mempool_list_dump*(f: ptr FILE) {.importc, header: "rte_mempool.h".}
proc rte_mempool_lookup*(name: cstring): ptr rte_mempool {.importc, header: "rte_mempool.h".}
proc rte_mempool_calc_obj_size*(elt_size: uint32; flags: uint32;
                               sz: ptr rte_mempool_objsz): uint32 {.importc, header: "rte_mempool.h".}
proc rte_mempool_xmem_size*(elt_num: uint32; total_elt_sz: csize;
                           pg_shift: uint32): csize {.importc, header: "rte_mempool.h".}
proc rte_mempool_xmem_usage*(vaddr: pointer; elt_num: uint32; total_elt_sz: csize;
                            paddr: ptr phys_addr_t; pg_num: uint32;
                            pg_shift: uint32): int64 {.importc, header: "rte_mempool.h".}
proc rte_mempool_walk*(`func`: proc (a2: ptr rte_mempool; arg: pointer); arg: pointer) {.importc, header: "rte_mempool.h".}
