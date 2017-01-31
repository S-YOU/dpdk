type
  rte_crypto_op_type* = enum
    RTE_CRYPTO_OP_TYPE_UNDEFINED, RTE_CRYPTO_OP_TYPE_SYMMETRIC

  rte_crypto_op_status* = enum
    RTE_CRYPTO_OP_STATUS_SUCCESS, RTE_CRYPTO_OP_STATUS_NOT_PROCESSED,
    RTE_CRYPTO_OP_STATUS_ENQUEUED, RTE_CRYPTO_OP_STATUS_AUTH_FAILED,
    RTE_CRYPTO_OP_STATUS_INVALID_SESSION, RTE_CRYPTO_OP_STATUS_INVALID_ARGS,
    RTE_CRYPTO_OP_STATUS_ERROR

  rte_crypto_sym_op_sess_type* = enum
    RTE_CRYPTO_SYM_OP_WITH_SESSION, RTE_CRYPTO_SYM_OP_SESSIONLESS

  rte_cryptodev_type* = enum
    RTE_CRYPTODEV_NULL_PMD = 1, RTE_CRYPTODEV_AESNI_GCM_PMD,
    RTE_CRYPTODEV_AESNI_MB_PMD, RTE_CRYPTODEV_QAT_SYM_PMD,
    RTE_CRYPTODEV_SNOW3G_PMD, RTE_CRYPTODEV_KASUMI_PMD

  INNER_C_STRUCT_2985627708* = object
    dev_id*: uint8
    dev_type*: rte_cryptodev_type
    mp*: ptr rte_mempool

  rte_cryptodev_sym_session* = object
    ano_3010412218*: INNER_C_STRUCT_2985627708
    private*: array[0, char]

  rte_crypto_sym_xform_type* = enum
    RTE_CRYPTO_SYM_XFORM_NOT_SPECIFIED = 0, RTE_CRYPTO_SYM_XFORM_AUTH,
    RTE_CRYPTO_SYM_XFORM_CIPHER

  rte_crypto_auth_operation* = enum
    RTE_CRYPTO_AUTH_OP_VERIFY, RTE_CRYPTO_AUTH_OP_GENERATE

  INNER_C_STRUCT_3345142729* = object
    data*: ptr uint8
    length*: csize

  rte_crypto_auth_algorithm* = enum
    RTE_CRYPTO_AUTH_NULL = 1, RTE_CRYPTO_AUTH_AES_CBC_MAC, RTE_CRYPTO_AUTH_AES_CCM,
    RTE_CRYPTO_AUTH_AES_CMAC, RTE_CRYPTO_AUTH_AES_GCM, RTE_CRYPTO_AUTH_AES_GMAC,
    RTE_CRYPTO_AUTH_AES_XCBC_MAC, RTE_CRYPTO_AUTH_KASUMI_F9, RTE_CRYPTO_AUTH_MD5,
    RTE_CRYPTO_AUTH_MD5_HMAC, RTE_CRYPTO_AUTH_SHA1, RTE_CRYPTO_AUTH_SHA1_HMAC,
    RTE_CRYPTO_AUTH_SHA224, RTE_CRYPTO_AUTH_SHA224_HMAC, RTE_CRYPTO_AUTH_SHA256,
    RTE_CRYPTO_AUTH_SHA256_HMAC, RTE_CRYPTO_AUTH_SHA384,
    RTE_CRYPTO_AUTH_SHA384_HMAC, RTE_CRYPTO_AUTH_SHA512,
    RTE_CRYPTO_AUTH_SHA512_HMAC, RTE_CRYPTO_AUTH_SNOW3G_UIA2,
    RTE_CRYPTO_AUTH_ZUC_EIA3, RTE_CRYPTO_AUTH_LIST_END

  rte_crypto_auth_xform* = object
    op*: rte_crypto_auth_operation
    algo*: rte_crypto_auth_algorithm
    key*: INNER_C_STRUCT_3345142729
    digest_length*: uint32
    add_auth_data_length*: uint32

  rte_crypto_cipher_operation* = enum
    RTE_CRYPTO_CIPHER_OP_ENCRYPT, RTE_CRYPTO_CIPHER_OP_DECRYPT

  INNER_C_STRUCT_247578448* = object
    data*: ptr uint8
    length*: csize
