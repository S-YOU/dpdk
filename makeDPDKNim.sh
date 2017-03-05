#!/usr/bin/env bash

# directory containing the DPDK Nim directories dpdkNimInc, rteErrorWrapper and extraCHdrs4Nim
usr=$(whoami)
if [ "root" == $usr ]; then
  nim_src="/root/.nimble/pkgs/dpdk-0.1.0/"
else
  nim_src="/home/$(whoami)/.nimble/pkgs/dpdk-0.1.0/"
fi

# directory containing DPDK Nim include files
dpdk_nim_dir="$nim_src/dpdk/"

# direcotry containing rte_errno wrapper archive
rte_error_wrapper_dir="$nim_src/rteErrorWrapper"

# directory for C structs referenced by DPDK (used by files in dpdk_nim_dir)
extra_c_hdrs_4_nim_dir="$nim_src/extraHdrs"

dpdk_nim_path="--path:$dpdk_nim_dir"
rte_error_compile_options="--cincludes:$rte_error_wrapper_dir" 
extra_includes="--cincludes:$extra_c_hdrs_4_nim_dir" 

usage="usage: $0 nimFile1 [nimFile2] [nimFile3] ... "
msg="Dear user, please edit dpdk_nim_dir, rte_error_wrapper_dir extra_c_hdrs_4_nim_dir before first use"

function dpdkNimCompile() {
  nim_files=$@
  cmd="nim c $dpdk_nim_path $rte_error_compile_options $extra_includes $nim_files"
  echo $cmd
  eval $cmd
}

if [ "$#" == 0 ]; then
  echo $usage
  echo $msg
else
  dpdkNimCompile $@
fi

