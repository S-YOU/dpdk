type
  rte_dev_reg_info* = object
    data*: pointer
    offset*: uint32
    length*: uint32
    width*: uint32
    version*: uint32

  rte_dev_eeprom_info* = object
    data*: pointer
    offset*: uint32
    length*: uint32
    magic*: uint32

