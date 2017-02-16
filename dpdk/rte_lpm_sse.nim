proc rte_lpm_lookupx4*(lpm: ptr rte_lpm; ip: xmm_t; hop: array[4, uint32];
                      defv: uint32) {.inline, importc, header: "rte_lpm_sse.h".}
