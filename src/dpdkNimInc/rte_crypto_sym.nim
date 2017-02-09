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


type
  rte_crypto_cipher_operation* = enum
    RTE_CRYPTO_CIPHER_OP_ENCRYPT, RTE_CRYPTO_CIPHER_OP_DECRYPT


type
  INNER_C_STRUCT_247578448* = object
    data*: ptr uint8
    length*: csize

  rte_crypto_cipher_xform* {.importc: "struct rte_crypto_cipher_xform", header: "rte_crypto_sym.h".} = object
    op*: rte_crypto_cipher_operation
    algo*: rte_crypto_cipher_algorithm
    key*: INNER_C_STRUCT_247578448

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


type
  rte_crypto_auth_operation* = enum
    RTE_CRYPTO_AUTH_OP_VERIFY, RTE_CRYPTO_AUTH_OP_GENERATE


type
  INNER_C_STRUCT_3345142729* = object
    data*: ptr uint8
    length*: csize

  rte_crypto_auth_xform* {.importc: "struct rte_crypto_auth_xform", header: "rte_crypto_sym.h".} = object
    op*: rte_crypto_auth_operation
    algo*: rte_crypto_auth_algorithm
    key*: INNER_C_STRUCT_3345142729
    digest_length*: uint32
    add_auth_data_length*: uint32

  rte_crypto_sym_xform_type* = enum
    RTE_CRYPTO_SYM_XFORM_NOT_SPECIFIED = 0, RTE_CRYPTO_SYM_XFORM_AUTH,
    RTE_CRYPTO_SYM_XFORM_CIPHER


type
  INNER_C_UNION_578303810* = object {.union.}
    auth*: rte_crypto_auth_xform
    cipher*: rte_crypto_cipher_xform

  rte_crypto_sym_xform* {.importc: "struct rte_crypto_sym_xform", header: "rte_crypto_sym.h".} = object
    next*: ptr rte_crypto_sym_xform
    `type`*: rte_crypto_sym_xform_type
    ano_594826815*: INNER_C_UNION_578303810

  rte_crypto_sym_op_sess_type* = enum
    RTE_CRYPTO_SYM_OP_WITH_SESSION, RTE_CRYPTO_SYM_OP_SESSIONLESS


type
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

  rte_crypto_sym_op* {.importc: "struct rte_crypto_sym_op", header: "rte_crypto_sym.h".} = object
    m_src*: ptr rte_mbuf
    m_dst*: ptr rte_mbuf
    sess_type*: rte_crypto_sym_op_sess_type
    ano_1408460034*: INNER_C_UNION_1391937029
    cipher*: INNER_C_STRUCT_1424983049
    auth*: INNER_C_STRUCT_3302079714