type
  rte_crypto_cipher_algorithm* = enum
    RTE_CRYPTO_CIPHER_NULL = 1, RTE_CRYPTO_CIPHER_3DES_CBC,
    RTE_CRYPTO_CIPHER_3DES_CTR, RTE_CRYPTO_CIPHER_3DES_ECB,
    RTE_CRYPTO_CIPHER_AES_CBC, RTE_CRYPTO_CIPHER_AES_CCM,
    RTE_CRYPTO_CIPHER_AES_CTR, RTE_CRYPTO_CIPHER_AES_ECB,
    RTE_CRYPTO_CIPHER_AES_F8, RTE_CRYPTO_CIPHER_AES_GCM,
    RTE_CRYPTO_CIPHER_AES_XTS, RTE_CRYPTO_CIPHER_ARC4,
    RTE_CRYPTO_CIPHER_KASUMI_F8, RTE_CRYPTO_CIPHER_SNOW3G_UEA2,
    RTE_CRYPTO_CIPHER_ZUC_EEA3, RTE_CRYPTO_CIPHER_LIST_END

  rte_crypto_cipher_xform* = object
    op*: rte_crypto_cipher_operation
    algo*: rte_crypto_cipher_algorithm
    key*: INNER_C_STRUCT_247578448

  INNER_C_UNION_578303810* = object {.union.}
    auth*: rte_crypto_auth_xform
    cipher*: rte_crypto_cipher_xform

  rte_crypto_sym_xform* = object
    next*: ptr rte_crypto_sym_xform
    `type`*: rte_crypto_sym_xform_type
    ano_594826815*: INNER_C_UNION_578303810


  INNER_C_UNION_1391937029* = object {.union.}
    session*: ptr rte_cryptodev_sym_session
    xform*: ptr rte_crypto_sym_xform
  
  INNER_C_STRUCT_2574929262* = object
    offset*: uint32
    length*: uint32

  INNER_C_STRUCT_357537179* = object
    data*: ptr uint8
    phys_addr*: phys_addr_t
    length*: uint16

  INNER_C_STRUCT_1424983049* = object
    data*: INNER_C_STRUCT_2574929262
    iv*: INNER_C_STRUCT_357537179

  INNER_C_STRUCT_3450307168* = object
    offset*: uint32
    length*: uint32

  INNER_C_STRUCT_2277688667* = object
    data*: ptr uint8
    phys_addr*: phys_addr_t
    length*: uint16

  INNER_C_STRUCT_1885657366* = object
    data*: ptr uint8
    phys_addr*: phys_addr_t
    length*: uint16

  INNER_C_STRUCT_3302079714* = object
    data*: INNER_C_STRUCT_3450307168
    digest*: INNER_C_STRUCT_2277688667
    aad*: INNER_C_STRUCT_1885657366
  rte_crypto_sym_op* = object
    m_src*: ptr rte_mbuf
    m_dst*: ptr rte_mbuf
    sess_type*: rte_crypto_sym_op_sess_type
    ano_1408460034*: INNER_C_UNION_1391937029
    cipher*: INNER_C_STRUCT_1424983049
    auth*: INNER_C_STRUCT_3302079714

  INNER_C_UNION_543915601* = object {.union.}
    sym*: ptr rte_crypto_sym_op

  rte_crypto_op* = object
    `type`*: rte_crypto_op_type
    status*: rte_crypto_op_status
    mempool*: ptr rte_mempool
    phys_addr*: phys_addr_t
    opaque_data*: pointer
    ano_552177101*: INNER_C_UNION_543915601

  rte_crypto_op_pool_private* = object
    `type`*: rte_crypto_op_type
    priv_size*: uint16


proc rte_crypto_op_alloc*(mempool: ptr rte_mempool; `type`: rte_crypto_op_type): ptr rte_crypto_op {.inline, importc, header: "rte_crypto.h".}

proc rte_crypto_op_bulk_alloc*(mempool: ptr rte_mempool; `type`: rte_crypto_op_type;
                              ops: ptr ptr rte_crypto_op; nb_ops: uint16): cuint {.inline, importc, header: "rte_crypto.h".}

