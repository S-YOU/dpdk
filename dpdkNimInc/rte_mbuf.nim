const
  PKT_RX_VLAN_PKT* = (1 shl 0)
  PKT_RX_RSS_HASH* = (1 shl 1)
  PKT_RX_FDIR* = (1 shl 2)
  PKT_RX_L4_CKSUM_BAD* = (1 shl 3)
  PKT_RX_IP_CKSUM_BAD* = (1 shl 4)
  PKT_RX_EIP_CKSUM_BAD* = (1 shl 5)
  PKT_RX_VLAN_STRIPPED* = (1 shl 6)
  PKT_RX_IEEE1588_PTP* = (1 shl 9)
  PKT_RX_IEEE1588_TMST* = (1 shl 10)
  PKT_RX_FDIR_ID* = (1 shl 13)
  PKT_RX_FDIR_FLX* = (1 shl 14)
  PKT_RX_QINQ_STRIPPED* = (1 shl 15)
  PKT_RX_QINQ_PKT* = PKT_RX_QINQ_STRIPPED
  PKT_TX_QINQ_PKT* = (1 shl 49)
  PKT_TX_TCP_SEG* = (1 shl 50)
  PKT_TX_IEEE1588_TMST* = (1 shl 51)
  PKT_TX_L4_NO_CKSUM* = (0 shl 52)
  PKT_TX_TCP_CKSUM* = (1 shl 52)
  PKT_TX_SCTP_CKSUM* = (2 shl 52)
  PKT_TX_UDP_CKSUM* = (3 shl 52)
  PKT_TX_L4_MASK* = (3 shl 52)
  PKT_TX_IP_CKSUM* = (1 shl 54)
  PKT_TX_IPV4* = (1 shl 55)
  PKT_TX_IPV6* = (1 shl 56)
  PKT_TX_VLAN_PKT* = (1 shl 57)
  PKT_TX_OUTER_IP_CKSUM* = (1 shl 58)
  PKT_TX_OUTER_IPV4* = (1 shl 59)
  PKT_TX_OUTER_IPV6* = (1 shl 60)
  IND_ATTACHED_MBUF* = (1 shl 62)
  CTRL_MBUF_FLAG* = (1 shl 63)
  RTE_PTYPE_UNKNOWN* = 0x00000000
  RTE_PTYPE_L2_ETHER* = 0x00000001
  RTE_PTYPE_L2_ETHER_TIMESYNC* = 0x00000002
  RTE_PTYPE_L2_ETHER_ARP* = 0x00000003
  RTE_PTYPE_L2_ETHER_LLDP* = 0x00000004
  RTE_PTYPE_L2_ETHER_NSH* = 0x00000005
  RTE_PTYPE_L2_MASK* = 0x0000000F
  RTE_PTYPE_L3_IPV4* = 0x00000010
  RTE_PTYPE_L3_IPV4_EXT* = 0x00000030
  RTE_PTYPE_L3_IPV6* = 0x00000040
  RTE_PTYPE_L3_IPV4_EXT_UNKNOWN* = 0x00000090
  RTE_PTYPE_L3_IPV6_EXT* = 0x000000C0
  RTE_PTYPE_L3_IPV6_EXT_UNKNOWN* = 0x000000E0
  RTE_PTYPE_L3_MASK* = 0x000000F0
  RTE_PTYPE_L4_TCP* = 0x00000100
  RTE_PTYPE_L4_UDP* = 0x00000200
  RTE_PTYPE_L4_FRAG* = 0x00000300
  RTE_PTYPE_L4_SCTP* = 0x00000400
  RTE_PTYPE_L4_ICMP* = 0x00000500
  RTE_PTYPE_L4_NONFRAG* = 0x00000600
  RTE_PTYPE_L4_MASK* = 0x00000F00
  RTE_PTYPE_TUNNEL_IP* = 0x00001000
  RTE_PTYPE_TUNNEL_GRE* = 0x00002000
  RTE_PTYPE_TUNNEL_VXLAN* = 0x00003000
  RTE_PTYPE_TUNNEL_NVGRE* = 0x00004000
  RTE_PTYPE_TUNNEL_GENEVE* = 0x00005000
  RTE_PTYPE_TUNNEL_GRENAT* = 0x00006000
  RTE_PTYPE_TUNNEL_MASK* = 0x0000F000
  RTE_PTYPE_INNER_L2_ETHER* = 0x00010000
  RTE_PTYPE_INNER_L2_ETHER_VLAN* = 0x00020000
  RTE_PTYPE_INNER_L2_MASK* = 0x000F0000
  RTE_PTYPE_INNER_L3_IPV4* = 0x00100000
  RTE_PTYPE_INNER_L3_IPV4_EXT* = 0x00200000
  RTE_PTYPE_INNER_L3_IPV6* = 0x00300000
  RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN* = 0x00400000
  RTE_PTYPE_INNER_L3_IPV6_EXT* = 0x00500000
  RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN* = 0x00600000
  RTE_PTYPE_INNER_L3_MASK* = 0x00F00000
  RTE_PTYPE_INNER_L4_TCP* = 0x01000000
  RTE_PTYPE_INNER_L4_UDP* = 0x02000000
  RTE_PTYPE_INNER_L4_FRAG* = 0x03000000
  RTE_PTYPE_INNER_L4_SCTP* = 0x04000000
  RTE_PTYPE_INNER_L4_ICMP* = 0x05000000
  RTE_PTYPE_INNER_L4_NONFRAG* = 0x06000000
  RTE_PTYPE_INNER_L4_MASK* = 0x0F000000
  RTE_MBUF_PRIV_ALIGN* = 8
  RTE_MBUF_DEFAULT_DATAROOM* = 2048
  RTE_MBUF_DEFAULT_BUF_SIZE* = (RTE_MBUF_DEFAULT_DATAROOM + RTE_PKTMBUF_HEADROOM)

