type
  sctp_hdr* = object
    src_port*: uint16
    dst_port*: uint16
    tag*: uint32
    cksum*: uint32

