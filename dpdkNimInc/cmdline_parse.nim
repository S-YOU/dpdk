type
  cmdline_token_hdr* = object
    ops*: ptr cmdline_token_ops
    offset*: cuint

  cmdline_parse_token_hdr_t* = cmdline_token_hdr
  cmdline_token_ops* = object
    parse*: proc (a2: ptr cmdline_parse_token_hdr_t; a3: cstring; a4: pointer; a5: cuint): cint {.cdecl.}
    complete_get_nb*: proc (a2: ptr cmdline_parse_token_hdr_t): cint {.cdecl.}
    complete_get_elt*: proc (a2: ptr cmdline_parse_token_hdr_t; a3: cint; a4: cstring;
                           a5: cuint): cint {.cdecl.}
    get_help*: proc (a2: ptr cmdline_parse_token_hdr_t; a3: cstring; a4: cuint): cint {.cdecl.}

  cmdline* = object
  
  cmdline_inst* = object
    f*: proc (a2: pointer; a3: ptr cmdline; a4: pointer) {.cdecl.}
    data*: pointer
    help_str*: cstring
    tokens*: ptr ptr cmdline_parse_token_hdr_t

  cmdline_parse_inst_t* = cmdline_inst
  cmdline_parse_ctx_t* = ptr cmdline_parse_inst_t

proc cmdline_parse*(cl: ptr cmdline; buf: cstring): cint {.importc, header: "cmdline_parse.h".}
proc cmdline_complete*(cl: ptr cmdline; buf: cstring; state: ptr cint; dst: cstring;
                      size: cuint): cint {.importc, header: "cmdline_parse.h".}
proc cmdline_isendoftoken*(c: char): cint {.importc, header: "cmdline_parse.h".}
proc cmdline_isendofcommand*(c: char): cint {.importc, header: "cmdline_parse.h".}