proc rte_crypto_op_free*(op: ptr rte_crypto_op) {.inline, importc, header: "rte_crypto.h".}
proc rte_crypto_sym_op_alloc_from_mbuf_priv_data*(m: ptr rte_mbuf): ptr rte_crypto_op {.inline, importc, header: "rte_crypto.h".}

proc rte_crypto_op_sym_xforms_alloc*(op: ptr rte_crypto_op; nb_xforms: uint8): ptr rte_crypto_sym_xform {.inline, importc, header: "rte_crypto.h".}

proc rte_crypto_op_attach_sym_session*(op: ptr rte_crypto_op;
                                      sess: ptr rte_cryptodev_sym_session): cint {.inline, importc, header: "rte_crypto.h".}

const
  RTE_CRYPTODEV_FF_SYMMETRIC_CRYPTO* = (1 shl 0)
  RTE_CRYPTODEV_FF_ASYMMETRIC_CRYPTO* = (1 shl 1)
  RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING* = (1 shl 2)
  RTE_CRYPTODEV_FF_CPU_SSE* = (1 shl 3)
  RTE_CRYPTODEV_FF_CPU_AVX* = (1 shl 4)
  RTE_CRYPTODEV_FF_CPU_AVX2* = (1 shl 5)
  RTE_CRYPTODEV_FF_CPU_AESNI* = (1 shl 6)
  RTE_CRYPTODEV_FF_HW_ACCELERATED* = (1 shl 7)
  RTE_CRYPTODEV_DETACHED* = (0)
  RTE_CRYPTODEV_ATTACHED* = (1)
  RTE_CRYPTODEV_NAME_MAX_LEN* = (64)


type
  INNER_C_STRUCT_595800459* = object
    min*: uint16
    max*: uint16
    increment*: uint16

  INNER_C_STRUCT_2127396049* = object
    min*: uint16
    max*: uint16
    increment*: uint16

  INNER_C_STRUCT_1735364748* = object
    min*: uint16
    max*: uint16
    increment*: uint16

  INNER_C_STRUCT_3672357354* = object
    algo*: rte_crypto_auth_algorithm
    block_size*: uint16
    key_size*: INNER_C_STRUCT_595800459
    digest_size*: INNER_C_STRUCT_2127396049
    aad_size*: INNER_C_STRUCT_1735364748

  INNER_C_STRUCT_2094341838* = object
    min*: uint16
    max*: uint16
    increment*: uint16

  INNER_C_STRUCT_3625937428* = object
    min*: uint16
    max*: uint16
    increment*: uint16

  INNER_C_STRUCT_930302951* = object
    algo*: rte_crypto_cipher_algorithm
    block_size*: uint16
    key_size*: INNER_C_STRUCT_2094341838
    iv_size*: INNER_C_STRUCT_3625937428

  INNER_C_UNION_3664095850* = object {.union.}
    auth*: INNER_C_STRUCT_3672357354
    cipher*: INNER_C_STRUCT_930302951

  rte_cryptodev_symmetric_capability* = object
    xform_type*: rte_crypto_sym_xform_type
    ano_1735674661*: INNER_C_UNION_3664095850

  INNER_C_UNION_2474954340* = object {.union.}
    sym*: rte_cryptodev_symmetric_capability

  rte_cryptodev_capabilities* = object
    op*: rte_crypto_op_type
    ano_2483215840*: INNER_C_UNION_2474954340

  INNER_C_STRUCT_2390685907* = object
    max_nb_sessions*: cuint

  rte_cryptodev_info* = object
    driver_name*: cstring
    dev_type*: rte_cryptodev_type
    pci_dev*: ptr rte_pci_device
    feature_flags*: uint64
    capabilities*: ptr rte_cryptodev_capabilities
    max_nb_queue_pairs*: cuint
    sym*: INNER_C_STRUCT_2390685907

  rte_cryptodev_event_type* = enum
    RTE_CRYPTODEV_EVENT_UNKNOWN, RTE_CRYPTODEV_EVENT_ERROR,
    RTE_CRYPTODEV_EVENT_MAX


