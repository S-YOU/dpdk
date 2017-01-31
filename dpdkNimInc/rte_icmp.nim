const
  IP_ICMP_ECHO_REPLY* = 0
  IP_ICMP_ECHO_REQUEST* = 8

type
  icmp_hdr* = object
    icmp_type*: uint8
    icmp_code*: uint8
    icmp_cksum*: uint16
    icmp_ident*: uint16
    icmp_seq_nb*: uint16

