type
  tcp_hdr* {.importc: "struct tcp_hdr", header: "rte_tcp.h".} = object
    src_port*: uint16
    dst_port*: uint16
    sent_seq*: uint32
    recv_ack*: uint32
    data_off*: uint8
    tcp_flags*: uint8
    rx_win*: uint16
    cksum*: uint16
    tcp_urp*: uint16

