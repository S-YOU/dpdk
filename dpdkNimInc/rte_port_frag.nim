type
  rte_port_ring_reader_frag_params* = object
    ring*: ptr rte_ring
    mtu*: uint32
    metadata_size*: uint32
    pool_direct*: ptr rte_mempool
    pool_indirect*: ptr rte_mempool

