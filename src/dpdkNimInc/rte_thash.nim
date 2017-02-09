type
  INNER_C_STRUCT_2603012939* = object
    dport*: uint16
    sport*: uint16

  INNER_C_UNION_116569836* = object {.union.}
    ano_141354347*: INNER_C_STRUCT_2603012939
    sctp_tag*: uint32

  rte_ipv4_tuple* {.importc: "struct rte_ipv4_tuple", header: "rte_thash.h".} = object
    src_addr*: uint32
    dst_addr*: uint32
    ano_2609771061*: INNER_C_UNION_116569836

  INNER_C_STRUCT_2144423927* = object
    dport*: uint16
    sport*: uint16

  INNER_C_UNION_2659340096* = object {.union.}
    ano_2684124607*: INNER_C_STRUCT_2144423927
    sctp_tag*: uint32

  rte_ipv6_tuple* {.importc: "struct rte_ipv6_tuple", header: "rte_thash.h".} = object
    src_addr*: array[16, uint8]
    dst_addr*: array[16, uint8]
    ano_3398619765*: INNER_C_UNION_2659340096

  rte_thash_tuple* {.importc: "struct rte_thash_tuple", header: "rte_thash.h", union.} = object
    v4*: rte_ipv4_tuple
    v6*: rte_ipv6_tuple


proc rte_convert_rss_key*(orig: ptr uint32; targ: ptr uint32; len: cint) {.inline, importc, header: "rte_thash.h".}
proc rte_thash_load_v6_addrs*(orig: ptr ipv6_hdr; targ: ptr rte_thash_tuple) {.inline, importc, header: "rte_thash.h".}
proc rte_softrss*(input_tuple: ptr uint32; input_len: uint32; rss_key: ptr uint8): uint32 {.inline, importc, header: "rte_thash.h".}

proc rte_softrss_be*(input_tuple: ptr uint32; input_len: uint32;
                    rss_key: ptr uint8): uint32 {.inline, importc, header: "rte_thash.h".}
