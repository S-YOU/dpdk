proc rte_eth_vhost_feature_disable*(feature_mask: uint64): cint {.importc, header: "rte_eth_vhost.h".}
proc rte_eth_vhost_feature_enable*(feature_mask: uint64): cint {.importc, header: "rte_eth_vhost.h".}
proc rte_eth_vhost_feature_get*(): uint64 {.importc, header: "rte_eth_vhost.h".}
type
  rte_eth_vhost_queue_event* = object
    queue_id*: uint16
    rx*: bool
    enable*: bool


proc rte_eth_vhost_get_queue_event*(port_id: uint8;
                                   event: ptr rte_eth_vhost_queue_event): cint {.importc, header: "rte_eth_vhost.h".}
