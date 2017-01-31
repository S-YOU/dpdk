type
  cirbuf* = object
    maxlen*: cuint
    start*: cuint
    `end`*: cuint
    len*: cuint
    buf*: cstring


proc cirbuf_init*(cbuf: ptr cirbuf; buf: cstring; start: cuint; maxlen: cuint): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_add_head_safe*(cbuf: ptr cirbuf; c: char): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_add_head*(cbuf: ptr cirbuf; c: char) {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_add_tail_safe*(cbuf: ptr cirbuf; c: char): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_add_tail*(cbuf: ptr cirbuf; c: char) {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_del_head_safe*(cbuf: ptr cirbuf): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_del_head*(cbuf: ptr cirbuf) {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_del_tail_safe*(cbuf: ptr cirbuf): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_del_tail*(cbuf: ptr cirbuf) {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_get_head*(cbuf: ptr cirbuf): char {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_get_tail*(cbuf: ptr cirbuf): char {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_add_buf_head*(cbuf: ptr cirbuf; c: cstring; n: cuint): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_add_buf_tail*(cbuf: ptr cirbuf; c: cstring; n: cuint): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_del_buf_head*(cbuf: ptr cirbuf; size: cuint): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_del_buf_tail*(cbuf: ptr cirbuf; size: cuint): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_get_buf_head*(cbuf: ptr cirbuf; c: cstring; size: cuint): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_get_buf_tail*(cbuf: ptr cirbuf; c: cstring; size: cuint): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_align_left*(cbuf: ptr cirbuf): cint {.importc, header: "cmdline_cirbuf.h".}
proc cirbuf_align_right*(cbuf: ptr cirbuf): cint {.importc, header: "cmdline_cirbuf.h".}
