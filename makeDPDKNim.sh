#!/usr/bin/env bash

# Dear user, please edit dpdk_nim_dir and rte_error_wrapper_dir before first use

# User configurable paths start
################################
# directory containing DPDK Nim include files 
dpdk_nim_dir="/home/ubuntu/ukso/dpdk/nimdpdk/dpdkNimInc/"
# direcotry containing rte_errno wrapper archive
rte_error_wrapper_dir="/home/ubuntu/ukso/dpdk/nimdpdk/rteErrorWrapper"
###############################
# User configurable paths end


dpdk_nim_path="--path:$dpdk_nim_dir"
rte_error_compile_options="--cincludes:$rte_error_wrapper_dir" 

# The below variables were made like this.
# 1. use make -n on original DPDK examples to see what flags are used
# 2. use ldd on original DPDK executable and your Nim DPDK executable to see
# if the .so files match
rte_error_link_file="$rte_error_wrapper_dir/rte_error_wrapper.a"

c_compiler_options="-g -m64 -pthread  -march=native -DRTE_MACHINE_CPUFLAG_SSE -DRTE_MACHINE_CPUFLAG_SSE2 -DRTE_MACHINE_CPUFLAG_SSE3 -DRTE_MACHINE_CPUFLAG_SSSE3 -DRTE_MACHINE_CPUFLAG_SSE4_1 -I/usr/local/share/dpdk//x86_64-native-linuxapp-gcc/include -include /usr/local/share/dpdk//x86_64-native-linuxapp-gcc/include/rte_config.h -O3 -W -Wall -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wold-style-definition -Wpointer-arith -Wcast-align -Wnested-externs -Wcast-qual -Wformat-nonliteral -Wformat-security -Wundef -Wwrite-strings"

linker_options="$rte_error_link_file -L/usr/local/share/dpdk//x86_64-native-linuxapp-gcc/lib -Wl,-lrte_kni -Wl,-lrte_pipeline -Wl,-lrte_table -Wl,-lrte_port -Wl,-lrte_pdump -Wl,-lrte_distributor -Wl,-lrte_reorder -Wl,-lrte_ip_frag -Wl,-lrte_meter -Wl,-lrte_sched -Wl,-lrte_lpm -Wl,--whole-archive -Wl,-lrte_acl -Wl,--no-whole-archive -Wl,-lrte_jobstats -Wl,-lrte_power -Wl,--whole-archive -Wl,-lrte_timer -Wl,-lrte_hash -Wl,-lrte_vhost -Wl,-lrte_kvargs -Wl,-lrte_mbuf -Wl,-lethdev -Wl,-lrte_cryptodev -Wl,-lrte_mempool -Wl,-lrte_ring -Wl,-lrte_eal -Wl,-lrte_cmdline -Wl,-lrte_cfgfile -Wl,-lrte_pmd_bond -Wl,-lrte_pmd_af_packet -Wl,-lrte_pmd_bnxt -Wl,-lrte_pmd_cxgbe -Wl,-lrte_pmd_e1000 -Wl,-lrte_pmd_ena -Wl,-lrte_pmd_enic -Wl,-lrte_pmd_fm10k -Wl,-lrte_pmd_i40e -Wl,-lrte_pmd_ixgbe -Wl,-lrte_pmd_null -Wl,-lrte_pmd_pcap -Wl,-lpcap -Wl,-lrte_pmd_ring -Wl,-lrte_pmd_virtio -Wl,-lrte_pmd_vhost -Wl,-lrte_pmd_vmxnet3_uio -Wl,-lrte_pmd_null_crypto -Wl,--no-whole-archive -Wl,-lrt -Wl,-lm -Wl,-ldl -Wl,-export-dynamic -Wl,-export-dynamic -L/usr/local/share/dpdk//x86_64-native-linuxapp-gcc/lib -Wl,--as-needed -Wl,-lpthread"

usage="usage: $0 nimFile1 [nimFile2] [nimFile3] ... "
msg="Dear user, please edit dpdk_nim_dir and rte_error_wrapper_dir before first use"

function dpdkNimCompile() {
  nim_files=$@
  cmd="nim c $dpdk_nim_path $rte_error_compile_options --passC:\"$c_compiler_options\" --passL:\"$linker_options\" $nim_files"
  echo $cmd
  eval $cmd
}

if [ "$#" == 0 ]; then
  echo $usage
  echo $msg
else
  dpdkNimCompile $@
fi

