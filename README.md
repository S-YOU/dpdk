# Nim DPDK dpdk-stable-16.07.2 Bindings

This guide will aim to show how to setup a test bed for developing Nim DPDK applications.

Tested on Ubuntu 16.04.1 as a guest operating system (OS) using Virtualbox.

## Explanation of Directories

1. dpdk - DPDK Nim include files. These are the Nim API to the C DPDK library. 

2. rteErrorWrapper - There is a `rte_error_wrapper.nim` file which allows Nim to get the C DPDK rte_errno variable via the procedure get_rte_errno() using the archive file rte_error_wrapper.a. This has the Nim prototype:

	`proc get_rte_errno*(): cint {.importc, header: "rte_error_wrapper.h".}`

3. extraHdrs/cDecStructs.h - These are extra headers that were made to include the structs that are declared in the DPDK C files that were referenced by the DPDK header files. These are referenced by the files in `dpdk` using Nim pragmas.

4. examples/examples - Example Nim versions of the DPDK helloworld and rxtx_callbacks examples. Please look here to see how to call the Nim DPDK API.

5. examples/C_Examples - Modified versions of the original DPDK C examples. This currently has the C rxtx_callbacks example modified to time the average packet latencies.

6. dpdk.nimble - file to be used by nimble. `nimble install dpdk' will install both C DPDK and Nim bindings. `nimble uninstall dpdk` will uninstall both C DPDK and Nim bindings.

7. instC_DPDK.sh - bash script used by dpdk.nimble to automatically install the C DPDK library.

8. uninstC_DPDK.sh - bash script used by dpdk.nimble to automatically uninstall the C DPDK library.

9. logs - Currently has logs comparing the average packet latencies between the DPDK C and Nim versions of rxtx_callbacks. 

10. tests - to test if extraHdrs/cDecStructs.h can be used by Nim.

11. makeDPDKNim.sh - Bash script to save you time building a Nim DPDK project. Used with nim.cfg, it is uses gcc switches used by the DPDK Makefiles plus some extras.

12. nim.cfg - place in your projects directory to use the gcc switches used by the DPDK Makefiles. Invoke makeDPDKNim.sh to compile your project.

## Getting started

### Prepare Your Development Environment
VirtualBox with Linux is a good testiing / development environment for DPDK. DPDK requires two network interface cards (NIC) and VirtualBox allows virtualization of them without having to purchase any new hardware.

VirtualBox with Ubuntu 16.04 as guest (OS) was the test environment used.

Here are the references:

http://plvision.eu/blog/deploying-intel-dpdk-in-oracle-VirtualBox/

http://dpdk.org/doc/quick-start

  1. Check for hardware virtualization on host OS.

    Intel VT-x

    `$ grep vmx /proc/cpuinfo`

    AMD SVM

    `$ grep svm /proc/cpuinfo`

    If you don't see any output, you need to enable them through the BIOS.

    [ref: https://www.cyberciti.biz/faq/linux-xen-vmware-kvm-intel-vt-amd-v-support/]

  2. Check for CPU SSE flags (SSE 4.1 / SSE 4.2) on host

    `$ grep sse4 /proc/cpuinfo`

    If you don't see any output, you need to find out how to turn them on for your host OS.

  3. Find out your host's OS NIC name (tested to work with wired Ethernet).

    ```
    $ ip addr
    2: enp0s25
    [ output ommitted ]
    ```
  4. Install VirtualBox.
  5. Install Ubuntu as guest OS in VirtualBox.
  6. In VirtualBox enable two bridged NIC in the Ubuntu virtual machine (VM). Bridge to your host's NIC (eg. enp0s25). To do this goto:

    ```
    Settings > Network > Adapter 1 > 
      Attached to: Bridged Adapter
      Name: enp0s25
      Adaptor Type: Intel Pro/1000 MT Desktop (82540EM)
    ```

    Create a second NIC using Adapter 2 and use the same settings as for the first NIC:

    ```
    Settings > Network > Adapter 2 > 
      Attached to: Bridged Adapter
      Name: enp0s25
      Adaptor Type: Intel Pro/1000 MT Desktop (82540EM)
    ```

  7. Enable SSE CPU flags for the guest VM. Shutdown the guest VM then on the host issue: 

    `$ VBoxManage setextradata "ubt1604" VBoxInternal/CPUM/SSE4.1 1`
    
    To test:
    
    `$ VBoxManage getextradata "ubt1604" VBoxInternal/CPUM/SSE4.1`
    
    Restart the guest VM

  8. In the virtual machine make sure your environment has two Ethernet devices. 

    ```
    $ ip addr
    2: enp0s3: 
      [ more output ommitted ]
    3: enp0s8: 
      [ more output ommitted ]
    ```


### Install DPDK on the Guest OS
These steps should be done on the guest VM with two NIC setup.

  1. Download required utilities and install C DPDK.

    This step will be automated by nimble.

    `$ nimble install dpdk`

    This will install both C DPDK library and the Nim DPDK bindings.

    If you want to know what nimble does please read below, otherwise please skip to the next step (Export environment variables). 

    nimble will invoke this:

    `$ ./instC_DPDK.sh`

    The script will perform the following:

    1. Download required utilities

      ```
      $ sudo apt-get install libpcap-dev gcc make hugepages nim
      $ sudo apt-get linux-headers-generic
      ```	

    2. Download DPDK, untar and

      ```
      $ make config T=x86_64-native-linuxapp-gcc
      $ sed -ri 's,(PMD_PCAP=).*,\1y,' build/.config
      $ make -j2
      $ sudo make install
      ```

    DPDK include headers are:
    `/usr/local/include/dpdk/`

    DPDK Examples are:
    `/usr/local/share/dpdk/Examples`

  2. Export environment variables to `~/.bashrc`
    ```
    export RTE_SDK=/usr/local/share/dpdk/
    export RTE_TARGET=x86_64-native-linuxapp-gcc
    ```
    Exit your shell and restart to source changes.

  3. Enable hugepages:

     ```
     $ sudo mkdir -p /mnt/huge
     $ sudo mount -t hugetlbfs nodev /mnt/huge
    `$ sudo sh -c 'echo 64 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages'`
     ```

    Test:

    `$ cat /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages'`

  4. Test with a DPDK example:

    ```
    $ mkdir ~/helloworld
    $ cp -r /usr/local/share/dpdk/examples/helloworld/* ~/helloworld
    $ cd ~/helloworld
    $ make 
    ```
    Can use the -j switch to make to invoke multicore use.
    ```
    $ cd build
    $ sudo ./helloworld -c 3 -n 1
    [sudo] password for ubuntu:
    EAL: Detected 2 lcore(s)
    EAL: Probing VFIO support...
    EAL: WARNING: cpu flags constant_tsc=yes nonstop_tsc=no -> using unreliable clock cycles !
    PMD: bnxt_rte_pmd_init() called for (null)
    EAL: PCI device 0000:00:03.0 on NUMA socket -1
    EAL:   probe driver: 8086:100e rte_em_pmd
    EAL: PCI device 0000:00:08.0 on NUMA socket -1
    EAL:   probe driver: 8086:100e rte_em_pmd
    hello from core 1
    hello from core 0
    ```
    To see the switches help, use:
    `$ ./helloworld --help`

