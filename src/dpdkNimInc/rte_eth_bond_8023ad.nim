const
  STATE_LACP_ACTIVE* = 0x00000001
  STATE_LACP_SHORT_TIMEOUT* = 0x00000002
  STATE_AGGREGATION* = 0x00000004
  STATE_SYNCHRONIZATION* = 0x00000008
  STATE_COLLECTING* = 0x00000010
  STATE_DISTRIBUTING* = 0x00000020
  STATE_DEFAULTED* = 0x00000040
  STATE_EXPIRED* = 0x00000080
  TLV_TYPE_ACTOR_INFORMATION* = 0x00000001
  TLV_TYPE_PARTNER_INFORMATION* = 0x00000002
  TLV_TYPE_COLLECTOR_INFORMATION* = 0x00000003
  TLV_TYPE_TERMINATOR_INFORMATION* = 0x00000000
  SLOW_SUBTYPE_LACP* = 0x00000001
  SLOW_SUBTYPE_MARKER* = 0x00000002
  MARKER_TLV_TYPE_INFO* = 0x00000001
  MARKER_TLV_TYPE_RESP* = 0x00000002

type
  rte_eth_bond_8023ad_ext_slowrx_fn* = proc (slave_id: uint8;
      lacp_pkt: ptr rte_mbuf) {.cdecl.}
  rte_bond_8023ad_selection* = enum
    UNSELECTED, STANDBY, SELECTED


type
  slow_protocol* {.importc: "struct slow_protocol", header: "rte_eth_bond_8023ad.h".} = object
    subtype*: uint8
    reserved_119*: array[119, uint8]

  slow_protocol_frame* {.importc: "struct slow_protocol_frame", header: "rte_eth_bond_8023ad.h".} = object
    eth_hdr*: ether_hdr
    slow_protocol*: slow_protocol

  port_params* {.importc: "struct port_params", header: "rte_eth_bond_8023ad.h".} = object
    system_priority*: uint16
    system*: ether_addr
    key*: uint16
    port_priority*: uint16
    port_number*: uint16

  lacpdu_actor_partner_params* {.importc: "struct lacpdu_actor_partner_params", header: "rte_eth_bond_8023ad.h".} = object
    tlv_type_info*: uint8
    info_length*: uint8
    port_params*: port_params
    state*: uint8
    reserved_3*: array[3, uint8]

  lacpdu* {.importc: "struct lacpdu", header: "rte_eth_bond_8023ad.h".} = object
    subtype*: uint8
    version_number*: uint8
    actor*: lacpdu_actor_partner_params
    partner*: lacpdu_actor_partner_params
    tlv_type_collector_info*: uint8
    collector_info_length*: uint8
    collector_max_delay*: uint16
    reserved_12*: array[12, uint8]
    tlv_type_terminator*: uint8
    terminator_length*: uint8
    reserved_50*: array[50, uint8]

  lacpdu_header* {.importc: "struct lacpdu_header", header: "rte_eth_bond_8023ad.h".} = object
    eth_hdr*: ether_hdr
    lacpdu*: lacpdu

  marker* {.importc: "struct marker", header: "rte_eth_bond_8023ad.h".} = object
    subtype*: uint8
    version_number*: uint8
    tlv_type_marker*: uint8
    info_length*: uint8
    requester_port*: uint16
    requester_system*: ether_addr
    requester_transaction_id*: uint32
    reserved_2*: array[2, uint8]
    tlv_type_terminator*: uint8
    terminator_length*: uint8
    reserved_90*: array[90, uint8]

  marker_header* {.importc: "struct marker_header", header: "rte_eth_bond_8023ad.h".} = object
    eth_hdr*: ether_hdr
    marker*: marker

  rte_eth_bond_8023ad_conf* {.importc: "struct rte_eth_bond_8023ad_conf", header: "rte_eth_bond_8023ad.h".} = object
    fast_periodic_ms*: uint32
    slow_periodic_ms*: uint32
    short_timeout_ms*: uint32
    long_timeout_ms*: uint32
    aggregate_wait_timeout_ms*: uint32
    tx_period_ms*: uint32
    rx_marker_period_ms*: uint32
    update_timeout_ms*: uint32
    slowrx_cb*: rte_eth_bond_8023ad_ext_slowrx_fn

  rte_eth_bond_8023ad_slave_info* {.importc: "struct rte_eth_bond_8023ad_slave_info", header: "rte_eth_bond_8023ad.h".} = object
    selected*: rte_bond_8023ad_selection
    actor_state*: uint8
    actor*: port_params
    partner_state*: uint8
    partner*: port_params
    agg_port_id*: uint8


proc rte_eth_bond_8023ad_conf_get*(port_id: uint8;
                                  conf: ptr rte_eth_bond_8023ad_conf): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_conf_get_v20*(port_id: uint8;
                                      conf: ptr rte_eth_bond_8023ad_conf): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_conf_get_v1607*(port_id: uint8;
                                        conf: ptr rte_eth_bond_8023ad_conf): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_setup*(port_id: uint8;
                               conf: ptr rte_eth_bond_8023ad_conf): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_setup_v20*(port_id: uint8;
                                   conf: ptr rte_eth_bond_8023ad_conf): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_setup_v1607*(port_id: uint8;
                                     conf: ptr rte_eth_bond_8023ad_conf): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_slave_info_nim*(port_id: uint8; slave_id: uint8;
                                    conf: ptr rte_eth_bond_8023ad_slave_info): cint {.importc: "rte_eth_bond_8023ad_slave_info_func", header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_ext_collect*(port_id: uint8; slave_id: uint8;
                                     enabled: cint): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_ext_collect_get*(port_id: uint8; slave_id: uint8): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_ext_distrib*(port_id: uint8; slave_id: uint8;
                                     enabled: cint): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_ext_distrib_get*(port_id: uint8; slave_id: uint8): cint {.importc, header: "rte_eth_bond_8023ad.h".}
proc rte_eth_bond_8023ad_ext_slowtx*(port_id: uint8; slave_id: uint8;
                                    lacp_pkt: ptr rte_mbuf): cint {.importc, header: "rte_eth_bond_8023ad.h".}
