const
  RTE_ETH_FLOW_UNKNOWN* = 0
  RTE_ETH_FLOW_RAW* = 1
  RTE_ETH_FLOW_IPV4* = 2
  RTE_ETH_FLOW_FRAG_IPV4* = 3
  RTE_ETH_FLOW_NONFRAG_IPV4_TCP* = 4
  RTE_ETH_FLOW_NONFRAG_IPV4_UDP* = 5
  RTE_ETH_FLOW_NONFRAG_IPV4_SCTP* = 6
  RTE_ETH_FLOW_NONFRAG_IPV4_OTHER* = 7
  RTE_ETH_FLOW_IPV6* = 8
  RTE_ETH_FLOW_FRAG_IPV6* = 9
  RTE_ETH_FLOW_NONFRAG_IPV6_TCP* = 10
  RTE_ETH_FLOW_NONFRAG_IPV6_UDP* = 11
  RTE_ETH_FLOW_NONFRAG_IPV6_SCTP* = 12
  RTE_ETH_FLOW_NONFRAG_IPV6_OTHER* = 13
  RTE_ETH_FLOW_L2_PAYLOAD* = 14
  RTE_ETH_FLOW_IPV6_EX* = 15
  RTE_ETH_FLOW_IPV6_TCP_EX* = 16
  RTE_ETH_FLOW_IPV6_UDP_EX* = 17
  RTE_ETH_FLOW_PORT* = 18
  RTE_ETH_FLOW_VXLAN* = 19
  RTE_ETH_FLOW_GENEVE* = 20
  RTE_ETH_FLOW_NVGRE* = 21
  RTE_ETH_FLOW_MAX* = 22
  RTE_ETHTYPE_FLAGS_MAC* = 0x00000001
  RTE_ETHTYPE_FLAGS_DROP* = 0x00000002
  RTE_FLEX_FILTER_MAXLEN* = 128
  RTE_NTUPLE_FLAGS_DST_IP* = 0x00000001
  RTE_NTUPLE_FLAGS_SRC_IP* = 0x00000002
  RTE_NTUPLE_FLAGS_DST_PORT* = 0x00000004
  RTE_NTUPLE_FLAGS_SRC_PORT* = 0x00000008
  RTE_NTUPLE_FLAGS_PROTO* = 0x00000010
  RTE_NTUPLE_FLAGS_TCP_FLAG* = 0x00000020
  RTE_5TUPLE_FLAGS* = (RTE_NTUPLE_FLAGS_DST_IP or RTE_NTUPLE_FLAGS_SRC_IP or
      RTE_NTUPLE_FLAGS_DST_PORT or RTE_NTUPLE_FLAGS_SRC_PORT or
      RTE_NTUPLE_FLAGS_PROTO)
  RTE_2TUPLE_FLAGS* = (RTE_NTUPLE_FLAGS_DST_PORT or RTE_NTUPLE_FLAGS_PROTO)
  TCP_URG_FLAG* = 0x00000020
  TCP_ACK_FLAG* = 0x00000010
  TCP_PSH_FLAG* = 0x00000008
  TCP_RST_FLAG* = 0x00000004
  TCP_SYN_FLAG* = 0x00000002
  TCP_FIN_FLAG* = 0x00000001
  TCP_FLAG_ALL* = 0x0000003F
  ETH_TUNNEL_FILTER_OMAC* = 0x00000001
  ETH_TUNNEL_FILTER_OIP* = 0x00000002
  ETH_TUNNEL_FILTER_TENID* = 0x00000004
  ETH_TUNNEL_FILTER_IMAC* = 0x00000008
  ETH_TUNNEL_FILTER_IVLAN* = 0x00000010
  ETH_TUNNEL_FILTER_IIP* = 0x00000020
  RTE_TUNNEL_FILTER_IMAC_IVLAN* = (
    ETH_TUNNEL_FILTER_IMAC or ETH_TUNNEL_FILTER_IVLAN)
  RTE_TUNNEL_FILTER_IMAC_IVLAN_TENID* = (ETH_TUNNEL_FILTER_IMAC or
      ETH_TUNNEL_FILTER_IVLAN or ETH_TUNNEL_FILTER_TENID)
  RTE_TUNNEL_FILTER_IMAC_TENID* = (
    ETH_TUNNEL_FILTER_IMAC or ETH_TUNNEL_FILTER_TENID)
  RTE_TUNNEL_FILTER_OMAC_TENID_IMAC* = (
    ETH_TUNNEL_FILTER_OMAC or ETH_TUNNEL_FILTER_TENID or ETH_TUNNEL_FILTER_IMAC)
  RTE_ETH_FDIR_MAX_FLEXLEN* = 16
  RTE_ETH_INSET_SIZE_MAX* = 128

