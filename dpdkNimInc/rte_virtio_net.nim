const
  RTE_VHOST_USER_CLIENT* = (1 shl 0)
  RTE_VHOST_USER_NO_RECONNECT* = (1 shl 1)

const
  VIRTIO_RXQ* = 0
  VIRTIO_TXQ* = 1
  VIRTIO_QNUM* = 2

type
  virtio_net_device_ops* {.importc: "struct virtio_net_device_ops", header: "rte_virtio_net.h".} = object
    new_device*: proc (vid: cint): cint {.cdecl.}
    destroy_device*: proc (vid: cint) {.cdecl.}
    vring_state_changed*: proc (vid: cint; queue_id: uint16; enable: cint): cint {.cdecl.}
    reserved*: array[5, pointer]


proc rte_vhost_feature_disable*(feature_mask: uint64): cint {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_feature_enable*(feature_mask: uint64): cint {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_feature_get*(): uint64 {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_enable_guest_notification*(vid: cint; queue_id: uint16; enable: cint): cint {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_driver_register*(path: cstring; flags: uint64): cint {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_driver_unregister*(path: cstring): cint {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_driver_callback_register*(a2: ptr virtio_net_device_ops): cint {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_driver_session_start*(): cint {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_get_numa_node*(vid: cint): cint {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_get_queue_num*(vid: cint): uint32 {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_get_ifname*(vid: cint; buf: cstring; len: csize): cint {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_avail_entries*(vid: cint; queue_id: uint16): uint16 {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_enqueue_burst*(vid: cint; queue_id: uint16; pkts: ptr ptr rte_mbuf;
                             count: uint16): uint16 {.importc, header: "rte_virtio_net.h".}
proc rte_vhost_dequeue_burst*(vid: cint; queue_id: uint16;
                             mbuf_pool: ptr rte_mempool; pkts: ptr ptr rte_mbuf;
                             count: uint16): uint16 {.importc, header: "rte_virtio_net.h".}