type
  MARKER* = array[0, pointer]
  MARKER8* = array[0, uint8]
  MARKER64* = array[0, uint64]
  INNER_C_UNION_4131198351* = object {.union.}
    refcnt_atomic*: rte_atomic16_t
    refcnt*: uint16

  INNER_C_STRUCT_975795339* = object
    l2_type* {.bitsize: 4.}: uint32
    l3_type* {.bitsize: 4.}: uint32
    l4_type* {.bitsize: 4.}: uint32
    tun_type* {.bitsize: 4.}: uint32
    inner_l2_type* {.bitsize: 4.}: uint32
    inner_l3_type* {.bitsize: 4.}: uint32
    inner_l4_type* {.bitsize: 4.}: uint32

  INNER_C_UNION_3709588236* = object {.union.}
    packet_type*: uint32
    ano_2061779376*: INNER_C_STRUCT_975795339

  INNER_C_STRUCT_3284502727* = object
    hash*: uint16
    id*: uint16

  INNER_C_UNION_2503915525* = object {.union.}
    ano_3556861736*: INNER_C_STRUCT_3284502727
    lo*: uint32

  INNER_C_STRUCT_2825843569* = object
    ano_3573384745*: INNER_C_UNION_2503915525
    hi*: uint32

  INNER_C_STRUCT_2862892616* = object
    lo*: uint32
    hi*: uint32

  INNER_C_UNION_162153928* = object {.union.}
    rss*: uint32
    fdir*: INNER_C_STRUCT_2825843569
    sched*: INNER_C_STRUCT_2862892616
    usr*: uint32

  INNER_C_UNION_83789164* = object {.union.}
    userdata*: pointer
    udata64*: uint64

  INNER_C_STRUCT_2800259597* = object
    l2_len* {.bitsize: 7.}: uint64
    l3_len* {.bitsize: 9.}: uint64
    l4_len* {.bitsize: 8.}: uint64
    tso_segsz* {.bitsize: 16.}: uint64
    outer_l3_len* {.bitsize: 9.}: uint64
    outer_l2_len* {.bitsize: 7.}: uint64

  INNER_C_UNION_1239085198* = object {.union.}
    tx_offload*: uint64
    ano_1595394530*: INNER_C_STRUCT_2800259597

  rte_mbuf* {.importc: "struct rte_mbuf", header: "rte_mbuf.h".} = object
    cacheline0*: MARKER
    buf_addr*: pointer
    buf_physaddr*: phys_addr_t
    buf_len*: uint16
    rearm_data*: MARKER8
    data_off*: uint16
    ano_1239884651*: INNER_C_UNION_4131198351
    nb_segs*: uint8
    port*: uint8
    ol_flags*: uint64
    rx_descriptor_fields1*: MARKER
    ano_2768013029*: INNER_C_UNION_3709588236
    pkt_len*: uint32
    data_len*: uint16
    vlan_tci*: uint16
    hash*: INNER_C_UNION_162153928
    seqn*: uint32
    vlan_tci_outer*: uint16
    cacheline1*: MARKER
    ano_100312171*: INNER_C_UNION_83789164
    pool*: ptr rte_mempool
    next*: ptr rte_mbuf
    ano_1603656034*: INNER_C_UNION_1239085198
    priv_size*: uint16
    timesync*: uint16


