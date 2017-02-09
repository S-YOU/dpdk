type
  cmdline_numtype* = enum
    UINT8 = 0, UINT16, UINT32, UINT64, INT8, INT16, INT32, INT64


type
  cmdline_token_num_data* {.importc: "struct cmdline_token_num_data", header: "cmdline_parse_num.h".} = object
    `type`*: cmdline_numtype

  cmdline_token_num* {.importc: "struct cmdline_token_num", header: "cmdline_parse_num.h".} = object
    hdr*: cmdline_token_hdr
    num_data*: cmdline_token_num_data

  cmdline_parse_token_num_t* = cmdline_token_num

proc cmdline_parse_num*(tk: ptr cmdline_parse_token_hdr_t; srcbuf: cstring;
                       res: pointer; ressize: cuint): cint {.importc, header: "cmdline_parse_num.h".}
proc cmdline_get_help_num*(tk: ptr cmdline_parse_token_hdr_t; dstbuf: cstring;
                          size: cuint): cint {.importc, header: "cmdline_parse_num.h".}
