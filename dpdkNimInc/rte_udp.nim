type
  udp_hdr* = object
    src_port*: uint16
    dst_port*: uint16
    dgram_len*: uint16
    dgram_cksum*: uint16