type
  rte_cryptodev_qp_conf* = object
    nb_descriptors*: uint32

  rte_cryptodev_cb_fn* = proc (dev_id: uint8; event: rte_cryptodev_event_type;
                            cb_arg: pointer) {.cdecl.}
  rte_cryptodev_stats* = object
    enqueued_count*: uint64
    dequeued_count*: uint64
    enqueue_err_count*: uint64
    dequeue_err_count*: uint64

  rte_crypto_vdev_init_params* = object
    max_nb_queue_pairs*: cuint
    max_nb_sessions*: cuint
    socket_id*: uint8


proc rte_cryptodev_parse_vdev_init_params*(
    params: ptr rte_crypto_vdev_init_params; input_args: cstring): cint {.importc, header: "rte_cryptodev.h".}
type
  INNER_C_STRUCT_3075585876* = object
    nb_objs*: uint32
    cache_size*: uint32

  rte_cryptodev_config* = object
    socket_id*: cint
    nb_queue_pairs*: uint16
    session_mp*: INNER_C_STRUCT_3075585876

  dequeue_pkt_burst_t* = proc (qp: pointer; ops: ptr ptr rte_crypto_op; nb_ops: uint16): uint16 {.cdecl.}
  enqueue_pkt_burst_t* = proc (qp: pointer; ops: ptr ptr rte_crypto_op; nb_ops: uint16): uint16 {.cdecl.}
  rte_cryptodev_callback* = object
  
  rte_cryptodev_cb_list* = object
    tqh_first*: ptr rte_cryptodev_callback
    tqh_last*: ptr ptr rte_cryptodev_callback

  cryptodev_init_t* = proc (drv: ptr rte_cryptodev_driver; dev: ptr rte_cryptodev): cint {.cdecl.}
  cryptodev_uninit_t* = proc (drv: ptr rte_cryptodev_driver; dev: ptr rte_cryptodev): cint {.cdecl.}

  rte_cryptodev_driver* = object
    pci_drv*: rte_pci_driver
    dev_private_size*: cuint
    cryptodev_init*: cryptodev_init_t
    cryptodev_uninit*: cryptodev_uninit_t

  cryptodev_configure_t* = proc (dev: ptr rte_cryptodev): cint {.cdecl.}
  cryptodev_start_t* = proc (dev: ptr rte_cryptodev): cint {.cdecl.}
  cryptodev_stop_t* = proc (dev: ptr rte_cryptodev) {.cdecl.}
  cryptodev_close_t* = proc (dev: ptr rte_cryptodev): cint {.cdecl.}
  cryptodev_stats_get_t* = proc (dev: ptr rte_cryptodev;
                              stats: ptr rte_cryptodev_stats) {.cdecl.}
  cryptodev_stats_reset_t* = proc (dev: ptr rte_cryptodev) {.cdecl.}
  cryptodev_info_get_t* = proc (dev: ptr rte_cryptodev;
                             dev_info: ptr rte_cryptodev_info) {.cdecl.}
  cryptodev_queue_pair_start_t* = proc (dev: ptr rte_cryptodev; qp_id: uint16): cint {.cdecl.}
  cryptodev_queue_pair_stop_t* = proc (dev: ptr rte_cryptodev; qp_id: uint16): cint {.cdecl.}
  cryptodev_queue_pair_setup_t* = proc (dev: ptr rte_cryptodev; qp_id: uint16;
                                     qp_conf: ptr rte_cryptodev_qp_conf;
                                     socket_id: cint): cint {.cdecl.}
  cryptodev_queue_pair_release_t* = proc (dev: ptr rte_cryptodev; qp_id: uint16): cint {.cdecl.}
  cryptodev_queue_pair_count_t* = proc (dev: ptr rte_cryptodev): uint32 {.cdecl.}
  cryptodev_sym_create_session_pool_t* = proc (dev: ptr rte_cryptodev; nb_objs: cuint;
      obj_cache_size: cuint; socket_id: cint): cint {.cdecl.}
  cryptodev_sym_get_session_private_size_t* = proc (dev: ptr rte_cryptodev): cuint {.cdecl.}
  cryptodev_sym_initialize_session_t* = proc (mempool: ptr rte_mempool;
      session_private: pointer) {.cdecl.}
  cryptodev_sym_configure_session_t* = proc (dev: ptr rte_cryptodev;
      xform: ptr rte_crypto_sym_xform; session_private: pointer): pointer {.cdecl.}
  cryptodev_sym_free_session_t* = proc (dev: ptr rte_cryptodev;
                                     session_private: pointer) {.cdecl.}
  rte_cryptodev_ops* = object
    dev_configure*: cryptodev_configure_t
    dev_start*: cryptodev_start_t
    dev_stop*: cryptodev_stop_t
    dev_close*: cryptodev_close_t
    dev_infos_get*: cryptodev_info_get_t
    stats_get*: cryptodev_stats_get_t
    stats_reset*: cryptodev_stats_reset_t
    queue_pair_setup*: cryptodev_queue_pair_setup_t
    queue_pair_release*: cryptodev_queue_pair_release_t
    queue_pair_start*: cryptodev_queue_pair_start_t
    queue_pair_stop*: cryptodev_queue_pair_stop_t
    queue_pair_count*: cryptodev_queue_pair_count_t
    session_get_size*: cryptodev_sym_get_session_private_size_t
    session_initialize*: cryptodev_sym_initialize_session_t
    session_configure*: cryptodev_sym_configure_session_t
    session_clear*: cryptodev_sym_free_session_t

  rte_cryptodev* = object
    dequeue_burst*: dequeue_pkt_burst_t
    enqueue_burst*: enqueue_pkt_burst_t
    driver*: ptr rte_cryptodev_driver
    data*: ptr rte_cryptodev_data
    dev_ops*: ptr rte_cryptodev_ops
    feature_flags*: uint64
    pci_dev*: ptr rte_pci_device
    dev_type*: rte_cryptodev_type
    pmd_type*: pmd_type
    link_intr_cbs*: rte_cryptodev_cb_list
    attached* {.bitsize: 1.}: uint8

  rte_cryptodev_data* = object
    dev_id*: uint8
    socket_id*: uint8
    name*: array[(64), char]
    dev_started* {.bitsize: 1.}: uint8
    session_pool*: ptr rte_mempool
    queue_pairs*: ptr pointer
    nb_queue_pairs*: uint16
    dev_private*: pointer