type
  rte_filter_type* = enum
    RTE_ETH_FILTER_NONE = 0, RTE_ETH_FILTER_MACVLAN, RTE_ETH_FILTER_ETHERTYPE,
    RTE_ETH_FILTER_FLEXIBLE, RTE_ETH_FILTER_SYN, RTE_ETH_FILTER_NTUPLE,
    RTE_ETH_FILTER_TUNNEL, RTE_ETH_FILTER_FDIR, RTE_ETH_FILTER_HASH,
    RTE_ETH_FILTER_L2_TUNNEL, RTE_ETH_FILTER_MAX


type
  rte_filter_op* = enum
    RTE_ETH_FILTER_NOP = 0, RTE_ETH_FILTER_ADD, RTE_ETH_FILTER_UPDATE,
    RTE_ETH_FILTER_DELETE, RTE_ETH_FILTER_FLUSH, RTE_ETH_FILTER_GET,
    RTE_ETH_FILTER_SET, RTE_ETH_FILTER_INFO, RTE_ETH_FILTER_STATS,
    RTE_ETH_FILTER_OP_MAX


type
  rte_mac_filter_type* = enum
    RTE_MAC_PERFECT_MATCH = 1, RTE_MACVLAN_PERFECT_MATCH, RTE_MAC_HASH_MATCH,
    RTE_MACVLAN_HASH_MATCH


type
  rte_eth_mac_filter* = object
    is_vf*: uint8
    dst_id*: uint16
    filter_type*: rte_mac_filter_type
    mac_addr*: ether_addr

  rte_eth_ethertype_filter* = object
    mac_addr*: ether_addr
    ether_type*: uint16
    flags*: uint16
    queue*: uint16

#  rte_eth_flex_filter* = object
#    len*: uint16
#    bytes*: array[128, uint8]
#    mask*: array[(RTE_ALIGN(128, CHAR_BIT) div CHAR_BIT), uint8]
#    priority*: uint8
#    queue*: uint16

  rte_eth_syn_filter* = object
    hig_pri*: uint8
    queue*: uint16

  rte_eth_ntuple_filter* = object
    flags*: uint16
    dst_ip*: uint32
    dst_ip_mask*: uint32
    src_ip*: uint32
    src_ip_mask*: uint32
    dst_port*: uint16
    dst_port_mask*: uint16
    src_port*: uint16
    src_port_mask*: uint16
    proto*: uint8
    proto_mask*: uint8
    tcp_flags*: uint8
    priority*: uint16
    queue*: uint16

  rte_eth_tunnel_type* = enum
    RTE_TUNNEL_TYPE_NONE = 0, RTE_TUNNEL_TYPE_VXLAN, RTE_TUNNEL_TYPE_GENEVE,
    RTE_TUNNEL_TYPE_TEREDO, RTE_TUNNEL_TYPE_NVGRE, RTE_TUNNEL_TYPE_IP_IN_GRE,
    RTE_L2_TUNNEL_TYPE_E_TAG, RTE_TUNNEL_TYPE_MAX


type
  rte_tunnel_iptype* = enum
    RTE_TUNNEL_IPTYPE_IPV4 = 0, RTE_TUNNEL_IPTYPE_IPV6


type
  INNER_C_UNION_3410340861* = object {.union.}
    ipv4_addr*: uint32
    ipv6_addr*: array[4, uint32]

  rte_eth_tunnel_filter_conf* = object
    outer_mac*: ether_addr
    inner_mac*: ether_addr
    inner_vlan*: uint16
    ip_type*: rte_tunnel_iptype
    ip_addr*: INNER_C_UNION_3410340861
    filter_type*: uint16
    tunnel_type*: rte_eth_tunnel_type
    tenant_id*: uint32
    queue_id*: uint16

  rte_eth_global_cfg_type* = enum
    RTE_ETH_GLOBAL_CFG_TYPE_UNKNOWN = 0, RTE_ETH_GLOBAL_CFG_TYPE_GRE_KEY_LEN,
    RTE_ETH_GLOBAL_CFG_TYPE_MAX


