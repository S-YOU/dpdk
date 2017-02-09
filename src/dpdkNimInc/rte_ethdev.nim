const
  ETH_LINK_SPEED_AUTONEG* = (0 shl 0)
  ETH_LINK_SPEED_FIXED* = (1 shl 0)
  ETH_LINK_SPEED_10M_HD* = (1 shl 1)
  ETH_LINK_SPEED_10M* = (1 shl 2)
  ETH_LINK_SPEED_100M_HD* = (1 shl 3)
  ETH_LINK_SPEED_100M* = (1 shl 4)
  ETH_LINK_SPEED_1G* = (1 shl 5)
  ETH_LINK_SPEED_2u5G* = (1 shl 6)
  ETH_LINK_SPEED_5G* = (1 shl 7)
  ETH_LINK_SPEED_10G* = (1 shl 8)
  ETH_LINK_SPEED_20G* = (1 shl 9)
  ETH_LINK_SPEED_25G* = (1 shl 10)
  ETH_LINK_SPEED_40G* = (1 shl 11)
  ETH_LINK_SPEED_50G* = (1 shl 12)
  ETH_LINK_SPEED_56G* = (1 shl 13)
  ETH_LINK_SPEED_100G* = (1 shl 14)
  ETH_SPEED_NUM_NONE* = 0
  ETH_SPEED_NUM_10M* = 10
  ETH_SPEED_NUM_100M* = 100
  ETH_SPEED_NUM_1G* = 1000
  ETH_SPEED_NUM_2u5G* = 2500
  ETH_SPEED_NUM_5G* = 5000
  ETH_SPEED_NUM_10G* = 10000
  ETH_SPEED_NUM_20G* = 20000
  ETH_SPEED_NUM_25G* = 25000
  ETH_SPEED_NUM_40G* = 40000
  ETH_SPEED_NUM_50G* = 50000
  ETH_SPEED_NUM_56G* = 56000
  ETH_SPEED_NUM_100G* = 100000
  ETH_LINK_HALF_DUPLEX* = 0
  ETH_LINK_FULL_DUPLEX* = 1
  ETH_LINK_DOWN* = 0
  ETH_LINK_UP* = 1
  ETH_LINK_FIXED* = 0
  ETH_LINK_AUTONEG* = 1
  ETH_MQ_RX_RSS_FLAG* = 0x00000001
  ETH_MQ_RX_DCB_FLAG* = 0x00000002
  ETH_MQ_RX_VMDQ_FLAG* = 0x00000004

type
  rte_eth_rx_mq_mode* = enum
    ETH_MQ_RX_NONE = 0, ETH_MQ_RX_RSS = 0x00000001, ETH_MQ_RX_DCB = 0x00000002,
    ETH_MQ_RX_DCB_RSS = 0x00000001 or 0x00000002, ETH_MQ_RX_VMDQ_ONLY = 0x00000004,
    ETH_MQ_RX_VMDQ_RSS = 0x00000001 or 0x00000004,
    ETH_MQ_RX_VMDQ_DCB = 0x00000004 or 0x00000002,
    ETH_MQ_RX_VMDQ_DCB_RSS = 0x00000001 or 0x00000002 or 0x00000004

const
  ETH_RSS* = ETH_MQ_RX_RSS
  VMDQ_DCB* = ETH_MQ_RX_VMDQ_DCB
  ETH_DCB_RX* = ETH_MQ_RX_DCB

type
  rte_eth_tx_mq_mode* = enum
    ETH_MQ_TX_NONE = 0, ETH_MQ_TX_DCB, ETH_MQ_TX_VMDQ_DCB, ETH_MQ_TX_VMDQ_ONLY

