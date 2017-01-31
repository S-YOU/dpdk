const
  ETHER_ADDR_LEN* = 6
  ETHER_TYPE_LEN* = 2
  ETHER_CRC_LEN* = 4
  ETHER_HDR_LEN* = (ETHER_ADDR_LEN * 2 + ETHER_TYPE_LEN)
  ETHER_MIN_LEN* = 64
  ETHER_MAX_LEN* = 1518
  ETHER_MTU* = (ETHER_MAX_LEN - ETHER_HDR_LEN - ETHER_CRC_LEN)
  ETHER_MAX_VLAN_FRAME_LEN* = (ETHER_MAX_LEN + 4)
  ETHER_MAX_JUMBO_FRAME_LEN* = 0x00003F00
  ETHER_MAX_VLAN_ID* = 4095
  ETHER_MIN_MTU* = 68

type
  ether_addr* = object
    addr_bytes*: array[6, uint8]

const
  ETHER_LOCAL_ADMIN_ADDR* = 0x00000002
  ETHER_GROUP_ADDR* = 0x00000001
  ETHER_ADDR_FMT_SIZE* = 18

type
  ether_hdr* = object
    d_addr*: ether_addr
    s_addr*: ether_addr
    ether_type*: uint16

  vlan_hdr* = object
    vlan_tci*: uint16
    eth_proto*: uint16

  vxlan_hdr* = object
    vx_flags*: uint32
    vx_vni*: uint32

const
  ETHER_TYPE_IPv4* = 0x00000800
  ETHER_TYPE_IPv6* = 0x000086DD
  ETHER_TYPE_ARP* = 0x00000806
  ETHER_TYPE_RARP* = 0x00008035
  ETHER_TYPE_VLAN* = 0x00008100
  ETHER_TYPE_1588* = 0x000088F7
  ETHER_TYPE_SLOW* = 0x00008809
  ETHER_TYPE_TEB* = 0x00006558
  ETHER_VXLAN_HLEN* = 16


proc is_same_ether_addr*(ea1: ptr ether_addr; ea2: ptr ether_addr): cint {.inline, importc, header: "rte_ether.h".}
proc is_zero_ether_addr*(ea: ptr ether_addr): cint {.inline, importc, header: "rte_ether.h".}
proc is_unicast_ether_addr*(ea: ptr ether_addr): cint {.inline, importc, header: "rte_ether.h".}
proc is_multicast_ether_addr*(ea: ptr ether_addr): cint {.inline, importc, header: "rte_ether.h".}
proc is_broadcast_ether_addr*(ea: ptr ether_addr): cint {.inline, importc, header: "rte_ether.h".}
proc is_universal_ether_addr*(ea: ptr ether_addr): cint {.inline, importc, header: "rte_ether.h".}
proc is_local_admin_ether_addr*(ea: ptr ether_addr): cint {.inline, importc, header: "rte_ether.h".}
proc is_valid_assigned_ether_addr*(ea: ptr ether_addr): cint {.inline, importc, header: "rte_ether.h".}
proc eth_random_addr*(`addr`: ptr uint8) {.inline, importc, header: "rte_ether.h".}
proc ether_addr_copy*(ea_from: ptr ether_addr; ea_to: ptr ether_addr) {.inline, importc, header: "rte_ether.h".}
proc ether_format_addr*(buf: cstring; size: uint16; eth_addr: ptr ether_addr) {.inline, importc, header: "rte_ether.h".}



proc rte_vlan_strip*(m: ptr rte_mbuf): cint {.inline, importc, header: "rte_ether.h".}
proc rte_vlan_insert*(m: ptr ptr rte_mbuf): cint {.inline, importc, header: "rte_ether.h".}
