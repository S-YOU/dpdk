template IPv4*(a, b, c, d: untyped): untyped =
  ((((a) and 0x000000FF) shl 24) or
   (((b) and 0x000000FF) shl 16) or
   (((c) and 0x000000FF) shl 8) or 
   ((d) and 0x000000FF)).uint32

const
  IPV4_MAX_PKT_LEN* = 65535
  IPV4_HDR_IHL_MASK* = (0x0000000F)
  IPV4_IHL_MULTIPLIER* = (4)
  IPV4_HDR_DF_SHIFT* = 14
  IPV4_HDR_MF_SHIFT* = 13
  IPV4_HDR_FO_SHIFT* = 3
  IPV4_HDR_DF_FLAG* = (1 shl IPV4_HDR_DF_SHIFT)
  IPV4_HDR_MF_FLAG* = (1 shl IPV4_HDR_MF_SHIFT)
  IPV4_HDR_OFFSET_MASK* = ((1 shl IPV4_HDR_MF_SHIFT) - 1)
  IPV4_HDR_OFFSET_UNITS* = 8
  IPV4_ANY* = (0x00000000.uint32)
  IPV4_LOOPBACK* = (0x7F000001.uint32)
  IPV4_BROADCAST* = (0xE0000000.uint32)
  IPV4_ALLHOSTS_GROUP* = (0xE0000001.uint32)
  IPV4_ALLRTRS_GROUP* = (0xE0000002.uint32)
  IPV4_MAX_LOCAL_GROUP* = (0xE00000FF.uint32)
  IPV4_MIN_MCAST* = IPv4(224, 0, 0, 0)
  IPV4_MAX_MCAST* = IPv4(239, 255, 255, 255)

template IS_IPV4_MCAST*(x: untyped): untyped =
  ((x) >= IPV4_MIN_MCAST and (x) <= IPV4_MAX_MCAST)


type
  ipv4_hdr* {.importc: "struct ipv4_hdr", header: "rte_ip_frag.h".} = object
    version_ihl*: uint8
    type_of_service*: uint8
    total_length*: uint16
    packet_id*: uint16
    fragment_offset*: uint16
    time_to_live*: uint8
    next_proto_id*: uint8
    hdr_checksum*: uint16
    src_addr*: uint32
    dst_addr*: uint32


proc rte_raw_cksum*(buf: pointer; len: csize): uint16 {.inline, importc, header: "rte_ip.h".}
proc rte_ipv4_cksum*(ipv4_hdr: ptr ipv4_hdr): uint16 {.inline, importc, header: "rte_ip.h".}
proc rte_ipv4_phdr_cksum*(ipv4_hdr: ptr ipv4_hdr; ol_flags: uint64): uint16 {.inline, importc, header: "rte_ip.h".}

proc rte_ipv4_udptcp_cksum*(ipv4_hdr: ptr ipv4_hdr; l4_hdr: pointer): uint16 {.inline, importc, header: "rte_ip.h".}
type
  ipv6_hdr* = object
    vtc_flow*: uint32
    payload_len*: uint16
    proto*: uint8
    hop_limits*: uint8
    src_addr*: array[16, uint8]
    dst_addr*: array[16, uint8]


proc rte_ipv6_phdr_cksum*(ipv6_hdr: ptr ipv6_hdr; ol_flags: uint64): uint16 {.inline, importc, header: "rte_ip.h".}

proc rte_ipv6_udptcp_cksum*(ipv6_hdr: ptr ipv6_hdr; l4_hdr: pointer): uint16 {.inline, importc, header: "rte_ip.h".}