### Using Nim DPDK Bindings

  1. Copy nim.cfg to your project directory.

  2. Open nim.cfg in a text editor. 

  3. For release builds, set -O3 to gcc and -d:release flags to Nim.

    ```
    # User configurable variables start
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    # gcc Debugging flags for easier development, leave blank for production or use -O3
    # For development set "-g3 -g"
    # For release set     "-O3"
    gcc.options.speed="-O3" # release
    
    # Nim flags
    # For development set ""
    # for release set     "-d:release"
    -d:release
    
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # User configurable paths end

    ```


  4. Allow Easy Access to makeDPDKNim.sh
    You can leave `makeDPDKNim.sh` where it is, copy it to your project directory or if you prefer access from anywhere, export it in `~/.bashrc`

    export PATH="~/.nimble/pkgs/dpdk-0.1.0:$PATH"

    Exit your shell and restart to source changes.

### How to Build Nim Examples
The Nim examples uses the Nim DPDK bindings.

#### Nim DPDK helloworld
  1. Create a directory

    ```
    $ mkdir test
    $ cd test
    ```
    
  2. Copy the DPDK helloworld example.

    `$ cp ~/.nimble/pkgs/dpdk-0.1.0/examples/examples/helloworld/helloworld.nim ./`

  3. Copy nim.cfg 

    `$ cp ~/.nimble/pkgs/dpdk-0.1.0/nim.cfg ./`

  2. Invoke the makeDPDKNim.sh build script.

    `$ makeDPDKNim.sh helloworld.nim`

    If makeDPDKNim.sh was not copied to a globally accessible PATH directory, you need to invoke it using it's absolute path.

  3. Test:
    ```
    $ sudo ./helloworld -c 3 -n 1 
    [sudo] password for ubuntu: 
    EAL: Detected 2 lcore(s)
    EAL: Probing VFIO support...
    EAL: WARNING: cpu flags constant_tsc=yes nonstop_tsc=no -> using unreliable clock cycles !
    PMD: bnxt_rte_pmd_init() called for (null)
    EAL: PCI device 0000:00:03.0 on NUMA socket -1
    EAL:   probe driver: 8086:100e rte_em_pmd
    EAL: PCI device 0000:00:08.0 on NUMA socket -1
    EAL:   probe driver: 8086:100e rte_em_pmd
    rte_eal_init() ok
    hello from core 1
    hello from core 0
    rte_eal_mp_remote_launch() ok
    hello from core 0
    ```