proc rte_cryptodev_dequeue_burst*(dev_id: uint8; qp_id: uint16;
                                 ops: ptr ptr rte_crypto_op; nb_ops: uint16): uint16 {.inline, importc, header: "rte_cryptodev.h".}

proc rte_cryptodev_enqueue_burst*(dev_id: uint8; qp_id: uint16;
                                 ops: ptr ptr rte_crypto_op; nb_ops: uint16): uint16 {.inline, importc, header: "rte_cryptodev.h".}





type
  INNER_C_STRUCT_540751557* = object
    dev_id*: uint8
    `type`*: rte_cryptodev_type
    mp*: ptr rte_mempool

  rte_cryptodev_session* = object
    ano_565536067*: INNER_C_STRUCT_540751557
    private*: array[0, char]

  rte_cryptodev_global* = object
    devs*: ptr rte_cryptodev
    data*: array[RTE_CRYPTO_MAX_DEVS, ptr rte_cryptodev_data]
    nb_devs*: uint8
    max_devs*: uint8


proc rte_cryptodev_pmd_get_dev*(dev_id: uint8): ptr rte_cryptodev {.inline, importc, header: "rte_cryptodev_pmd.h".}
proc rte_cryptodev_pmd_get_named_dev*(name: cstring): ptr rte_cryptodev {.inline, importc, header: "rte_cryptodev_pmd.h".}
proc rte_cryptodev_pmd_is_valid_dev*(dev_id: uint8): cuint {.inline, importc, header: "rte_cryptodev_pmd.h".}



proc rte_cryptodev_pmd_allocate*(name: cstring; `type`: pmd_type; socket_id: cint): ptr rte_cryptodev {.importc, header: "rte_cryptodev_pmd.h".}
proc rte_cryptodev_pmd_virtual_dev_init*(name: cstring; dev_private_size: csize;
                                        socket_id: cint): ptr rte_cryptodev {.importc, header: "rte_cryptodev_pmd.h".}
proc rte_cryptodev_pmd_callback_process*(dev: ptr rte_cryptodev;
                                        event: rte_cryptodev_event_type) {.importc, header: "rte_cryptodev_pmd.h".}