type
  INNER_C_UNION_1775731305* = object {.union.}
    gre_key_len*: uint8
    reserved*: uint64

  rte_eth_global_cfg* = object
    cfg_type*: rte_eth_global_cfg_type
    cfg*: INNER_C_UNION_1775731305

  rte_eth_input_set_field* = enum
    RTE_ETH_INPUT_SET_UNKNOWN = 0, RTE_ETH_INPUT_SET_L2_SRC_MAC = 1,
    RTE_ETH_INPUT_SET_L2_DST_MAC, RTE_ETH_INPUT_SET_L2_OUTER_VLAN,
    RTE_ETH_INPUT_SET_L2_INNER_VLAN, RTE_ETH_INPUT_SET_L2_ETHERTYPE,
    RTE_ETH_INPUT_SET_L3_SRC_IP4 = 129, RTE_ETH_INPUT_SET_L3_DST_IP4,
    RTE_ETH_INPUT_SET_L3_SRC_IP6, RTE_ETH_INPUT_SET_L3_DST_IP6,
    RTE_ETH_INPUT_SET_L3_IP4_TOS, RTE_ETH_INPUT_SET_L3_IP4_PROTO,
    RTE_ETH_INPUT_SET_L3_IP6_TC, RTE_ETH_INPUT_SET_L3_IP6_NEXT_HEADER,
    RTE_ETH_INPUT_SET_L3_IP4_TTL, RTE_ETH_INPUT_SET_L3_IP6_HOP_LIMITS,
    RTE_ETH_INPUT_SET_L4_UDP_SRC_PORT = 257, RTE_ETH_INPUT_SET_L4_UDP_DST_PORT,
    RTE_ETH_INPUT_SET_L4_TCP_SRC_PORT, RTE_ETH_INPUT_SET_L4_TCP_DST_PORT,
    RTE_ETH_INPUT_SET_L4_SCTP_SRC_PORT, RTE_ETH_INPUT_SET_L4_SCTP_DST_PORT,
    RTE_ETH_INPUT_SET_L4_SCTP_VERIFICATION_TAG,
    RTE_ETH_INPUT_SET_TUNNEL_L2_INNER_DST_MAC = 385,
    RTE_ETH_INPUT_SET_TUNNEL_L2_INNER_SRC_MAC,
    RTE_ETH_INPUT_SET_TUNNEL_L2_INNER_VLAN, RTE_ETH_INPUT_SET_TUNNEL_L4_UDP_KEY,
    RTE_ETH_INPUT_SET_TUNNEL_GRE_KEY,
    RTE_ETH_INPUT_SET_FLEX_PAYLOAD_1ST_WORD = 641,
    RTE_ETH_INPUT_SET_FLEX_PAYLOAD_2ND_WORD,
    RTE_ETH_INPUT_SET_FLEX_PAYLOAD_3RD_WORD,
    RTE_ETH_INPUT_SET_FLEX_PAYLOAD_4TH_WORD,
    RTE_ETH_INPUT_SET_FLEX_PAYLOAD_5TH_WORD,
    RTE_ETH_INPUT_SET_FLEX_PAYLOAD_6TH_WORD,
    RTE_ETH_INPUT_SET_FLEX_PAYLOAD_7TH_WORD,
    RTE_ETH_INPUT_SET_FLEX_PAYLOAD_8TH_WORD, RTE_ETH_INPUT_SET_DEFAULT = 65533,
    RTE_ETH_INPUT_SET_NONE = 65534, RTE_ETH_INPUT_SET_MAX = 65535


type
  rte_filter_input_set_op* = enum
    RTE_ETH_INPUT_SET_OP_UNKNOWN, RTE_ETH_INPUT_SET_SELECT, RTE_ETH_INPUT_SET_ADD,
    RTE_ETH_INPUT_SET_OP_MAX


