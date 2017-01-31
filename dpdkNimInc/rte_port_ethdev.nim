type
  rte_port_ethdev_reader_params* = object
    port_id*: uint8
    queue_id*: uint16

  rte_port_ethdev_writer_params* = object
    port_id*: uint8
    queue_id*: uint16
    tx_burst_sz*: uint32

  rte_port_ethdev_writer_nodrop_params* = object
    port_id*: uint8
    queue_id*: uint16
    tx_burst_sz*: uint32
    n_retries*: uint32

