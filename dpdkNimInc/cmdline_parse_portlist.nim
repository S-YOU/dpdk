type
  cmdline_portlist_t* {.importc: "cmdline_portlist_t", header: "cmdline_parse_num.h".} = object
    map*: uint32

  cmdline_token_portlist* {.importc: "cmdline_portlist_t", header: "cmdline_parse_num.h".} = object
    hdr*: cmdline_token_hdr

  cmdline_parse_token_portlist_t* = cmdline_token_portlist

proc cmdline_parse_portlist*(tk: ptr cmdline_parse_token_hdr_t; srcbuf: cstring;
                            res: pointer; ressize: cuint): cint {.importc, header: "cmdline_parse_portlist.h".}
proc cmdline_get_help_portlist*(tk: ptr cmdline_parse_token_hdr_t; dstbuf: cstring;
                               size: cuint): cint {.importc, header: "cmdline_parse_portlist.h".}