type
  rte_eth_input_set_conf* = object
    flow_type*: uint16
    inset_size*: uint16
    field*: array[128, rte_eth_input_set_field]
    op*: rte_filter_input_set_op

  rte_eth_l2_flow* = object
    ether_type*: uint16

  rte_eth_ipv4_flow* = object
    src_ip*: uint32
    dst_ip*: uint32
    tos*: uint8
    ttl*: uint8
    proto*: uint8

  rte_eth_udpv4_flow* = object
    ip*: rte_eth_ipv4_flow
    src_port*: uint16
    dst_port*: uint16

  rte_eth_tcpv4_flow* = object
    ip*: rte_eth_ipv4_flow
    src_port*: uint16
    dst_port*: uint16

  rte_eth_sctpv4_flow* = object
    ip*: rte_eth_ipv4_flow
    src_port*: uint16
    dst_port*: uint16
    verify_tag*: uint32

  rte_eth_ipv6_flow* = object
    src_ip*: array[4, uint32]
    dst_ip*: array[4, uint32]
    tc*: uint8
    proto*: uint8
    hop_limits*: uint8

  rte_eth_udpv6_flow* = object
    ip*: rte_eth_ipv6_flow
    src_port*: uint16
    dst_port*: uint16

  rte_eth_tcpv6_flow* = object
    ip*: rte_eth_ipv6_flow
    src_port*: uint16
    dst_port*: uint16

  rte_eth_sctpv6_flow* = object
    ip*: rte_eth_ipv6_flow
    src_port*: uint16
    dst_port*: uint16
    verify_tag*: uint32

  rte_eth_mac_vlan_flow* = object
    mac_addr*: ether_addr

  rte_eth_fdir_tunnel_type* = enum
    RTE_FDIR_TUNNEL_TYPE_UNKNOWN = 0, RTE_FDIR_TUNNEL_TYPE_NVGRE,
    RTE_FDIR_TUNNEL_TYPE_VXLAN


type
  rte_eth_tunnel_flow* = object
    tunnel_type*: rte_eth_fdir_tunnel_type
    tunnel_id*: uint32
    mac_addr*: ether_addr

  rte_eth_fdir_flow* = object {.union.}
    l2_flow*: rte_eth_l2_flow
    udp4_flow*: rte_eth_udpv4_flow
    tcp4_flow*: rte_eth_tcpv4_flow
    sctp4_flow*: rte_eth_sctpv4_flow
    ip4_flow*: rte_eth_ipv4_flow
    udp6_flow*: rte_eth_udpv6_flow
    tcp6_flow*: rte_eth_tcpv6_flow
    sctp6_flow*: rte_eth_sctpv6_flow
    ipv6_flow*: rte_eth_ipv6_flow
    mac_vlan_flow*: rte_eth_mac_vlan_flow
    tunnel_flow*: rte_eth_tunnel_flow

  rte_eth_fdir_flow_ext* = object
    vlan_tci*: uint16
    flexbytes*: array[16, uint8]
    is_vf*: uint8
    dst_id*: uint16

  rte_eth_fdir_input* = object
    flow_type*: uint16
    flow*: rte_eth_fdir_flow
    flow_ext*: rte_eth_fdir_flow_ext

  rte_eth_fdir_behavior* = enum
    RTE_ETH_FDIR_ACCEPT = 0, RTE_ETH_FDIR_REJECT, RTE_ETH_FDIR_PASSTHRU


type
  rte_eth_fdir_status* = enum
    RTE_ETH_FDIR_NO_REPORT_STATUS = 0, RTE_ETH_FDIR_REPORT_ID,
    RTE_ETH_FDIR_REPORT_ID_FLEX_4, RTE_ETH_FDIR_REPORT_FLEX_8


type
  rte_eth_fdir_action* = object
    rx_queue*: uint16
    behavior*: rte_eth_fdir_behavior
    report_status*: rte_eth_fdir_status
    flex_off*: uint8

  rte_eth_fdir_filter* = object
    soft_id*: uint32
    input*: rte_eth_fdir_input
    action*: rte_eth_fdir_action

  rte_eth_fdir_masks* = object
    vlan_tci_mask*: uint16
    ipv4_mask*: rte_eth_ipv4_flow
    ipv6_mask*: rte_eth_ipv6_flow
    src_port_mask*: uint16
    dst_port_mask*: uint16
    mac_addr_byte_mask*: uint8
    tunnel_id_mask*: uint32
    tunnel_type_mask*: uint8

  rte_eth_payload_type* = enum
    RTE_ETH_PAYLOAD_UNKNOWN = 0, RTE_ETH_RAW_PAYLOAD, RTE_ETH_L2_PAYLOAD,
    RTE_ETH_L3_PAYLOAD, RTE_ETH_L4_PAYLOAD, RTE_ETH_DUMMY5, RTE_ETH_DUMMY6, RTE_ETH_DUMMY7, RTE_ETH_PAYLOAD_MAX = 8


