const
  IP_FRAG_DEATH_ROW_LEN* = 32
  RTE_IPV6_EHDR_MF_SHIFT* = 0
  RTE_IPV6_EHDR_MF_MASK* = 1
  RTE_IPV6_EHDR_FO_SHIFT* = 3
  RTE_IPV6_EHDR_FO_MASK* = (not ((1 shl RTE_IPV6_EHDR_FO_SHIFT) - 1))
  RTE_IPV6_FRAG_USED_MASK* = (RTE_IPV6_EHDR_MF_MASK or RTE_IPV6_EHDR_FO_MASK)

const
  IP_LAST_FRAG_IDX* = 0
  IP_FIRST_FRAG_IDX* = 1
  IP_MIN_FRAG_NUM* = 2
  IP_MAX_FRAG_NUM* = RTE_LIBRTE_IP_FRAG_MAX_FRAG

type
  ip_frag* {.importc: "struct ip_frag", header: "rte_ip_frag.h".} = object
    ofs*: uint16
    len*: uint16
    mb*: ptr rte_mbuf

  ip_frag_key* {.importc: "struct ip_frag_key", header: "rte_ip_frag.h".} = object
    src_dst*: array[4, uint64]
    id*: uint32
    key_len*: uint32

  INNER_C_STRUCT_1474051330* = object
    tqe_next*: ptr ip_frag_pkt
    tqe_prev*: ptr ptr ip_frag_pkt

  ip_frag_pkt* {.importc: "struct ip_frag_pkt", header: "rte_ip_frag.h".} = object
    lru*: INNER_C_STRUCT_1474051330
    key*: ip_frag_key
    start*: uint64
    total_size*: uint32
    frag_size*: uint32
    last_idx*: uint32
    frags*: array[IP_MAX_FRAG_NUM, ip_frag]

  rte_ip_frag_death_row* {.importc: "struct rte_ip_frag_death_row", header: "rte_ip_frag.h".} = object
    cnt*: uint32
    row*: array[32 * (IP_MAX_FRAG_NUM + 1), ptr rte_mbuf]

  ip_pkt_list* {.importc: "struct ip_pkt_list", header: "rte_ip_frag.h".} = object
    tqh_first*: ptr ip_frag_pkt
    tqh_last*: ptr ptr ip_frag_pkt

  ip_frag_tbl_stat* {.importc: "struct ip_frag_tbl_stat", header: "rte_ip_frag.h".} = object
    find_num*: uint64
    add_num*: uint64
    del_num*: uint64
    reuse_num*: uint64
    fail_total*: uint64
    fail_nospace*: uint64

  rte_ip_frag_tbl* {.importc: "struct rte_ip_frag_tbl", header: "rte_ip_frag.h".} = object
    max_cycles*: uint64
    entry_mask*: uint32
    max_entries*: uint32
    use_entries*: uint32
    bucket_entries*: uint32
    nb_entries*: uint32
    nb_buckets*: uint32
    last*: ptr ip_frag_pkt
    lru*: ip_pkt_list
    stat*: ip_frag_tbl_stat
    pkt*: array[0, ip_frag_pkt]

  ipv6_extension_fragment* {.importc: "struct ipv6_extension_fragment", header: "rte_ip_frag.h".} = object
    next_header*: uint8
    reserved*: uint8
    frag_data*: uint16
    id*: uint32


proc rte_ip_frag_table_create*(bucket_num: uint32; bucket_entries: uint32;
                              max_entries: uint32; max_cycles: uint64;
                              socket_id: cint): ptr rte_ip_frag_tbl {.importc, header: "rte_ip_frag.h".}
proc rte_ip_frag_table_destroy*(tbl: ptr rte_ip_frag_tbl) {.inline, importc, header: "rte_ip_frag.h".}
proc rte_ipv6_fragment_packet*(pkt_in: ptr rte_mbuf; pkts_out: ptr ptr rte_mbuf;
                              nb_pkts_out: uint16; mtu_size: uint16;
                              pool_direct: ptr rte_mempool;
                              pool_indirect: ptr rte_mempool): int32 {.importc, header: "rte_ip_frag.h".}
proc rte_ipv6_frag_reassemble_packet*(tbl: ptr rte_ip_frag_tbl;
                                     dr: ptr rte_ip_frag_death_row;
                                     mb: ptr rte_mbuf; tms: uint64;
                                     ip_hdr: ptr ipv6_hdr;
                                     frag_hdr: ptr ipv6_extension_fragment): ptr rte_mbuf {.importc, header: "rte_ip_frag.h".}
proc rte_ipv6_frag_get_ipv6_fragment_header*(hdr: ptr ipv6_hdr): ptr ipv6_extension_fragment {.inline, importc, header: "rte_ip_frag.h".}

proc rte_ipv4_fragment_packet*(pkt_in: ptr rte_mbuf; pkts_out: ptr ptr rte_mbuf;
                              nb_pkts_out: uint16; mtu_size: uint16;
                              pool_direct: ptr rte_mempool;
                              pool_indirect: ptr rte_mempool): int32 {.importc, header: "rte_ip_frag.h".}
proc rte_ipv4_frag_reassemble_packet*(tbl: ptr rte_ip_frag_tbl;
                                     dr: ptr rte_ip_frag_death_row;
                                     mb: ptr rte_mbuf; tms: uint64;
                                     ip_hdr: ptr ipv4_hdr): ptr rte_mbuf {.importc, header: "rte_ip_frag.h".}
proc rte_ipv4_frag_pkt_is_fragmented*(hdr: ptr ipv4_hdr): cint {.inline, importc, header: "rte_ip_frag.h".}
proc rte_ip_frag_free_death_row*(dr: ptr rte_ip_frag_death_row; prefetch: uint32) {.importc, header: "rte_ip_frag.h".}
proc rte_ip_frag_table_statistics_dump*(f: ptr FILE; tbl: ptr rte_ip_frag_tbl) {.importc, header: "rte_ip_frag.h".}
