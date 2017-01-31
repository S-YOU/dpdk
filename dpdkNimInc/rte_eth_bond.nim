const
  BONDING_MODE_ROUND_ROBIN* = (0)
  BONDING_MODE_ACTIVE_BACKUP* = (1)
  BONDING_MODE_BALANCE* = (2)
  BONDING_MODE_BROADCAST* = (3)
  BONDING_MODE_8023AD* = (4)
  BONDING_MODE_TLB* = (5)
  BONDING_MODE_ALB* = (6)
  BALANCE_XMIT_POLICY_LAYER2* = (0)
  BALANCE_XMIT_POLICY_LAYER23* = (1)
  BALANCE_XMIT_POLICY_LAYER34* = (2)

proc rte_eth_bond_create*(name: cstring; mode: uint8; socket_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_free*(name: cstring): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_slave_add*(bonded_port_id: uint8; slave_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_slave_remove*(bonded_port_id: uint8; slave_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_mode_set*(bonded_port_id: uint8; mode: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_mode_get*(bonded_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_primary_set*(bonded_port_id: uint8; slave_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_primary_get*(bonded_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_slaves_get*(bonded_port_id: uint8; slaves: ptr uint8;
                             len: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_active_slaves_get*(bonded_port_id: uint8; slaves: ptr uint8;
                                    len: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_mac_address_set*(bonded_port_id: uint8;
                                  mac_addr: ptr ether_addr): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_mac_address_reset*(bonded_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_xmit_policy_set*(bonded_port_id: uint8; policy: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_xmit_policy_get*(bonded_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_link_monitoring_set*(bonded_port_id: uint8;
                                      internal_ms: uint32): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_link_monitoring_get*(bonded_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_link_down_prop_delay_set*(bonded_port_id: uint8;
    delay_ms: uint32): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_link_down_prop_delay_get*(bonded_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_link_up_prop_delay_set*(bonded_port_id: uint8;
    delay_ms: uint32): cint {.importc, header: "rte_eth_bond.h".}
proc rte_eth_bond_link_up_prop_delay_get*(bonded_port_id: uint8): cint {.importc, header: "rte_eth_bond.h".}
