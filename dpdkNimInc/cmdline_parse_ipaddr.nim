type
  INNER_C_UNION_3476110636* = object {.union.}
    ipv4*: in_addr
    ipv6*: in6_addr

  cmdline_ipaddr* = object
    family*: uint8
    `addr`*: INNER_C_UNION_3476110636
    prefixlen*: cuint

  cmdline_ipaddr_t* = cmdline_ipaddr
  cmdline_token_ipaddr_data* = object
    flags*: uint8

  cmdline_token_ipaddr* = object
    hdr*: cmdline_token_hdr
    ipaddr_data*: cmdline_token_ipaddr_data

  cmdline_parse_token_ipaddr_t* = cmdline_token_ipaddr

proc cmdline_parse_ipaddr*(tk: ptr cmdline_parse_token_hdr_t; srcbuf: cstring;
                          res: pointer; ressize: cuint): cint {.importc, header: "cmdline_parse_ipaddr.h".}
proc cmdline_get_help_ipaddr*(tk: ptr cmdline_parse_token_hdr_t; dstbuf: cstring;
                             size: cuint): cint {.importc, header: "cmdline_parse_ipaddr.h".}