const
  ETH_DCB_NONE* = ETH_MQ_TX_NONE
  ETH_VMDQ_DCB_TX* = ETH_MQ_TX_VMDQ_DCB
  ETH_DCB_TX* = ETH_MQ_TX_DCB
  ETH_RSS_IPV4* = (1 shl RTE_ETH_FLOW_IPV4)
  ETH_RSS_FRAG_IPV4* = (1 shl RTE_ETH_FLOW_FRAG_IPV4)
  ETH_RSS_NONFRAG_IPV4_TCP* = (1 shl RTE_ETH_FLOW_NONFRAG_IPV4_TCP)
  ETH_RSS_NONFRAG_IPV4_UDP* = (1 shl RTE_ETH_FLOW_NONFRAG_IPV4_UDP)
  ETH_RSS_NONFRAG_IPV4_SCTP* = (1 shl RTE_ETH_FLOW_NONFRAG_IPV4_SCTP)
  ETH_RSS_NONFRAG_IPV4_OTHER* = (1 shl RTE_ETH_FLOW_NONFRAG_IPV4_OTHER)
  ETH_RSS_IPV6* = (1 shl RTE_ETH_FLOW_IPV6)
  ETH_RSS_FRAG_IPV6* = (1 shl RTE_ETH_FLOW_FRAG_IPV6)
  ETH_RSS_NONFRAG_IPV6_TCP* = (1 shl RTE_ETH_FLOW_NONFRAG_IPV6_TCP)
  ETH_RSS_NONFRAG_IPV6_UDP* = (1 shl RTE_ETH_FLOW_NONFRAG_IPV6_UDP)
  ETH_RSS_NONFRAG_IPV6_SCTP* = (1 shl RTE_ETH_FLOW_NONFRAG_IPV6_SCTP)
  ETH_RSS_NONFRAG_IPV6_OTHER* = (1 shl RTE_ETH_FLOW_NONFRAG_IPV6_OTHER)
  ETH_RSS_L2_PAYLOAD* = (1 shl RTE_ETH_FLOW_L2_PAYLOAD)
  ETH_RSS_IPV6_EX* = (1 shl RTE_ETH_FLOW_IPV6_EX)
  ETH_RSS_IPV6_TCP_EX* = (1 shl RTE_ETH_FLOW_IPV6_TCP_EX)
  ETH_RSS_IPV6_UDP_EX* = (1 shl RTE_ETH_FLOW_IPV6_UDP_EX)
  ETH_RSS_PORT* = (1 shl RTE_ETH_FLOW_PORT)
  ETH_RSS_VXLAN* = (1 shl RTE_ETH_FLOW_VXLAN)
  ETH_RSS_GENEVE* = (1 shl RTE_ETH_FLOW_GENEVE)
  ETH_RSS_NVGRE* = (1 shl RTE_ETH_FLOW_NVGRE)
  ETH_RSS_IP* = (ETH_RSS_IPV4 or ETH_RSS_FRAG_IPV4 or ETH_RSS_NONFRAG_IPV4_OTHER or
      ETH_RSS_IPV6 or ETH_RSS_FRAG_IPV6 or ETH_RSS_NONFRAG_IPV6_OTHER or
      ETH_RSS_IPV6_EX)
  ETH_RSS_UDP* = (
    ETH_RSS_NONFRAG_IPV4_UDP or ETH_RSS_NONFRAG_IPV6_UDP or ETH_RSS_IPV6_UDP_EX)
  ETH_RSS_TCP* = (
    ETH_RSS_NONFRAG_IPV4_TCP or ETH_RSS_NONFRAG_IPV6_TCP or ETH_RSS_IPV6_TCP_EX)
  ETH_RSS_SCTP* = (ETH_RSS_NONFRAG_IPV4_SCTP or ETH_RSS_NONFRAG_IPV6_SCTP)
  ETH_RSS_TUNNEL* = (ETH_RSS_VXLAN or ETH_RSS_GENEVE or ETH_RSS_NVGRE)
  ETH_RSS_PROTO_MASK* = (ETH_RSS_IPV4 or ETH_RSS_FRAG_IPV4 or
      ETH_RSS_NONFRAG_IPV4_TCP or ETH_RSS_NONFRAG_IPV4_UDP or
      ETH_RSS_NONFRAG_IPV4_SCTP or ETH_RSS_NONFRAG_IPV4_OTHER or ETH_RSS_IPV6 or
      ETH_RSS_FRAG_IPV6 or ETH_RSS_NONFRAG_IPV6_TCP or ETH_RSS_NONFRAG_IPV6_UDP or
      ETH_RSS_NONFRAG_IPV6_SCTP or ETH_RSS_NONFRAG_IPV6_OTHER or
      ETH_RSS_L2_PAYLOAD or ETH_RSS_IPV6_EX or ETH_RSS_IPV6_TCP_EX or
      ETH_RSS_IPV6_UDP_EX or ETH_RSS_PORT or ETH_RSS_VXLAN or ETH_RSS_GENEVE or
      ETH_RSS_NVGRE)
  ETH_RSS_RETA_SIZE_64* = 64
  ETH_RSS_RETA_SIZE_128* = 128
  ETH_RSS_RETA_SIZE_256* = 256
  ETH_RSS_RETA_SIZE_512* = 512
  RTE_RETA_GROUP_SIZE* = 64
  ETH_VMDQ_MAX_VLAN_FILTERS* = 64
  ETH_DCB_NUM_USER_PRIORITIES* = 8
  ETH_VMDQ_DCB_NUM_QUEUES* = 128
  ETH_DCB_NUM_QUEUES* = 128
  ETH_DCB_PG_SUPPORT* = 0x00000001
  ETH_DCB_PFC_SUPPORT* = 0x00000002
  ETH_VLAN_STRIP_OFFLOAD* = 0x00000001
  ETH_VLAN_FILTER_OFFLOAD* = 0x00000002
  ETH_VLAN_EXTEND_OFFLOAD* = 0x00000004
  ETH_VLAN_STRIP_MASK* = 0x00000001
  ETH_VLAN_FILTER_MASK* = 0x00000002
  ETH_VLAN_EXTEND_MASK* = 0x00000004
  ETH_VLAN_ID_MAX* = 0x00000FFF
  ETH_NUM_RECEIVE_MAC_ADDR* = 128
  ETH_VMDQ_NUM_UC_HASH_ARRAY* = 128
  ETH_VMDQ_ACCEPT_UNTAG* = 0x00000001
  ETH_VMDQ_ACCEPT_HASH_MC* = 0x00000002
  ETH_VMDQ_ACCEPT_HASH_UC* = 0x00000004
  ETH_VMDQ_ACCEPT_BROADCAST* = 0x00000008
  ETH_VMDQ_ACCEPT_MULTICAST* = 0x00000010
  ETH_MIRROR_MAX_VLANS* = 64
  ETH_MIRROR_VIRTUAL_POOL_UP* = 0x00000001
  ETH_MIRROR_UPLINK_PORT* = 0x00000002
  ETH_MIRROR_DOWNLINK_PORT* = 0x00000004
  ETH_MIRROR_VLAN* = 0x00000008
  ETH_MIRROR_VIRTUAL_POOL_DOWN* = 0x00000010
  ETH_TXQ_FLAGS_NOMULTSEGS* = 0x00000001
  ETH_TXQ_FLAGS_NOREFCOUNT* = 0x00000002
  ETH_TXQ_FLAGS_NOMULTMEMP* = 0x00000004
  ETH_TXQ_FLAGS_NOVLANOFFL* = 0x00000100
  ETH_TXQ_FLAGS_NOXSUMSCTP* = 0x00000200
  ETH_TXQ_FLAGS_NOXSUMUDP* = 0x00000400
  ETH_TXQ_FLAGS_NOXSUMTCP* = 0x00000800
  ETH_TXQ_FLAGS_NOOFFLOADS* = (ETH_TXQ_FLAGS_NOVLANOFFL or
      ETH_TXQ_FLAGS_NOXSUMSCTP or ETH_TXQ_FLAGS_NOXSUMUDP or
      ETH_TXQ_FLAGS_NOXSUMTCP)
  ETH_TXQ_FLAGS_NOXSUMS* = (ETH_TXQ_FLAGS_NOXSUMSCTP or ETH_TXQ_FLAGS_NOXSUMUDP or
      ETH_TXQ_FLAGS_NOXSUMTCP)
  DEV_RX_OFFLOAD_VLAN_STRIP* = 0x00000001
  DEV_RX_OFFLOAD_IPV4_CKSUM* = 0x00000002
  DEV_RX_OFFLOAD_UDP_CKSUM* = 0x00000004
  DEV_RX_OFFLOAD_TCP_CKSUM* = 0x00000008
  DEV_RX_OFFLOAD_TCP_LRO* = 0x00000010
  DEV_RX_OFFLOAD_QINQ_STRIP* = 0x00000020
  DEV_RX_OFFLOAD_OUTER_IPV4_CKSUM* = 0x00000040
  DEV_TX_OFFLOAD_VLAN_INSERT* = 0x00000001
  DEV_TX_OFFLOAD_IPV4_CKSUM* = 0x00000002
  DEV_TX_OFFLOAD_UDP_CKSUM* = 0x00000004
  DEV_TX_OFFLOAD_TCP_CKSUM* = 0x00000008
  DEV_TX_OFFLOAD_SCTP_CKSUM* = 0x00000010
  DEV_TX_OFFLOAD_TCP_TSO* = 0x00000020
  DEV_TX_OFFLOAD_UDP_TSO* = 0x00000040
  DEV_TX_OFFLOAD_OUTER_IPV4_CKSUM* = 0x00000080
  DEV_TX_OFFLOAD_QINQ_INSERT* = 0x00000100
  RTE_ETH_XSTATS_NAME_SIZE* = 64
  ETH_DCB_NUM_TCS* = 8
  ETH_MAX_VMDQ_POOL* = 64
  RTE_ETH_QUEUE_STATE_STOPPED* = 0
  RTE_ETH_QUEUE_STATE_STARTED* = 1
  ETH_L2_TUNNEL_ENABLE_MASK* = 0x00000001
  ETH_L2_TUNNEL_INSERTION_MASK* = 0x00000002
  ETH_L2_TUNNEL_STRIPPING_MASK* = 0x00000004
  ETH_L2_TUNNEL_FORWARDING_MASK* = 0x00000008
  RTE_ETH_NAME_MAX_LEN* = (32)
  RTE_ETH_DEV_DETACHABLE* = 0x00000001
  RTE_ETH_DEV_INTR_LSC* = 0x00000002
  RTE_ETH_DEV_BONDED_SLAVE* = 0x00000004

type
  rte_eth_stats* {.importc: "struct rte_eth_stats", header: "rte_ethdev.h".} = object
    ipackets*: uint64
    opackets*: uint64
    ibytes*: uint64
    obytes*: uint64
    imissed*: uint64
    ierrors*: uint64
    oerrors*: uint64
    rx_nombuf*: uint64
    q_ipackets*: array[RTE_ETHDEV_QUEUE_STAT_CNTRS, uint64]
    q_opackets*: array[RTE_ETHDEV_QUEUE_STAT_CNTRS, uint64]
    q_ibytes*: array[RTE_ETHDEV_QUEUE_STAT_CNTRS, uint64]
    q_obytes*: array[RTE_ETHDEV_QUEUE_STAT_CNTRS, uint64]
    q_errors*: array[RTE_ETHDEV_QUEUE_STAT_CNTRS, uint64]

  rte_eth_link* {.importc: "struct rte_eth_link", header: "rte_ethdev.h".} = object
    link_speed*: uint32
    link_duplex* {.bitsize: 1.}: uint16
    link_autoneg* {.bitsize: 1.}: uint16
    link_status* {.bitsize: 1.}: uint16

  rte_eth_thresh* {.importc: "struct rte_eth_thresh", header: "rte_ethdev.h".} = object
    pthresh*: uint8
    hthresh*: uint8
    wthresh*: uint8



