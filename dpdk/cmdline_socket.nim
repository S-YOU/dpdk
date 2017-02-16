proc cmdline_file_new*(ctx: ptr cmdline_parse_ctx_t; prompt: cstring; path: cstring): ptr cmdline {.importc, header: "cmdline_socket.h".}
proc cmdline_stdin_new*(ctx: ptr cmdline_parse_ctx_t; prompt: cstring): ptr cmdline {.importc, header: "cmdline_socket.h".}
proc cmdline_stdin_exit*(cl: ptr cmdline) {.importc, header: "cmdline_socket.h".}
