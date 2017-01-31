type
  # lib/librte_kni/rte_kni.c
  rte_kni* = object
    name*: array[RTE_KNI_NAMESIZE, char] ## *< KNI interface name
    group_id*: uint16        ## *< Group ID of KNI devices
    slot_id*: uint32         ## *< KNI pool slot ID
    pktmbuf_pool*: ptr rte_mempool ## *< pkt mbuf mempool
    mbuf_size*: cuint          ## *< mbuf size
    tx_q*: ptr rte_kni_fifo     ## *< TX queue
    rx_q*: ptr rte_kni_fifo     ## *< RX queue
    alloc_q*: ptr rte_kni_fifo  ## *< Allocated mbufs queue
    free_q*: ptr rte_kni_fifo   ## *< To be freed mbufs queue
                           ##  For request & response
    req_q*: ptr rte_kni_fifo    ## *< Request queue
    resp_q*: ptr rte_kni_fifo   ## *< Response queue
    sync_addr*: pointer        ## *< Req/Resp Mem address
    ops*: rte_kni_ops          ## *< operations for request
    in_use* {.bitsize: 1.}: uint8 ## *< kni in use
 
  rte_kni_ops* = object
    port_id*: uint8
    change_mtu*: proc (port_id: uint8; new_mtu: cuint): cint {.cdecl.}
    config_network_if*: proc (port_id: uint8; if_up: uint8): cint {.cdecl.}

  rte_kni_conf* = object
    name*: array[32, char]
    core_id*: uint32
    group_id*: uint16
    mbuf_size*: cuint
    `addr`*: rte_pci_addr
    id*: rte_pci_id
    force_bind* {.bitsize: 1.}: uint8


proc rte_kni_init*(max_kni_ifaces: cuint) {.importc, header: "rte_kni.h".}
proc rte_kni_alloc*(pktmbuf_pool: ptr rte_mempool; conf: ptr rte_kni_conf;
                   ops: ptr rte_kni_ops): ptr rte_kni {.importc, header: "rte_kni.h".}
proc rte_kni_release*(kni: ptr rte_kni): cint {.importc, header: "rte_kni.h".}
proc rte_kni_handle_request*(kni: ptr rte_kni): cint {.importc, header: "rte_kni.h".}
proc rte_kni_rx_burst*(kni: ptr rte_kni; mbufs: ptr ptr rte_mbuf; num: cuint): cuint {.importc, header: "rte_kni.h".}
proc rte_kni_tx_burst*(kni: ptr rte_kni; mbufs: ptr ptr rte_mbuf; num: cuint): cuint {.importc, header: "rte_kni.h".}
proc rte_kni_get*(name: cstring): ptr rte_kni {.importc, header: "rte_kni.h".}
proc rte_kni_get_name*(kni: ptr rte_kni): cstring {.importc, header: "rte_kni.h".}
proc rte_kni_register_handlers*(kni: ptr rte_kni; ops: ptr rte_kni_ops): cint {.importc, header: "rte_kni.h".}
proc rte_kni_unregister_handlers*(kni: ptr rte_kni): cint {.importc, header: "rte_kni.h".}
proc rte_kni_close*() {.importc, header: "rte_kni.h".}
