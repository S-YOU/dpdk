import os
import strutils

import "dpdk"

proc test() =
  var o: rte_xmm_t

  # cDecStructs.h start lib/librte_acl/acl.h
  var rte_acl_bitset_o: rte_acl_bitset
  var rte_acl_ptr_set_o: rte_acl_ptr_set
  var rte_acl_match_results_o: rte_acl_match_results
  var rte_acl_node_o: rte_acl_node
  var rte_acl_trie_o: rte_acl_trie
  var rte_acl_bld_trie_o: rte_acl_bld_trie
  var rte_acl_ctx_o: rte_acl_ctx
  var rte_cfgfile_section_o: rte_cfgfile_section
  var rte_cfgfile_o: rte_cfgfile

  # cDecStructs.h, lib/librte_distributor/rte_distributor.c
  var rte_distributor_returned_pkts_o: rte_distributor_returned_pkts
  var rte_distributor_buffer_o: rte_distributor_buffer
  var rte_distributor_backlog_o: rte_distributor_backlog
  var rte_distributor_o: rte_distributor

  # cDecStructs.h lib/librte_ether/rte_ethdev.c
  var rte_eth_dev_callback_o: rte_eth_dev_callback

  # cDecStructs.h lib/librte_hash/rte_cuckoo_hash.h
  var lcore_cache_o: lcore_cache
  var rte_hash_signatures_o: rte_hash_signatures
  var rte_hash_bucket_o: rte_hash_bucket
  var rte_hash_o: rte_hash

  # cDecStructs lib/librte_eal/common/rte_keepalive.c
  var rte_keepalive_o: rte_keepalive
  echo "\nsizeof(rte_keepalive_o) = ", sizeof(rte_keepalive_o)

  # cDecStructs lib/librte_kni/rte_kni.c
  var rte_kni_o: rte_kni

  # /usr/include/x86_64-linux-gnu/bits/sched.h
  var cpu_set_t_o: cpu_set_t

  # ~/Nim/tinyc/include/stdarg.h
  var va_list_o: va_list 

  # cDecStructs lib/librte_lpm/rte_lpm6.c
  var rte_lpm6_o: rte_lpm6

  # cDecStructs lib/librte_eal/common/malloc_elem.h
  var malloc_elem_o: malloc_elem

  # lib/librte_pipeline/rte_pipeline.c
  var rte_pipeline_o: rte_pipeline

  # lib/librte_reorder/rte_reorder.c
  var rte_reorder_buffer_o: rte_reorder_buffer
  
  type
    my_t = object
      b*: array[16, char]

  echo " sizeof(int64) = ", sizeof(int64),
    ", sizeof(int32) = ", sizeof(int32),
    ", sizeof(int16) = ", sizeof(int16),
    ", sizeof(int8) = ", sizeof(int8)

  echo "sizeof(o.x) = ", sizeof(o.x), " ",
    sizeof(o.u8), " ", 
    sizeof(o.u16), " ",
    sizeof(o.u32), " ",
    sizeof(o.u64), " ",
    sizeof(o.pd), "\n"
    
  var mbuf_pool: rte_mempool
  var port_conf_default: rte_eth_conf
  var rte_mbuf_o: rte_mbuf
  var add_o: ether_addr
  var rte_eth_dev_o: rte_ethdev

  echo "sizeof(mbuf_pool) = ", sizeof(mbuf_pool),
    ", sizeof(port_conf_default) = ", sizeof(port_conf_default),
    ", sizeof(rte_mbuf_o) = ", sizeof(rte_mbuf_o),
    ", sizeof(add_o) = ", sizeof(add_o),
    ", sizeof(rte_ethdev_o) = ", sizeof(rte_ethdev_o)

  echo "\n"

when isMainModule:

  test()

