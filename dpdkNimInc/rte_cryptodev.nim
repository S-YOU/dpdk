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
  rte_cryptodev_type* = enum
    RTE_CRYPTODEV_NULL_PMD = 1, RTE_CRYPTODEV_AESNI_GCM_PMD,
    RTE_CRYPTODEV_AESNI_MB_PMD, RTE_CRYPTODEV_QAT_SYM_PMD,
    RTE_CRYPTODEV_SNOW3G_PMD, RTE_CRYPTODEV_KASUMI_PMD


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
  INNER_C_STRUCT_2985627708* = object
    dev_id*: uint8
    dev_type*: rte_cryptodev_type
    mp*: ptr rte_mempool

  rte_cryptodev_sym_session* = object
    ano_3010412218*: INNER_C_STRUCT_2985627708
    private*: array[0, char]

