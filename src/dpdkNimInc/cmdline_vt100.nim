const
  vt100_bell* = "\x07"
  vt100_bs* = "\x08"
  vt100_bs_clear* = "\x08 \x08"
  vt100_tab* = "\x09"
  vt100_crnl* = "\x0A\x0D"
  vt100_clear_right* = "\x1B[0K"
  vt100_clear_left* = "\x1B[1K"
  vt100_clear_down* = "\x1B[0J"
  vt100_clear_up* = "\x1B[1J"
  vt100_clear_line* = "\x1B[2K"
  vt100_clear_screen* = "\x1B[2J"
  vt100_up_arr* = "\x1B[A"
  vt100_down_arr* = "\x1B[B"
  vt100_right_arr* = "\x1B[C"
  vt100_left_arr* = "\x1B[D"
  vt100_multi_right* = "\x1B[%uC"
  vt100_multi_left* = "\x1B[%uD"
  vt100_suppr* = "\x1B[3~"
  vt100_home* = "\x1BM\x1BE"
  vt100_word_left* = "\x1Bb"
  vt100_word_right* = "\x1Bf"
  CMDLINE_KEY_UP_ARR* = 0
  CMDLINE_KEY_DOWN_ARR* = 1
  CMDLINE_KEY_RIGHT_ARR* = 2
  CMDLINE_KEY_LEFT_ARR* = 3
  CMDLINE_KEY_BKSPACE* = 4
  CMDLINE_KEY_RETURN* = 5
  CMDLINE_KEY_CTRL_A* = 6
  CMDLINE_KEY_CTRL_E* = 7
  CMDLINE_KEY_CTRL_K* = 8
  CMDLINE_KEY_CTRL_Y* = 9
  CMDLINE_KEY_CTRL_C* = 10
  CMDLINE_KEY_CTRL_F* = 11
  CMDLINE_KEY_CTRL_B* = 12
  CMDLINE_KEY_SUPPR* = 13
  CMDLINE_KEY_TAB* = 14
  CMDLINE_KEY_CTRL_D* = 15
  CMDLINE_KEY_CTRL_L* = 16
  CMDLINE_KEY_RETURN2* = 17
  CMDLINE_KEY_META_BKSPACE* = 18
  CMDLINE_KEY_WLEFT* = 19
  CMDLINE_KEY_WRIGHT* = 20
  CMDLINE_KEY_HELP* = 21
  CMDLINE_KEY_CTRL_W* = 22
  CMDLINE_KEY_CTRL_P* = 23
  CMDLINE_KEY_CTRL_N* = 24
  CMDLINE_KEY_META_D* = 25

type
  cmdline_vt100_parser_state* = enum
    CMDLINE_VT100_INIT, CMDLINE_VT100_ESCAPE, CMDLINE_VT100_ESCAPE_CSI


type
  cmdline_vt100* {.importc: "struct cmdline_vt100", header: "cmdline_vt100.h".} = object
    bufpos*: uint8
    buf*: array[8, char]
    state*: cmdline_vt100_parser_state


proc vt100_init*(vt: ptr cmdline_vt100) {.importc, header: "cmdline_vt100.h".}
proc vt100_parser*(vt: ptr cmdline_vt100; c: char): cint {.importc, header: "cmdline_vt100.h".}
