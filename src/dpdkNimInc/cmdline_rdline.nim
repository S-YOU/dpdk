type
  rdline_status* = enum
    RDLINE_INIT, RDLINE_RUNNING, RDLINE_EXITED


type
  rdline_write_char_t* = proc (rdl: ptr rdline; a3: char): cint {.cdecl.}
  rdline_validate_t* = proc (rdl: ptr rdline; buf: cstring; size: cuint) {.cdecl.}
  rdline_complete_t* = proc (rdl: ptr rdline; buf: cstring; dstbuf: cstring;
                          dstsize: cuint; state: ptr cint): cint {.cdecl.}

  rdline* {.importc: "struct rdline", header: "cmdline_rdline.h".} = object
    status*: rdline_status
    left*: cirbuf
    right*: cirbuf
    left_buf*: array[512 + 2, char]
    right_buf*: array[512, char]
    prompt*: array[32, char]
    prompt_size*: cuint
    kill_buf*: array[512, char]
    kill_size*: cuint
    history*: cirbuf
    history_buf*: array[8192, char]
    history_cur_line*: cint
    write_char*: ptr rdline_write_char_t
    validate*: ptr rdline_validate_t
    complete*: ptr rdline_complete_t
    vt100*: cmdline_vt100
    opaque*: pointer


proc rdline_init*(rdl: ptr rdline; write_char: ptr rdline_write_char_t;
                 validate: ptr rdline_validate_t; complete: ptr rdline_complete_t): cint {.importc, header: "cmdline_rdline.h".}
proc rdline_newline*(rdl: ptr rdline; prompt: cstring) {.importc, header: "cmdline_rdline.h".}
proc rdline_stop*(rdl: ptr rdline) {.importc, header: "cmdline_rdline.h".}
proc rdline_quit*(rdl: ptr rdline) {.importc, header: "cmdline_rdline.h".}
proc rdline_restart*(rdl: ptr rdline) {.importc, header: "cmdline_rdline.h".}
proc rdline_redisplay*(rdl: ptr rdline) {.importc, header: "cmdline_rdline.h".}
proc rdline_reset*(rdl: ptr rdline) {.importc, header: "cmdline_rdline.h".}
proc rdline_char_in*(rdl: ptr rdline; c: char): cint {.importc, header: "cmdline_rdline.h".}
proc rdline_get_buffer*(rdl: ptr rdline): cstring {.importc, header: "cmdline_rdline.h".}
proc rdline_add_history*(rdl: ptr rdline; buf: cstring): cint {.importc, header: "cmdline_rdline.h".}
proc rdline_clear_history*(rdl: ptr rdline) {.importc, header: "cmdline_rdline.h".}
proc rdline_get_history_item*(rdl: ptr rdline; i: cuint): cstring {.importc, header: "cmdline_rdline.h".}
