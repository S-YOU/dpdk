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


  INNER_C_UNION_543915601* = object {.union.}
    sym*: ptr rte_crypto_sym_op

  rte_crypto_op* {.importc: "struct rte_crypto_op", header: "rte_crypto.h".} = object
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

