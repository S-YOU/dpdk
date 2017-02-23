#!/usr/bin/env bash

# check if dpdk is already installed
dir1="/usr/local/include/dpdk"
dir2="/usr/local/share/dpdk"

if [ -d $dir1 ] &&
   [ -d $dir2 ]; then
  
  echo -e "Deleting directories $dir1 and $dir2\n"
  echo "Please enter your sudo password";
  read -s PASS

# partial command
  cmd="cd /usr/local/share"
  echo -e "\n$cmd"; eval $cmd

  cmd="rm -rf ./dpdk/"
# full command
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e "\n$cmd"; eval $f_cmd

  cmd="cd /usr/local/include"
  echo -e "\n$cmd"; eval $cmd

  cmd="rm -rf ./dpdk/"
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e "\n$cmd"; eval $f_cmd

  echo "uninstalling librte_error_wrapper.a"
  cmd="rm /usr/local/lib/librte_error_wrapper.a"
  f_cmd="echo $PASS | sudo -S $cmd"
  echo -e "\n$cmd"; eval $f_cmd

else

 echo -e "it appears that C dpdk has not been installed here:\n"
 echo -e "\t$dir1\n\t$dir2\n"
 echo -e "\nSkipping uninstallation.\n"
fi

