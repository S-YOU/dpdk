#proc rte_mov16*(dst: ptr uint8; src: ptr uint8) {.inline, importc, header: "rte_memcpy.h".}
#proc rte_mov32*(dst: ptr uint8; src: ptr uint8) {.inline, importc, header: "rte_memcpy.h".}
proc rte_mov48*(dst: ptr uint8; src: ptr uint8) {.inline, importc, header: "rte_memcpy.h".}
#proc rte_mov64*(dst: ptr uint8; src: ptr uint8) {.inline, importc, header: "rte_memcpy.h".}
#proc rte_mov128*(dst: ptr uint8; src: ptr uint8) {.inline, importc, header: "rte_memcpy.h".}
#proc rte_mov256*(dst: ptr uint8; src: ptr uint8) {.inline, importc, header: "rte_memcpy.h".}
