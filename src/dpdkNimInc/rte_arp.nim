const
  ARP_HRD_ETHER* = 1
  ARP_OP_REQUEST* = 1
  ARP_OP_REPLY* = 2
  ARP_OP_REVREQUEST* = 3
  ARP_OP_REVREPLY* = 4
  ARP_OP_INVREQUEST* = 8
  ARP_OP_INVREPLY* = 9

type
  arp_ipv4* {.importc: "struct arp_ipv4", header: "rte_arp.h".} = object
    arp_sha*: ether_addr
    arp_sip*: uint32
    arp_tha*: ether_addr
    arp_tip*: uint32

  arp_hdr* {.importc: "struct arp_hdr", header: "rte_arp.h".} = object
    arp_hrd*: uint16
    arp_pro*: uint16
    arp_hln*: uint8
    arp_pln*: uint8
    arp_op*: uint16
    arp_data*: arp_ipv4

