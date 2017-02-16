type
  sctp_hdr* {.importc: "struct sctp_hdr", header: "rte_sctp.h".} = object
    src_port*: uint16
    dst_port*: uint16
    tag*: uint32
    cksum*: uint32

