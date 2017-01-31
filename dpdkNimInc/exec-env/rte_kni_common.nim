const
  RTE_KNI_NAMESIZE* = 32

type
  rte_kni_req_id* = enum
    RTE_KNI_REQ_UNKNOWN = 0, RTE_KNI_REQ_CHANGE_MTU, RTE_KNI_REQ_CFG_NETWORK_IF,
    RTE_KNI_REQ_MAX


type
  INNER_C_UNION_2635871081* = object {.union.}
    new_mtu*: uint32
    if_up*: uint8

  rte_kni_request* = object
    req_id*: uint32
    ano_2483195275*: INNER_C_UNION_2635871081
    result*: int32

  rte_kni_fifo* = object
    write*: cuint
    read*: cuint
    len*: cuint
    elem_size*: cuint
    buffer*: array[0, pointer]

  rte_kni_mbuf* = object
    buf_addr*: pointer
    pad0*: array[10, char]
    data_off*: uint16
    pad1*: array[2, char]
    nb_segs*: uint8
    pad4*: array[1, char]
    ol_flags*: uint64
    pad2*: array[4, char]
    pkt_len*: uint32
    data_len*: uint16
    pad3*: array[8, char]
    pool*: pointer
    next*: pointer

  rte_kni_device_info* = object
    name*: array[32, char]
    tx_phys*: phys_addr_t
    rx_phys*: phys_addr_t
    alloc_phys*: phys_addr_t
    free_phys*: phys_addr_t
    req_phys*: phys_addr_t
    resp_phys*: phys_addr_t
    sync_phys*: phys_addr_t
    sync_va*: pointer
    mbuf_va*: pointer
    mbuf_phys*: phys_addr_t
    vendor_id*: uint16
    device_id*: uint16
    bus*: uint8
    devid*: uint8
    function*: uint8
    group_id*: uint16
    core_id*: uint32
    force_bind* {.bitsize: 1.}: uint8
    mbuf_size*: cuint