type
  rte_eth_flex_payload_cfg* = object
    `type`*: rte_eth_payload_type
    src_offset*: array[16, uint16]

  rte_eth_fdir_flex_mask* = object
    flow_type*: uint16
    mask*: array[16, uint8]

  rte_eth_fdir_flex_conf* = object
    nb_payloads*: uint16
    nb_flexmasks*: uint16
    flex_set*: array[RTE_ETH_PAYLOAD_MAX, rte_eth_flex_payload_cfg]
    flex_mask*: array[22, rte_eth_fdir_flex_mask]

  rte_fdir_mode* = enum
    RTE_FDIR_MODE_NONE = 0, RTE_FDIR_MODE_SIGNATURE, RTE_FDIR_MODE_PERFECT,
    RTE_FDIR_MODE_PERFECT_MAC_VLAN, RTE_FDIR_MODE_PERFECT_TUNNEL


type
#  rte_eth_fdir_info* = object
#    mode*: rte_fdir_mode
#    mask*: rte_eth_fdir_masks
#    flex_conf*: rte_eth_fdir_flex_conf
#    guarant_spc*: uint32
#    best_spc*: uint32
#    flow_types_mask*: array[(RTE_ALIGN(22, (CHAR_BIT * sizeof((uint32)))) div
#        (CHAR_BIT * sizeof((uint32)))), uint32]
#    max_flexpayload*: uint32
#    flex_payload_unit*: uint32
#    max_flex_payload_segment_num*: uint32
#    flex_payload_limit*: uint16
#    flex_bitmask_unit*: uint32
#    max_flex_bitmask_num*: uint32

  rte_eth_fdir_stats* = object
    collision*: uint32
    free*: uint32
    maxhash*: uint32
    maxlen*: uint32
    add*: uint64
    remove*: uint64
    f_add*: uint64
    f_remove*: uint64
    guarant_cnt*: uint32
    best_cnt*: uint32

  rte_eth_fdir_filter_info_type* = enum
    RTE_ETH_FDIR_FILTER_INFO_TYPE_UNKNOWN = 0,
    RTE_ETH_FDIR_FILTER_INPUT_SET_SELECT, RTE_ETH_FDIR_FILTER_INFO_TYPE_MAX


type
  INNER_C_UNION_2865718372* = object {.union.}
    input_set_conf*: rte_eth_input_set_conf

  rte_eth_fdir_filter_info* = object
    info_type*: rte_eth_fdir_filter_info_type
    info*: INNER_C_UNION_2865718372

  rte_eth_hash_filter_info_type* = enum
    RTE_ETH_HASH_FILTER_INFO_TYPE_UNKNOWN = 0,
    RTE_ETH_HASH_FILTER_SYM_HASH_ENA_PER_PORT, RTE_ETH_HASH_FILTER_GLOBAL_CONFIG,
    RTE_ETH_HASH_FILTER_INPUT_SET_SELECT, RTE_ETH_HASH_FILTER_INFO_TYPE_MAX


type
  rte_eth_hash_function* = enum
    RTE_ETH_HASH_FUNCTION_DEFAULT = 0, RTE_ETH_HASH_FUNCTION_TOEPLITZ,
    RTE_ETH_HASH_FUNCTION_SIMPLE_XOR, RTE_ETH_HASH_FUNCTION_MAX


type
#  rte_eth_hash_global_conf* = object
#    hash_func*: rte_eth_hash_function
#    sym_hash_enable_mask*: array[(RTE_ALIGN(22, (CHAR_BIT * sizeof((uint32)))) div
#        (CHAR_BIT * sizeof((uint32)))), uint32]
#    valid_bit_mask*: array[(RTE_ALIGN(22, (CHAR_BIT * sizeof((uint32)))) div
#        (CHAR_BIT * sizeof((uint32)))), uint32]

#  INNER_C_UNION_164971495* = object {.union.}
#    enable*: uint8
#    global_conf*: rte_eth_hash_global_conf
#    input_set_conf*: rte_eth_input_set_conf
#
#  rte_eth_hash_filter_info* = object
#    info_type*: rte_eth_hash_filter_info_type
#    info*: INNER_C_UNION_164971495

  rte_eth_l2_tunnel_conf* = object
    l2_tunnel_type*: rte_eth_tunnel_type
    ether_type*: uint16
    tunnel_id*: uint32
    vf_id*: uint16
    pool*: uint32