proc rte_mbuf_prefetch_part1*(m: ptr rte_mbuf) {.inline, importc, header: "rte_mbuf.h".}
proc rte_mbuf_prefetch_part2*(m: ptr rte_mbuf) {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_priv_size*(mp: ptr rte_mempool): uint16 {.inline, importc, header: "rte_mbuf.h".}
proc rte_mbuf_data_dma_addr*(mb: ptr rte_mbuf): phys_addr_t {.inline, importc, header: "rte_mbuf.h".}
proc rte_mbuf_data_dma_addr_default*(mb: ptr rte_mbuf): phys_addr_t {.inline, importc, header: "rte_mbuf.h".}
proc rte_mbuf_from_indirect*(mi: ptr rte_mbuf): ptr rte_mbuf {.inline, importc, header: "rte_mbuf.h".}
proc rte_mbuf_to_baddr*(md: ptr rte_mbuf): cstring {.inline, importc, header: "rte_mbuf.h".}
type
  rte_pktmbuf_pool_private* {.importc: "struct rte_pktmbuf_pool_private", header: "rte_mbuf.h".} = object
    mbuf_data_room_size*: uint16
    mbuf_priv_size*: uint16


proc rte_mbuf_refcnt_update*(m: ptr rte_mbuf; value: int16): uint16 {.inline, importc, header: "rte_mbuf.h".}
proc rte_mbuf_refcnt_read*(m: ptr rte_mbuf): uint16 {.inline, importc, header: "rte_mbuf.h".}
proc rte_mbuf_refcnt_set*(m: ptr rte_mbuf; new_value: uint16) {.inline, importc, header: "rte_mbuf.h".}
proc rte_mbuf_sanity_check*(m: ptr rte_mbuf; is_header: cint) {.importc, header: "rte_mbuf.h".}
proc rte_mbuf_raw_alloc*(mp: ptr rte_mempool): ptr rte_mbuf {.inline, importc, header: "rte_mbuf.h".}
proc rte_ctrlmbuf_init*(mp: ptr rte_mempool; opaque_arg: pointer; m: pointer; i: cuint) {.importc, header: "rte_mbuf.h".}
proc rte_is_ctrlmbuf*(m: ptr rte_mbuf): cint {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_init*(mp: ptr rte_mempool; opaque_arg: pointer; m: pointer; i: cuint) {.importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_pool_init*(mp: ptr rte_mempool; opaque_arg: pointer) {.importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_pool_create*(name: cstring; n: cuint; cache_size: cuint;
                             priv_size: uint16; data_room_size: uint16;
                             socket_id: cint): ptr rte_mempool {.importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_data_room_size*(mp: ptr rte_mempool): uint16 {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_reset*(m: ptr rte_mbuf) {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_alloc*(mp: ptr rte_mempool): ptr rte_mbuf {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_alloc_bulk*(pool: ptr rte_mempool; mbufs: ptr ptr rte_mbuf;
                            count: cuint): cint {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_attach*(mi: ptr rte_mbuf; m: ptr rte_mbuf) {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_detach*(m: ptr rte_mbuf) {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_free_seg*(m: ptr rte_mbuf) {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_free*(m: ptr rte_mbuf) {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_clone*(md: ptr rte_mbuf; mp: ptr rte_mempool): ptr rte_mbuf {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_refcnt_update*(m: ptr rte_mbuf; v: int16) {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_headroom*(m: ptr rte_mbuf): uint16 {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_tailroom*(m: ptr rte_mbuf): uint16 {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_lastseg*(m: ptr rte_mbuf): ptr rte_mbuf {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_prepend*(m: ptr rte_mbuf; len: uint16): cstring {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_append*(m: ptr rte_mbuf; len: uint16): cstring {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_adj*(m: ptr rte_mbuf; len: uint16): cstring {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_trim*(m: ptr rte_mbuf; len: uint16): cint {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_is_contiguous*(m: ptr rte_mbuf): cint {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_chain*(head: ptr rte_mbuf; tail: ptr rte_mbuf): cint {.inline, importc, header: "rte_mbuf.h".}
proc rte_pktmbuf_dump*(f: ptr FILE; m: ptr rte_mbuf; dump_len: cuint) {.importc, header: "rte_mbuf.h".}
