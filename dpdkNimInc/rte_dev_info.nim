type
  rte_dev_reg_info* {.importc: "struct rte_dev_reg_info", header: "rte_dev_info.h".} = object
    data*: pointer
    offset*: uint32
    length*: uint32
    width*: uint32
    version*: uint32

  rte_dev_eeprom_info* {.importc: "struct rte_dev_eeprom_info", header: "rte_dev_info.h".} = object
    data*: pointer
    offset*: uint32
    length*: uint32
    magic*: uint32

