include "extra.nim"

include "rte_log.nim"
include "rte_config.nim"
include "rte_udp.nim"

include "generic/rte_atomic.nim"

include "rte_memory.nim"
include "rte_memzone.nim"
include "rte_ring.nim"

include "generic/rte_spinlock.nim"
include "rte_spinlock.nim"
include "rte_mempool.nim"

include "rte_mbuf.nim"
include "rte_distributor.nim"
include "rte_ether.nim"

include "rte_eth_ctrl.nim"
include "rte_interrupts.nim"

include "rte_pci.nim"
# rte_pci.nim now includes rte_devargs.nim

include "rte_dev_info.nim"
include "rte_ethdev.nim"

include "rte_cycles.nim"
include "generic/rte_cycles.nim"

include "rte_launch.nim"

include "rte_lcore.nim"
include "rte_branch_prediction.nim"

include "rte_malloc_heap.nim"
include "rte_tailq.nim"
include "generic/rte_rwlock.nim"
include "rte_rwlock.nim"
include "rte_eal_memconfig.nim"
include "rte_eal.nim"

include "rte_common.nim"

include "rte_errno.nim"
include "cmdline_cirbuf.nim"
include "cmdline_parse.nim"
include "cmdline_parse_etheraddr.nim"
include "cmdline_parse_ipaddr.nim"
include "cmdline_parse_num.nim"
include "cmdline_parse_portlist.nim"
include "cmdline_parse_string.nim"
include "cmdline_vt100.nim"
include "cmdline_rdline.nim"
include "cmdline_socket.nim"
include "rte_vect.nim"

include "rte_acl.nim"
#rte_acl.nim contains defitions from lib/librte_acl/acl.h

include "rte_alarm.nim"
include "rte_approx.nim"
include "rte_arp.nim"
include "rte_bitmap.nim"
include "rte_byteorder_64.nim"
include "rte_cfgfile.nim"

# includes generic/rte_cpuflags.h
include "rte_cpuflags.nim"
include "rte_dev.nim"

include "rte_cryptodev_pmd.nim"
#rte_cryptodev_pmd.nim now includes rte_cryptodev.nim, rte_crypto_sym.nim, rte_crypto.nim

include "rte_debug.nim"
include "rte_eth_bond_8023ad.nim"
include "rte_eth_bond.nim"
include "rte_eth_null.nim"
include "rte_eth_ring.nim"
include "rte_eth_vhost.nim"
include "rte_fbk_hash.nim"
include "rte_hash_crc.nim"
include "rte_hash.nim"
include "rte_hexdump.nim"
include "rte_icmp.nim"
include "rte_ip.nim"
include "rte_ip_frag.nim"
include "rte_jhash.nim"
include "rte_jobstats.nim"
include "rte_keepalive.nim"
include "exec-env/rte_kni_common.nim"
include "rte_kni.nim"
include "rte_kvargs.nim"
include "rte_lpm6.nim"
include "rte_lpm.nim"
include "rte_lpm_sse.nim"
include "rte_malloc.nim"
include "rte_memcpy.nim"
include "generic/rte_memcpy.nim"
include "rte_meter.nim"
include "rte_pci_dev_feature_defs.nim"
include "rte_pci_dev_features.nim"
include "rte_pci_dev_ids.nim"
include "rte_pdump.nim"
include "rte_port.nim"
include "rte_table.nim"
include "rte_pipeline.nim"
include "rte_port_ethdev.nim"
include "rte_port_frag.nim"
include "rte_port_kni.nim"
include "rte_port_ras.nim"
include "rte_port_ring.nim"
include "rte_red.nim"
include "rte_reciprocal.nim"

include "rte_sched.nim"
include "rte_port_sched.nim"

include "rte_port_source_sink.nim"
include "rte_power.nim"

# use rte_prefetch.nim as they're declared there instead of from generic
include "rte_prefetch.nim"

include "rte_random.nim"
include "rte_reorder.nim"
include "rte_rtm.nim"
include "rte_sched_common.nim"
include "rte_sctp.nim"
include "rte_string_fns.nim"
include "rte_table_acl.nim"
include "rte_table_array.nim"
include "rte_table_hash.nim"
include "rte_table_lpm_ipv6.nim"
include "rte_table_lpm.nim"
include "rte_tcp.nim"
include "rte_thash.nim"
include "rte_time.nim"
include "rte_timer.nim"
include "rte_version.nim"
include "rte_virtio_net.nim"
include "generic/rte_byteorder.nim"

include "exec-env/rte_dom0_common.nim"

# rte_error wrapper
include "rte_error_wrapper.nim"