#### Nim DPDK rxtx_callbacks
```
$ mkdir test
$ cd test
$ cp ~/.nimble/pkgs/dpdk-0.1.0/examples/dpdkNimExamples/rxtx_callbacks/rxtx_callbacks.nim ./
$ cp ~/.nimble/pkgs/dpdk-0.1.0/nim.cfg ./
$ makeDPDKNim.sh rxtx_callbacks.nim
$ sudo ./rxtx_callbacks -c 1 -n 1 --vdev=eth_pcap0,iface=enp0s3 --vdev=eth_pcap1,iface=enp0s8
EAL: Detected 2 lcore(s)
EAL: Probing VFIO support...
EAL: WARNING: cpu flags constant_tsc=yes nonstop_tsc=no -> using unreliable clock cycles !
PMD: Initializing pmd_pcap for eth_pcap0
PMD: Creating pcap-backed ethdev on numa socket 0
PMD: Initializing pmd_pcap for eth_pcap1
PMD: Creating pcap-backed ethdev on numa socket 0
PMD: bnxt_rte_pmd_init() called for (null)
EAL: PCI device 0000:00:03.0 on NUMA socket -1
EAL:   probe driver: 8086:100e rte_em_pmd
EAL: PCI device 0000:00:08.0 on NUMA socket -1
EAL:   probe driver: 8086:100e rte_em_pmd
rte_eal_init() ok
nb_ports = 2
rte_pktmbuf_pool_create() ok

port = 0 rx_rings = 1
Port 0 MAC: 00 00 00 01 02 03
port = 1 rx_rings = 1
Port 1 MAC: 00 00 00 01 02 03

Core 0 forwarding packets. [Ctrl+C to quit]

^CTraceback (most recent call last)
rxtx_callbacks.nim(286)  rxtx_callbacks
rxtx_callbacks.nim(270)  go
rxtx_callbacks.nim(199)  lcore_main
SIGINT: Interrupted by Ctrl-C.
```
As for the warning during compilation.

`rxtx_callbacks.nim(50, 5) Warning: Cannot prove that 'port_conf_default' is initialized. This will become a compile time error in the future. [ProveInit]`

I am not sure how to get rid of this.

Enjoy!

### Testing in Isolated Network (for Performance Testing)

To enable testing in an isolated network, for the VirtualBox two NIC settings:

```
	Settings > Network > Adapter 2 > 
		Attached to: Internal Network
```

This will simulate your private isolated network with no network noise.

The results are seconds for 1000,000 packets

C rxtx_callbacks 

```
188
74
55
49
43
43
```

Nim rxtx_callbacks (with "-d:release")

```
259
68
51
48
45
```

So they are pretty close at steady state (43 s for C and 45 s for Nim), in an isolated (no external traffic) network

### Uninstalling C DPDK and Nim DPDK
Easiest way is to use nimble

`$ nimble uninstall dpdk`

This will uninstall both C DPDK and Nim DPDK bindings.

The script `./uninstC_DPDK.sh` will uninstall the C DPDK library.



