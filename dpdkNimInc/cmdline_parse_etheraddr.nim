type
  cmdline_token_etheraddr* = object
    hdr*: cmdline_token_hdr

  cmdline_parse_token_etheraddr_t* = cmdline_token_etheraddr

proc cmdline_parse_etheraddr*(tk: ptr cmdline_parse_token_hdr_t; srcbuf: cstring;
                             res: pointer; ressize: cuint): cint {.importc, header: "cmdline_parse_etheraddr.h".}
proc cmdline_get_help_etheraddr*(tk: ptr cmdline_parse_token_hdr_t; dstbuf: cstring;
                                size: cuint): cint {.importc, header: "cmdline_parse_etheraddr.h".}