type
  rte_eth_rxmode* {.importc: "struct rte_eth_rxmode", header: "rte_ethdev.h".} = object
    mq_mode*: rte_eth_rx_mq_mode
    max_rx_pkt_len*: uint32
    split_hdr_size*: uint16
    header_split* {.bitsize: 1.}: uint16
    hw_ip_checksum* {.bitsize: 1.}: uint16
    hw_vlan_filter* {.bitsize: 1.}: uint16
    hw_vlan_strip* {.bitsize: 1.}: uint16
    hw_vlan_extend* {.bitsize: 1.}: uint16
    jumbo_frame* {.bitsize: 1.}: uint16
    hw_strip_crc* {.bitsize: 1.}: uint16
    enable_scatter* {.bitsize: 1.}: uint16
    enable_lro* {.bitsize: 1.}: uint16

  rte_vlan_type* = enum
    ETH_VLAN_TYPE_UNKNOWN = 0, ETH_VLAN_TYPE_INNER, ETH_VLAN_TYPE_OUTER,
    ETH_VLAN_TYPE_MAX


type
  rte_eth_rss_conf* {.importc: "struct rte_eth_rss_conf", header: "rte_ethdev.h".} = object
    rss_key*: ptr uint8
    rss_key_len*: uint8
    rss_hf*: uint64

  rte_eth_vlan_mirror* {.importc: "struct rte_eth_vlan_mirror", header: "rte_ethdev.h".} = object
    vlan_mask*: uint64
    vlan_id*: array[64, uint16]

  rte_eth_mirror_conf* {.importc: "struct rte_eth_mirror_conf", header: "rte_ethdev.h".} = object
    rule_type*: uint8
    dst_pool*: uint8
    pool_mask*: uint64
    vlan*: rte_eth_vlan_mirror

  rte_eth_rss_reta_entry64* {.importc: "struct rte_eth_rss_reta_entry64", header: "rte_ethdev.h".} = object
    mask*: uint64
    reta*: array[64, uint16]

  rte_eth_nb_tcs* = enum
    ETH_4_TCS = 4, ETH_8_TCS = 8


type
  rte_eth_nb_pools* = enum
    ETH_8_POOLS = 8, ETH_16_POOLS = 16, ETH_32_POOLS = 32, ETH_64_POOLS = 64


type
  rte_eth_dcb_rx_conf* {.importc: "struct rte_eth_dcb_rx_conf", header: "rte_ethdev.h".} = object
    nb_tcs*: rte_eth_nb_tcs
    dcb_tc*: array[8, uint8]

  rte_eth_vmdq_dcb_tx_conf* {.importc: "struct rte_eth_vmdq_dcb_tx_conf", header: "rte_ethdev.h".} = object
    nb_queue_pools*: rte_eth_nb_pools
    dcb_tc*: array[8, uint8]

  rte_eth_dcb_tx_conf* {.importc: "struct rte_eth_dcb_tx_conf", header: "rte_ethdev.h".} = object
    nb_tcs*: rte_eth_nb_tcs
    dcb_tc*: array[8, uint8]

  rte_eth_vmdq_tx_conf* {.importc: "struct rte_eth_vmdq_tx_conf", header: "rte_ethdev.h".} = object
    nb_queue_pools*: rte_eth_nb_pools

  INNER_C_STRUCT_3549726535* = object
    vlan_id*: uint16
    pools*: uint64

  rte_eth_vmdq_dcb_conf* {.importc: "struct rte_eth_vmdq_dcb_conf", header: "rte_ethdev.h".} = object
    nb_queue_pools*: rte_eth_nb_pools
    enable_default_pool*: uint8
    default_pool*: uint8
    nb_pool_maps*: uint8
    pool_map*: array[64, INNER_C_STRUCT_3549726535]
    dcb_tc*: array[8, uint8]

  INNER_C_STRUCT_2736085125* = object
    vlan_id*: uint16
    pools*: uint64

  rte_eth_vmdq_rx_conf* {.importc: "struct rte_eth_vmdq_rx_conf", header: "rte_ethdev.h".} = object
    nb_queue_pools*: rte_eth_nb_pools
    enable_default_pool*: uint8
    default_pool*: uint8
    enable_loop_back*: uint8
    nb_pool_maps*: uint8
    rx_mode*: uint32
    pool_map*: array[64, INNER_C_STRUCT_2736085125]

  rte_eth_txmode* {.importc: "struct rte_eth_txmode", header: "rte_ethdev.h".} = object
    mq_mode*: rte_eth_tx_mq_mode
    pvid*: uint16
    hw_vlan_reject_tagged* {.bitsize: 1.}: uint8
    hw_vlan_reject_untagged* {.bitsize: 1.}: uint8
    hw_vlan_insert_pvid* {.bitsize: 1.}: uint8

  rte_eth_rxconf* {.importc: "struct rte_eth_rxconf", header: "rte_ethdev.h".} = object
    rx_thresh*: rte_eth_thresh
    rx_free_thresh*: uint16
    rx_drop_en*: uint8
    rx_deferred_start*: uint8

  rte_eth_txconf* {.importc: "struct rte_eth_txconf", header: "rte_ethdev.h".} = object
    tx_thresh*: rte_eth_thresh
    tx_rs_thresh*: uint16
    tx_free_thresh*: uint16
    txq_flags*: uint32
    tx_deferred_start*: uint8

  rte_eth_desc_lim* {.importc: "struct rte_eth_desc_lim", header: "rte_ethdev.h".} = object
    nb_max*: uint16
    nb_min*: uint16
    nb_align*: uint16

  rte_eth_fc_mode* = enum
    RTE_FC_NONE = 0, RTE_FC_RX_PAUSE, RTE_FC_TX_PAUSE, RTE_FC_FULL


type
  rte_eth_fc_conf* {.importc: "struct rte_eth_fc_conf", header: "rte_ethdev.h".} = object
    high_water*: uint32
    low_water*: uint32
    pause_time*: uint16
    send_xon*: uint16
    mode*: rte_eth_fc_mode
    mac_ctrl_frame_fwd*: uint8
    autoneg*: uint8

  rte_eth_pfc_conf* {.importc: "struct rte_eth_pfc_conf", header: "rte_ethdev.h".} = object
    fc*: rte_eth_fc_conf
    priority*: uint8

  rte_fdir_pballoc_type* = enum
    RTE_FDIR_PBALLOC_64K = 0, RTE_FDIR_PBALLOC_128K, RTE_FDIR_PBALLOC_256K


type
  rte_fdir_status_mode* = enum
    RTE_FDIR_NO_REPORT_STATUS = 0, RTE_FDIR_REPORT_STATUS,
    RTE_FDIR_REPORT_STATUS_ALWAYS


