type
  cmdline_fixed_string_t* = array[128, char]
  cmdline_multi_string_t* = array[4096, char]
  cmdline_token_string_data* = object
    str*: cstring

  cmdline_token_string* = object
    hdr*: cmdline_token_hdr
    string_data*: cmdline_token_string_data

  cmdline_parse_token_string_t* = cmdline_token_string

proc cmdline_parse_string*(tk: ptr cmdline_parse_token_hdr_t; srcbuf: cstring;
                          res: pointer; ressize: cuint): cint {.importc, header: "cmdline_parse_string.h".}
proc cmdline_complete_get_nb_string*(tk: ptr cmdline_parse_token_hdr_t): cint {.importc, header: "cmdline_parse_string.h".}
proc cmdline_complete_get_elt_string*(tk: ptr cmdline_parse_token_hdr_t; idx: cint;
                                     dstbuf: cstring; size: cuint): cint {.importc, header: "cmdline_parse_string.h".}
proc cmdline_get_help_string*(tk: ptr cmdline_parse_token_hdr_t; dstbuf: cstring;
                             size: cuint): cint {.importc, header: "cmdline_parse_string.h".}
