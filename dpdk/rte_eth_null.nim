proc eth_dev_null_create*(name: cstring; numa_node: cuint; packet_size: cuint;
                         packet_copy: cuint): cint {.importc, header: "rte_eth_null.h".}