type
  rte_fdir_conf* {.importc: "struct rte_fdir_conf", header: "rte_ethdev.h".} = object
    mode*: rte_fdir_mode
    pballoc*: rte_fdir_pballoc_type
    status*: rte_fdir_status_mode
    drop_queue*: uint8
    mask*: rte_eth_fdir_masks
    flex_conf*: rte_eth_fdir_flex_conf

  rte_eth_udp_tunnel* {.importc: "struct rte_eth_udp_tunnel", header: "rte_ethdev.h".} = object
    udp_port*: uint16
    prot_type*: uint8

  rte_intr_conf* {.importc: "struct rte_intr_conf", header: "rte_ethdev.h".} = object
    lsc*: uint16
    rxq*: uint16

  INNER_C_STRUCT_3217358837* = object
    rss_conf*: rte_eth_rss_conf
    vmdq_dcb_conf*: rte_eth_vmdq_dcb_conf
    dcb_rx_conf*: rte_eth_dcb_rx_conf
    vmdq_rx_conf*: rte_eth_vmdq_rx_conf

  INNER_C_UNION_3964900016* = object {.union.}
    vmdq_dcb_tx_conf*: rte_eth_vmdq_dcb_tx_conf
    dcb_tx_conf*: rte_eth_dcb_tx_conf
    vmdq_tx_conf*: rte_eth_vmdq_tx_conf

  rte_eth_conf* {.importc: "struct rte_eth_conf", header: "rte_ethdev.h".} = object
    link_speeds*: uint32
    rxmode*: rte_eth_rxmode
    txmode*: rte_eth_txmode
    lpbk_mode*: uint32
    rx_adv_conf*: INNER_C_STRUCT_3217358837
    tx_adv_conf*: INNER_C_UNION_3964900016
    dcb_capability_en*: uint32
    fdir_conf*: rte_fdir_conf
    intr_conf*: rte_intr_conf

  rte_eth_dev_info* {.importc: "struct rte_eth_dev_info", header: "rte_ethdev.h".} = object
    pci_dev*: ptr rte_pci_device
    driver_name*: cstring
    if_index*: cuint
    min_rx_bufsize*: uint32
    max_rx_pktlen*: uint32
    max_rx_queues*: uint16
    max_tx_queues*: uint16
    max_mac_addrs*: uint32
    max_hash_mac_addrs*: uint32
    max_vfs*: uint16
    max_vmdq_pools*: uint16
    rx_offload_capa*: uint32
    tx_offload_capa*: uint32
    reta_size*: uint16
    hash_key_size*: uint8
    flow_type_rss_offloads*: uint64
    default_rxconf*: rte_eth_rxconf
    default_txconf*: rte_eth_txconf
    vmdq_queue_base*: uint16
    vmdq_queue_num*: uint16
    vmdq_pool_base*: uint16
    rx_desc_lim*: rte_eth_desc_lim
    tx_desc_lim*: rte_eth_desc_lim
    speed_capa*: uint32
    nb_rx_queues*: uint16
    nb_tx_queues*: uint16

  rte_eth_rxq_info* {.importc: "struct rte_eth_rxq_info", header: "rte_ethdev.h".} = object
    mp*: ptr rte_mempool
    conf*: rte_eth_rxconf
    scattered_rx*: uint8
    nb_desc*: uint16

  rte_eth_txq_info* {.importc: "struct rte_eth_txq_info", header: "rte_ethdev.h".} = object
    conf*: rte_eth_txconf
    nb_desc*: uint16

  rte_eth_xstat* {.importc: "struct rte_eth_xstat", header: "rte_ethdev.h".} = object
    id*: uint64
    value*: uint64

  rte_eth_xstat_name* {.importc: "struct rte_eth_xstat_name", header: "rte_ethdev.h".} = object
    name*: array[64, char]

  INNER_C_STRUCT_3614176241* = object
    base*: uint8
    nb_queue*: uint8

  INNER_C_STRUCT_50227114* = object
    base*: uint8
    nb_queue*: uint8

  rte_eth_dcb_tc_queue_mapping* {.importc: "struct rte_eth_dcb_tc_queue_mapping", header: "rte_ethdev.h".} = object
    tc_rxq*: array[64, array[8, INNER_C_STRUCT_3614176241]]
    tc_txq*: array[64, array[8, INNER_C_STRUCT_50227114]]

  rte_eth_dcb_info* {.importc: "struct rte_eth_dcb_info", header: "rte_ethdev.h".} = object
    nb_tcs*: uint8
    prio_tc*: array[8, uint8]
    tc_bws*: array[8, uint8]
    tc_queue*: rte_eth_dcb_tc_queue_mapping

  rte_eth_event_type* = enum
    RTE_ETH_EVENT_UNKNOWN, RTE_ETH_EVENT_INTR_LSC, RTE_ETH_EVENT_QUEUE_STATE,
    RTE_ETH_EVENT_INTR_RESET, RTE_ETH_EVENT_MAX
  rte_eth_dev_cb_fn* = proc (port_id: uint8; event: rte_eth_event_type;
                          cb_arg: pointer) {.cdecl.}

  # start lib/librte_ether/rte_ethdev.c
  INNER_C_STRUCT_133981217* = object
    tqe_next*: ptr rte_eth_dev_callback
    tqe_prev*: ptr ptr rte_eth_dev_callback

  rte_eth_dev_callback* {.importc: "struct rte_eth_dev_callback", header: "cDecStructs.h".} = object
    next*: INNER_C_STRUCT_133981217 ## *< Callbacks list
    cb_fn*: rte_eth_dev_cb_fn  ## *< Callback address
    cb_arg*: pointer           ## *< Parameter for callback
    event*: rte_eth_event_type ## *< Interrupt event type
    active*: uint32          ## *< Callback is executing
  # end lib/librte_ether/rte_ethdev.c
  
  rte_eth_dev_cb_list* = object
    tqh_first*: ptr rte_eth_dev_callback
    tqh_last*: ptr ptr rte_eth_dev_callback

  eth_dev_configure_t* = proc (dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_dev_start_t* = proc (dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_dev_stop_t* = proc (dev: ptr rte_eth_dev) {.cdecl.}
  eth_dev_set_link_up_t* = proc (dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_dev_set_link_down_t* = proc (dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_dev_close_t* = proc (dev: ptr rte_eth_dev) {.cdecl.}
  eth_promiscuous_enable_t* = proc (dev: ptr rte_eth_dev) {.cdecl.}
  eth_promiscuous_disable_t* = proc (dev: ptr rte_eth_dev) {.cdecl.}
  eth_allmulticast_enable_t* = proc (dev: ptr rte_eth_dev) {.cdecl.}
  eth_allmulticast_disable_t* = proc (dev: ptr rte_eth_dev) {.cdecl.}
  eth_link_update_t* = proc (dev: ptr rte_eth_dev; wait_to_complete: cint): cint {.cdecl.}
  eth_stats_get_t* = proc (dev: ptr rte_eth_dev; igb_stats: ptr rte_eth_stats) {.cdecl.}
  eth_stats_reset_t* = proc (dev: ptr rte_eth_dev) {.cdecl.}
  eth_xstats_get_t* = proc (dev: ptr rte_eth_dev; stats: ptr rte_eth_xstat; n: cuint): cint {.cdecl.}
  eth_xstats_reset_t* = proc (dev: ptr rte_eth_dev) {.cdecl.}
  eth_xstats_get_names_t* = proc (dev: ptr rte_eth_dev;
                               xstats_names: ptr rte_eth_xstat_name; size: cuint): cint {.cdecl.}
  eth_queue_stats_mapping_set_t* = proc (dev: ptr rte_eth_dev; queue_id: uint16;
                                      stat_idx: uint8; is_rx: uint8): cint {.cdecl.}
  eth_dev_infos_get_t* = proc (dev: ptr rte_eth_dev; dev_info: ptr rte_eth_dev_info) {.cdecl.}
  eth_dev_supported_ptypes_get_t* = proc (dev: ptr rte_eth_dev): ptr uint32 {.cdecl.}
  eth_queue_start_t* = proc (dev: ptr rte_eth_dev; queue_id: uint16): cint {.cdecl.}
  eth_queue_stop_t* = proc (dev: ptr rte_eth_dev; queue_id: uint16): cint {.cdecl.}
  eth_rx_queue_setup_t* = proc (dev: ptr rte_eth_dev; rx_queue_id: uint16;
                             nb_rx_desc: uint16; socket_id: cuint;
                             rx_conf: ptr rte_eth_rxconf; mb_pool: ptr rte_mempool): cint {.cdecl.}
  eth_tx_queue_setup_t* = proc (dev: ptr rte_eth_dev; tx_queue_id: uint16;
                             nb_tx_desc: uint16; socket_id: cuint;
                             tx_conf: ptr rte_eth_txconf): cint {.cdecl.}
  eth_rx_enable_intr_t* = proc (dev: ptr rte_eth_dev; rx_queue_id: uint16): cint {.cdecl.}
  eth_rx_disable_intr_t* = proc (dev: ptr rte_eth_dev; rx_queue_id: uint16): cint {.cdecl.}
  eth_queue_release_t* = proc (queue: pointer) {.cdecl.}
  eth_rx_queue_count_t* = proc (dev: ptr rte_eth_dev; rx_queue_id: uint16): uint32 {.cdecl.}
  eth_rx_descriptor_done_t* = proc (rxq: pointer; offset: uint16): cint {.cdecl.}
  eth_rxq_info_get_t* = proc (dev: ptr rte_eth_dev; rx_queue_id: uint16;
                           qinfo: ptr rte_eth_rxq_info) {.cdecl.}
  eth_txq_info_get_t* = proc (dev: ptr rte_eth_dev; tx_queue_id: uint16;
                           qinfo: ptr rte_eth_txq_info) {.cdecl.}
  mtu_set_t* = proc (dev: ptr rte_eth_dev; mtu: uint16): cint {.cdecl.}
  vlan_filter_set_t* = proc (dev: ptr rte_eth_dev; vlan_id: uint16; on: cint): cint {.cdecl.}
  vlan_tpid_set_t* = proc (dev: ptr rte_eth_dev; `type`: rte_vlan_type; tpid: uint16): cint {.cdecl.}
  vlan_offload_set_t* = proc (dev: ptr rte_eth_dev; mask: cint) {.cdecl.}
  vlan_pvid_set_t* = proc (dev: ptr rte_eth_dev; vlan_id: uint16; on: cint): cint {.cdecl.}
  vlan_strip_queue_set_t* = proc (dev: ptr rte_eth_dev; rx_queue_id: uint16; on: cint) {.cdecl.}
  eth_rx_burst_t* = proc (rxq: pointer; rx_pkts: ptr ptr rte_mbuf; nb_pkts: uint16): uint16 {.cdecl.}
  eth_tx_burst_t* = proc (txq: pointer; tx_pkts: ptr ptr rte_mbuf; nb_pkts: uint16): uint16 {.cdecl.}
  flow_ctrl_get_t* = proc (dev: ptr rte_eth_dev; fc_conf: ptr rte_eth_fc_conf): cint {.cdecl.}
  flow_ctrl_set_t* = proc (dev: ptr rte_eth_dev; fc_conf: ptr rte_eth_fc_conf): cint {.cdecl.}
  priority_flow_ctrl_set_t* = proc (dev: ptr rte_eth_dev;
                                 pfc_conf: ptr rte_eth_pfc_conf): cint {.cdecl.}
  reta_update_t* = proc (dev: ptr rte_eth_dev;
                      reta_conf: ptr rte_eth_rss_reta_entry64; reta_size: uint16): cint {.cdecl.}
  reta_query_t* = proc (dev: ptr rte_eth_dev; reta_conf: ptr rte_eth_rss_reta_entry64;
                     reta_size: uint16): cint {.cdecl.}
  rss_hash_update_t* = proc (dev: ptr rte_eth_dev; rss_conf: ptr rte_eth_rss_conf): cint {.cdecl.}
  rss_hash_conf_get_t* = proc (dev: ptr rte_eth_dev; rss_conf: ptr rte_eth_rss_conf): cint {.cdecl.}
  eth_dev_led_on_t* = proc (dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_dev_led_off_t* = proc (dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_mac_addr_remove_t* = proc (dev: ptr rte_eth_dev; index: uint32) {.cdecl.}
  eth_mac_addr_add_t* = proc (dev: ptr rte_eth_dev; mac_addr: ptr ether_addr;
                           index: uint32; vmdq: uint32) {.cdecl.}
  eth_mac_addr_set_t* = proc (dev: ptr rte_eth_dev; mac_addr: ptr ether_addr) {.cdecl.}
  eth_uc_hash_table_set_t* = proc (dev: ptr rte_eth_dev; mac_addr: ptr ether_addr;
                                on: uint8): cint {.cdecl.}
  eth_uc_all_hash_table_set_t* = proc (dev: ptr rte_eth_dev; on: uint8): cint {.cdecl.}
  eth_set_vf_rx_mode_t* = proc (dev: ptr rte_eth_dev; vf: uint16; rx_mode: uint16;
                             on: uint8): cint {.cdecl.}
  eth_set_vf_rx_t* = proc (dev: ptr rte_eth_dev; vf: uint16; on: uint8): cint {.cdecl.}
  eth_set_vf_tx_t* = proc (dev: ptr rte_eth_dev; vf: uint16; on: uint8): cint {.cdecl.}
  eth_set_vf_vlan_filter_t* = proc (dev: ptr rte_eth_dev; vlan: uint16;
                                 vf_mask: uint64; vlan_on: uint8): cint {.cdecl.}
  eth_set_queue_rate_limit_t* = proc (dev: ptr rte_eth_dev; queue_idx: uint16;
                                   tx_rate: uint16): cint {.cdecl.}
  eth_set_vf_rate_limit_t* = proc (dev: ptr rte_eth_dev; vf: uint16;
                                tx_rate: uint16; q_msk: uint64): cint {.cdecl.}
  eth_mirror_rule_set_t* = proc (dev: ptr rte_eth_dev;
                              mirror_conf: ptr rte_eth_mirror_conf;
                              rule_id: uint8; on: uint8): cint {.cdecl.}
  eth_mirror_rule_reset_t* = proc (dev: ptr rte_eth_dev; rule_id: uint8): cint {.cdecl.}
  eth_udp_tunnel_port_add_t* = proc (dev: ptr rte_eth_dev;
                                  tunnel_udp: ptr rte_eth_udp_tunnel): cint {.cdecl.}
  eth_udp_tunnel_port_del_t* = proc (dev: ptr rte_eth_dev;
                                  tunnel_udp: ptr rte_eth_udp_tunnel): cint {.cdecl.}
  eth_set_mc_addr_list_t* = proc (dev: ptr rte_eth_dev; mc_addr_set: ptr ether_addr;
                               nb_mc_addr: uint32): cint {.cdecl.}
  eth_timesync_enable_t* = proc (dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_timesync_disable_t* = proc (dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_timesync_read_rx_timestamp_t* = proc (dev: ptr rte_eth_dev;
      timestamp: ptr timespec; flags: uint32): cint {.cdecl.}
  eth_timesync_read_tx_timestamp_t* = proc (dev: ptr rte_eth_dev;
      timestamp: ptr timespec): cint {.cdecl.}
  eth_timesync_adjust_time* = proc (dev: ptr rte_eth_dev; a3: int64): cint {.cdecl.}
  eth_timesync_read_time* = proc (dev: ptr rte_eth_dev; timestamp: ptr timespec): cint {.cdecl.}
  eth_timesync_write_time* = proc (dev: ptr rte_eth_dev; timestamp: ptr timespec): cint {.cdecl.}
  eth_get_reg_t* = proc (dev: ptr rte_eth_dev; info: ptr rte_dev_reg_info): cint {.cdecl.}
  eth_get_eeprom_length_t* = proc (dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_get_eeprom_t* = proc (dev: ptr rte_eth_dev; info: ptr rte_dev_eeprom_info): cint {.cdecl.}
  eth_set_eeprom_t* = proc (dev: ptr rte_eth_dev; info: ptr rte_dev_eeprom_info): cint {.cdecl.}
  eth_l2_tunnel_eth_type_conf_t* = proc (dev: ptr rte_eth_dev;
                                      l2_tunnel: ptr rte_eth_l2_tunnel_conf): cint {.cdecl.}
  eth_l2_tunnel_offload_set_t* = proc (dev: ptr rte_eth_dev;
                                    l2_tunnel: ptr rte_eth_l2_tunnel_conf;
                                    mask: uint32; en: uint8): cint {.cdecl.}
  eth_filter_ctrl_t* = proc (dev: ptr rte_eth_dev; filter_type: rte_filter_type;
                          filter_op: rte_filter_op; arg: pointer): cint {.cdecl.}
  eth_get_dcb_info* = proc (dev: ptr rte_eth_dev; dcb_info: ptr rte_eth_dcb_info): cint {.cdecl.}
  eth_dev_ops* {.importc: "struct eth_dev_ops", header: "rte_ethdev.h".} = object
    dev_configure*: eth_dev_configure_t
    dev_start*: eth_dev_start_t
    dev_stop*: eth_dev_stop_t
    dev_set_link_up*: eth_dev_set_link_up_t
    dev_set_link_down*: eth_dev_set_link_down_t
    dev_close*: eth_dev_close_t
    promiscuous_enable*: eth_promiscuous_enable_t
    promiscuous_disable*: eth_promiscuous_disable_t
    allmulticast_enable*: eth_allmulticast_enable_t
    allmulticast_disable*: eth_allmulticast_disable_t
    link_update*: eth_link_update_t
    stats_get*: eth_stats_get_t
    stats_reset*: eth_stats_reset_t
    xstats_get*: eth_xstats_get_t
    xstats_reset*: eth_xstats_reset_t
    xstats_get_names*: eth_xstats_get_names_t
    queue_stats_mapping_set*: eth_queue_stats_mapping_set_t
    dev_infos_get*: eth_dev_infos_get_t
    dev_supported_ptypes_get*: eth_dev_supported_ptypes_get_t
    mtu_set*: mtu_set_t
    vlan_filter_set*: vlan_filter_set_t
    vlan_tpid_set*: vlan_tpid_set_t
    vlan_strip_queue_set*: vlan_strip_queue_set_t
    vlan_offload_set*: vlan_offload_set_t
    vlan_pvid_set*: vlan_pvid_set_t
    rx_queue_start*: eth_queue_start_t
    rx_queue_stop*: eth_queue_stop_t
    tx_queue_start*: eth_queue_start_t
    tx_queue_stop*: eth_queue_stop_t
    rx_queue_setup*: eth_rx_queue_setup_t
    rx_queue_release*: eth_queue_release_t
    rx_queue_count*: eth_rx_queue_count_t
    rx_descriptor_done*: eth_rx_descriptor_done_t
    rx_queue_intr_enable*: eth_rx_enable_intr_t
    rx_queue_intr_disable*: eth_rx_disable_intr_t
    tx_queue_setup*: eth_tx_queue_setup_t
    tx_queue_release*: eth_queue_release_t
    dev_led_on*: eth_dev_led_on_t
    dev_led_off*: eth_dev_led_off_t
    flow_ctrl_get*: flow_ctrl_get_t
    flow_ctrl_set*: flow_ctrl_set_t
    priority_flow_ctrl_set*: priority_flow_ctrl_set_t
    mac_addr_remove*: eth_mac_addr_remove_t
    mac_addr_add*: eth_mac_addr_add_t
    mac_addr_set*: eth_mac_addr_set_t
    uc_hash_table_set*: eth_uc_hash_table_set_t
    uc_all_hash_table_set*: eth_uc_all_hash_table_set_t
    mirror_rule_set*: eth_mirror_rule_set_t
    mirror_rule_reset*: eth_mirror_rule_reset_t
    set_vf_rx_mode*: eth_set_vf_rx_mode_t
    set_vf_rx*: eth_set_vf_rx_t
    set_vf_tx*: eth_set_vf_tx_t
    set_vf_vlan_filter*: eth_set_vf_vlan_filter_t
    udp_tunnel_port_add*: eth_udp_tunnel_port_add_t
    udp_tunnel_port_del*: eth_udp_tunnel_port_del_t
    set_queue_rate_limit*: eth_set_queue_rate_limit_t
    set_vf_rate_limit*: eth_set_vf_rate_limit_t
    reta_update*: reta_update_t
    reta_query*: reta_query_t
    get_reg*: eth_get_reg_t
    get_eeprom_length*: eth_get_eeprom_length_t
    get_eeprom*: eth_get_eeprom_t
    set_eeprom*: eth_set_eeprom_t
    rss_hash_update*: rss_hash_update_t
    rss_hash_conf_get*: rss_hash_conf_get_t
    filter_ctrl*: eth_filter_ctrl_t
    set_mc_addr_list*: eth_set_mc_addr_list_t
    rxq_info_get*: eth_rxq_info_get_t
    txq_info_get*: eth_txq_info_get_t
    timesync_enable*: eth_timesync_enable_t
    timesync_disable*: eth_timesync_disable_t
    timesync_read_rx_timestamp*: eth_timesync_read_rx_timestamp_t
    timesync_read_tx_timestamp*: eth_timesync_read_tx_timestamp_t
    get_dcb_info*: eth_get_dcb_info
    timesync_adjust_time*: eth_timesync_adjust_time
    timesync_read_time*: eth_timesync_read_time
    timesync_write_time*: eth_timesync_write_time
    l2_tunnel_eth_type_conf*: eth_l2_tunnel_eth_type_conf_t
    l2_tunnel_offload_set*: eth_l2_tunnel_offload_set_t

  rte_rx_callback_fn* = proc (port: uint8; queue: uint16; pkts: ptr ptr rte_mbuf;
                           nb_pkts: uint16; max_pkts: uint16;
                           user_param: pointer): uint16 {.cdecl.}
  rte_tx_callback_fn* = proc (port: uint8; queue: uint16; pkts: ptr ptr rte_mbuf;
                           nb_pkts: uint16; user_param: pointer): uint16 {.cdecl.}
  INNER_C_UNION_3380959430* = object {.union.}
    rx*: rte_rx_callback_fn
    tx*: rte_tx_callback_fn

  rte_eth_rxtx_callback* {.importc: "struct rte_eth_rxtx_callback", header: "rte_ethdev.h".} = object
    next*: ptr rte_eth_rxtx_callback
    fn*: INNER_C_UNION_3380959430
    param*: pointer

  rte_eth_dev_type* = enum
    RTE_ETH_DEV_UNKNOWN, RTE_ETH_DEV_PCI, RTE_ETH_DEV_VIRTUAL, RTE_ETH_DEV_MAX


  rte_eth_dev* {.importc: "struct rte_eth_dev", header: "rte_ethdev.h".} = object
    rx_pkt_burst*: eth_rx_burst_t
    tx_pkt_burst*: eth_tx_burst_t
    data*: ptr rte_eth_dev_data
    driver*: ptr eth_driver
    dev_ops*: ptr eth_dev_ops
    pci_dev*: ptr rte_pci_device
    link_intr_cbs*: rte_eth_dev_cb_list
    post_rx_burst_cbs*: array[RTE_MAX_QUEUES_PER_PORT, ptr rte_eth_rxtx_callback]
    pre_tx_burst_cbs*: array[RTE_MAX_QUEUES_PER_PORT, ptr rte_eth_rxtx_callback]
    attached*: uint8
    dev_type*: rte_eth_dev_type

  rte_eth_dev_sriov* {.importc: "struct rte_eth_dev_sriov", header: "rte_ethdev.h".} = object
    active*: uint8
    nb_q_per_pool*: uint8
    def_vmdq_idx*: uint16
    def_pool_q_idx*: uint16

  rte_eth_dev_data* {.importc: "struct rte_eth_dev_data", header: "rte_ethdev.h".} = object
    name*: array[(32), char]
    rx_queues*: ptr pointer
    tx_queues*: ptr pointer
    nb_rx_queues*: uint16
    nb_tx_queues*: uint16
    sriov*: rte_eth_dev_sriov
    dev_private*: pointer
    dev_link*: rte_eth_link
    dev_conf*: rte_eth_conf
    mtu*: uint16
    min_rx_buf_size*: uint32
    rx_mbuf_alloc_failed*: uint64
    mac_addrs*: ptr ether_addr
    mac_pool_sel*: array[128, uint64]
    hash_mac_addrs*: ptr ether_addr
    port_id*: uint8
    promiscuous* {.bitsize: 1.}: uint8
    scattered_rx* {.bitsize: 1.}: uint8
    all_multicast* {.bitsize: 1.}: uint8
    dev_started* {.bitsize: 1.}: uint8
    lro* {.bitsize: 1.}: uint8
    rx_queue_state*: array[RTE_MAX_QUEUES_PER_PORT, uint8]
    tx_queue_state*: array[RTE_MAX_QUEUES_PER_PORT, uint8]
    dev_flags*: uint32
    kdrv*: rte_kernel_driver
    numa_node*: cint
    drv_name*: cstring

  eth_dev_init_t* = proc (eth_dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_dev_uninit_t* = proc (eth_dev: ptr rte_eth_dev): cint {.cdecl.}
  eth_driver* = object
    pci_drv*: rte_pci_driver
    eth_dev_init*: eth_dev_init_t
    eth_dev_uninit*: eth_dev_uninit_t
    dev_private_size*: cuint

proc rte_eth_dev_count*(): uint8 {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_allocated*(name: cstring): ptr rte_eth_dev {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_allocate*(name: cstring; `type`: rte_eth_dev_type): ptr rte_eth_dev {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_release_port*(eth_dev: ptr rte_eth_dev): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_attach*(devargs: cstring; port_id: ptr uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_detach*(port_id: uint8; devname: cstring): cint {.importc, header: "rte_ethdev.h".}


proc rte_eth_driver_register*(eth_drv: ptr eth_driver) {.importc, header: "rte_ethdev.h".}
proc rte_eth_speed_bitflag*(speed: uint32; duplex: cint): uint32 {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_configure*(port_id: uint8; nb_rx_queue: uint16;
                           nb_tx_queue: uint16; eth_conf: ptr rte_eth_conf): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_rx_queue_setup*(port_id: uint8; rx_queue_id: uint16;
                            nb_rx_desc: uint16; socket_id: cuint;
                            rx_conf: ptr rte_eth_rxconf; mb_pool: ptr rte_mempool): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_tx_queue_setup*(port_id: uint8; tx_queue_id: uint16;
                            nb_tx_desc: uint16; socket_id: cuint;
                            tx_conf: ptr rte_eth_txconf): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_socket_id*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_is_valid_port*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rx_queue_start*(port_id: uint8; rx_queue_id: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rx_queue_stop*(port_id: uint8; rx_queue_id: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_tx_queue_start*(port_id: uint8; tx_queue_id: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_tx_queue_stop*(port_id: uint8; tx_queue_id: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_start*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_stop*(port_id: uint8) {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_link_up*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_link_down*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_close*(port_id: uint8) {.importc, header: "rte_ethdev.h".}
proc rte_eth_promiscuous_enable*(port_id: uint8) {.importc, header: "rte_ethdev.h".}
proc rte_eth_promiscuous_disable*(port_id: uint8) {.importc, header: "rte_ethdev.h".}
proc rte_eth_promiscuous_get*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_allmulticast_enable*(port_id: uint8) {.importc, header: "rte_ethdev.h".}
proc rte_eth_allmulticast_disable*(port_id: uint8) {.importc, header: "rte_ethdev.h".}
proc rte_eth_allmulticast_get*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_link_get*(port_id: uint8; link: ptr rte_eth_link) {.importc, header: "rte_ethdev.h".}
proc rte_eth_link_get_nowait*(port_id: uint8; link: ptr rte_eth_link) {.importc, header: "rte_ethdev.h".}
proc rte_eth_stats_get*(port_id: uint8; stats: ptr rte_eth_stats): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_stats_reset*(port_id: uint8) {.importc, header: "rte_ethdev.h".}
proc rte_eth_xstats_get_names*(port_id: uint8;
                              xstats_names: ptr rte_eth_xstat_name; size: cuint): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_xstats_get*(port_id: uint8; xstats: ptr rte_eth_xstat; n: cuint): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_xstats_reset*(port_id: uint8) {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_tx_queue_stats_mapping*(port_id: uint8;
    tx_queue_id: uint16; stat_idx: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_rx_queue_stats_mapping*(port_id: uint8;
    rx_queue_id: uint16; stat_idx: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_macaddr_get*(port_id: uint8; mac_addr: ptr ether_addr) {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_info_get*(port_id: uint8; dev_info: ptr rte_eth_dev_info) {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_get_supported_ptypes*(port_id: uint8; ptype_mask: uint32;
                                      ptypes: ptr uint32; num: cint): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_get_mtu*(port_id: uint8; mtu: ptr uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_mtu*(port_id: uint8; mtu: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_vlan_filter*(port_id: uint8; vlan_id: uint16; on: cint): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_vlan_strip_on_queue*(port_id: uint8; rx_queue_id: uint16;
    on: cint): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_vlan_ether_type*(port_id: uint8; vlan_type: rte_vlan_type;
                                     tag_type: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_vlan_offload*(port_id: uint8; offload_mask: cint): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_get_vlan_offload*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_vlan_pvid*(port_id: uint8; pvid: uint16; on: cint): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_rx_burst*(port_id: uint8; queue_id: uint16;
                      rx_pkts: ptr ptr rte_mbuf; nb_pkts: uint16): uint16 {.inline, importc, header: "rte_ethdev.h".}
proc rte_eth_rx_queue_count*(port_id: uint8; queue_id: uint16): cint {.inline, importc, header: "rte_ethdev.h".}
proc rte_eth_rx_descriptor_done*(port_id: uint8; queue_id: uint16;
                                offset: uint16): cint {.inline, importc, header: "rte_ethdev.h".}
proc rte_eth_tx_burst*(port_id: uint8; queue_id: uint16;
                      tx_pkts: ptr ptr rte_mbuf; nb_pkts: uint16): uint16 {.inline, importc, header: "rte_ethdev.h".}
type
  buffer_tx_error_fn* = proc (unsent: ptr ptr rte_mbuf; count: uint16;
                           userdata: pointer) {.cdecl.}
  rte_eth_dev_tx_buffer* = object
    error_callback*: buffer_tx_error_fn
    error_userdata*: pointer
    size*: uint16
    length*: uint16
    pkts*: ptr ptr rte_mbuf


proc rte_eth_tx_buffer_init*(buffer: ptr rte_eth_dev_tx_buffer; size: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_tx_buffer_flush*(port_id: uint8; queue_id: uint16;
                             buffer: ptr rte_eth_dev_tx_buffer): uint16 {.inline, importc, header: "rte_ethdev.h".}
proc rte_eth_tx_buffer*(port_id: uint8; queue_id: uint16;
                       buffer: ptr rte_eth_dev_tx_buffer; tx_pkt: ptr rte_mbuf): uint16 {.inline, importc, header: "rte_ethdev.h".}

proc rte_eth_tx_buffer_set_err_callback*(buffer: ptr rte_eth_dev_tx_buffer;
                                        callback: buffer_tx_error_fn;
                                        userdata: pointer): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_tx_buffer_drop_callback*(pkts: ptr ptr rte_mbuf; unsent: uint16;
                                     userdata: pointer) {.importc, header: "rte_ethdev.h".}
proc rte_eth_tx_buffer_count_callback*(pkts: ptr ptr rte_mbuf; unsent: uint16;
                                      userdata: pointer) {.importc, header: "rte_ethdev.h".}


proc rte_eth_dev_callback_register*(port_id: uint8; event: rte_eth_event_type;
                                   cb_fn: rte_eth_dev_cb_fn; cb_arg: pointer): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_callback_unregister*(port_id: uint8; event: rte_eth_event_type;
                                     cb_fn: rte_eth_dev_cb_fn; cb_arg: pointer): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rx_intr_enable*(port_id: uint8; queue_id: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rx_intr_disable*(port_id: uint8; queue_id: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rx_intr_ctl*(port_id: uint8; epfd: cint; op: cint; data: pointer): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rx_intr_ctl_q*(port_id: uint8; queue_id: uint16; epfd: cint;
                               op: cint; data: pointer): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_led_on*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_led_off*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_flow_ctrl_get*(port_id: uint8; fc_conf: ptr rte_eth_fc_conf): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_flow_ctrl_set*(port_id: uint8; fc_conf: ptr rte_eth_fc_conf): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_priority_flow_ctrl_set*(port_id: uint8;
                                        pfc_conf: ptr rte_eth_pfc_conf): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_mac_addr_add*(port: uint8; mac_addr: ptr ether_addr; pool: uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_mac_addr_remove*(port: uint8; mac_addr: ptr ether_addr): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_default_mac_addr_set*(port: uint8; mac_addr: ptr ether_addr): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rss_reta_update*(port: uint8;
                                 reta_conf: ptr rte_eth_rss_reta_entry64;
                                 reta_size: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rss_reta_query*(port: uint8;
                                reta_conf: ptr rte_eth_rss_reta_entry64;
                                reta_size: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_uc_hash_table_set*(port: uint8; `addr`: ptr ether_addr; on: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_uc_all_hash_table_set*(port: uint8; on: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_vf_rxmode*(port: uint8; vf: uint16; rx_mode: uint16;
                               on: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_vf_tx*(port: uint8; vf: uint16; on: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_vf_rx*(port: uint8; vf: uint16; on: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_vf_vlan_filter*(port: uint8; vlan_id: uint16;
                                    vf_mask: uint64; vlan_on: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_mirror_rule_set*(port_id: uint8;
                             mirror_conf: ptr rte_eth_mirror_conf;
                             rule_id: uint8; on: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_mirror_rule_reset*(port_id: uint8; rule_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_set_queue_rate_limit*(port_id: uint8; queue_idx: uint16;
                                  tx_rate: uint16): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_set_vf_rate_limit*(port_id: uint8; vf: uint16; tx_rate: uint16;
                               q_msk: uint64): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_bypass_init*(port: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_bypass_state_show*(port: uint8; state: ptr uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_bypass_state_set*(port: uint8; new_state: ptr uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_bypass_event_show*(port: uint8; event: uint32;
                                   state: ptr uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_bypass_event_store*(port: uint8; event: uint32; state: uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_wd_timeout_store*(port: uint8; timeout: uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_bypass_ver_show*(port: uint8; ver: ptr uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_bypass_wd_timeout_show*(port: uint8; wd_timeout: ptr uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_bypass_wd_reset*(port: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rss_hash_update*(port_id: uint8; rss_conf: ptr rte_eth_rss_conf): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_rss_hash_conf_get*(port_id: uint8;
                                   rss_conf: ptr rte_eth_rss_conf): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_udp_tunnel_port_add*(port_id: uint8;
                                     tunnel_udp: ptr rte_eth_udp_tunnel): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_udp_tunnel_port_delete*(port_id: uint8;
                                        tunnel_udp: ptr rte_eth_udp_tunnel): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_filter_supported*(port_id: uint8; filter_type: rte_filter_type): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_filter_ctrl*(port_id: uint8; filter_type: rte_filter_type;
                             filter_op: rte_filter_op; arg: pointer): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_get_dcb_info*(port_id: uint8; dcb_info: ptr rte_eth_dcb_info): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_add_rx_callback*(port_id: uint8; queue_id: uint16;
                             fn: rte_rx_callback_fn; user_param: pointer): pointer {.importc, header: "rte_ethdev.h".}
proc rte_eth_add_first_rx_callback*(port_id: uint8; queue_id: uint16;
                                   fn: rte_rx_callback_fn; user_param: pointer): pointer {.importc, header: "rte_ethdev.h".}
proc rte_eth_add_tx_callback*(port_id: uint8; queue_id: uint16;
                             fn: rte_tx_callback_fn; user_param: pointer): pointer {.importc, header: "rte_ethdev.h".}
proc rte_eth_remove_rx_callback*(port_id: uint8; queue_id: uint16;
                                user_cb: ptr rte_eth_rxtx_callback): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_remove_tx_callback*(port_id: uint8; queue_id: uint16;
                                user_cb: ptr rte_eth_rxtx_callback): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_rx_queue_info_get*(port_id: uint8; queue_id: uint16;
                               qinfo: ptr rte_eth_rxq_info): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_tx_queue_info_get*(port_id: uint8; queue_id: uint16;
                               qinfo: ptr rte_eth_txq_info): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_get_reg_info*(port_id: uint8; info: ptr rte_dev_reg_info): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_get_eeprom_length*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_get_eeprom*(port_id: uint8; info: ptr rte_dev_eeprom_info): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_eeprom*(port_id: uint8; info: ptr rte_dev_eeprom_info): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_set_mc_addr_list*(port_id: uint8; mc_addr_set: ptr ether_addr;
                                  nb_mc_addr: uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_timesync_enable*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_timesync_disable*(port_id: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_timesync_read_rx_timestamp*(port_id: uint8; timestamp: ptr timespec;
                                        flags: uint32): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_timesync_read_tx_timestamp*(port_id: uint8; timestamp: ptr timespec): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_timesync_adjust_time*(port_id: uint8; delta: int64): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_timesync_read_time*(port_id: uint8; time: ptr timespec): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_timesync_write_time*(port_id: uint8; time: ptr timespec): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_copy_pci_info*(eth_dev: ptr rte_eth_dev; pci_dev: ptr rte_pci_device) {.importc, header: "rte_ethdev.h".}
proc rte_eth_dma_zone_reserve*(eth_dev: ptr rte_eth_dev; name: cstring;
                              queue_id: uint16; size: csize; align: cuint;
                              socket_id: cint): ptr rte_memzone {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_l2_tunnel_eth_type_conf*(port_id: uint8;
    l2_tunnel: ptr rte_eth_l2_tunnel_conf): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_l2_tunnel_offload_set*(port_id: uint8;
                                       l2_tunnel: ptr rte_eth_l2_tunnel_conf;
                                       mask: uint32; en: uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_get_port_by_name*(name: cstring; port_id: ptr uint8): cint {.importc, header: "rte_ethdev.h".}
proc rte_eth_dev_get_name_by_port*(port_id: uint8; name: cstring): cint {.importc, header: "rte_ethdev.h".}
