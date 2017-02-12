#!/usr/bin/env bash

# check if dpdk is already installed
dir1="/usr/local/include/dpdk"
dir2="/usr/local/share/dpdk"

if [ -d $dir1 ] &&
   [ -d $dir2 ]; then

   echo -e "it appears that a version of C dpdk exists already here:\n"
   echo -e "\t$dir1\n\t$dir2\n"
   echo -e "\nPlease uninstall dpdk first. Skipping installation.\n"

else

  echo "Please enter your sudo password";
  read -s PASS

# partial command
  cmd="apt-get -y install apt-file"
# full command
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e $cmd; eval $f_cmd

  cmd="apt-get -y update"
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e $cmd; eval $f_cmd

  cmd="apt-get -y upgrade"
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e $cmd; eval $f_cmd

  cmd="apt-get -y dist-upgrade"
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e "\n$cmd"; eval $f_cmd

  cmd="apt-get -y autoremove --purge"
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e "\n$cmd"; eval $f_cmd

  cmd="apt-get -y install libpcap-dev gcc make hugepages linux-headers-generic wget"
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e "\n$cmd"; eval $f_cmd

  dpdk_tarball="dpdk-16.07.2.tar.xz"
  if [ -f $dpdk_tarball ]; then
    echo -e "$dpdk_tarball already exists, continuing...\n"
  else
    cmd="wget http://fast.dpdk.org/rel/$dpdk_tarball"
    echo -e "\n$cmd"; eval $cmd
  fi

  cmd="tar -xvf $dpdk_tarball"
  echo -e "\n$cmd"; eval $cmd

  cmd="cd dpdk-stable-16.07.2"
  echo -e "\n$cmd"; eval $cmd

  cmd="make config T=x86_64-native-linuxapp-gcc"
  echo -e "\n$cmd"; eval $cmd

  cmd="sed -ri 's,(PMD_PCAP=).*,\1y,' build/.config"
  echo -e "\n$cmd"; eval $cmd

  num_cores=$(grep -c ^processor /proc/cpuinfo)
  cmd="make -j$num_cores"
  echo -e "\n$cmd"; eval $cmd

  cmd="make install"
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e "\n$cmd"; eval $f_cmd

  echo -e "dpdk-stable-16.07.2 has been installed here:\n"
  echo -e "\t$dir1\n\t$dir2\n"

fi

