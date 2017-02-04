type
  udp_hdr* {.importc: "struct udp_hdr", header: "rte_udp.h".} = object
    src_port*: uint16
    dst_port*: uint16
    dgram_len*: uint16
    dgram_cksum*: uint16

