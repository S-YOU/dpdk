const
  CFG_NAME_LEN* = 64
  CFG_VALUE_LEN* = 256

type
#  start lib/librte_cfgfile/rte_cfgfile.c
  rte_cfgfile_section* {.importc: "struct rte_cfgfile_section", header: "cDecStructs.h".} = object
    name*: array[CFG_NAME_LEN, char]
    num_entries*: cint
    entries*: array[0, ptr rte_cfgfile_entry]

  rte_cfgfile* {.importc: "struct rte_cfgfile", header: "cDecStructs.h".} = object 
    flags*: cint
    num_sections*: cint
    sections*: array[0, ptr rte_cfgfile_section]
#  end lib/librte_cfgfile/rte_cfgfile.c

  rte_cfgfile_entry* {.importc: "struct rte_cfgfile_entry", header: "rte_cfgfile.h".} = object
    name*: array[64, char]
    value*: array[256, char]


proc rte_cfgfile_load*(filename: cstring; flags: cint): ptr rte_cfgfile {.importc, header: "rte_cfgfile.h".}
proc rte_cfgfile_num_sections*(cfg: ptr rte_cfgfile; sec_name: cstring; length: csize): cint {.importc, header: "rte_cfgfile.h".}
proc rte_cfgfile_sections*(cfg: ptr rte_cfgfile; sections: ptr cstring;
                          max_sections: cint): cint {.importc, header: "rte_cfgfile.h".}
proc rte_cfgfile_has_section*(cfg: ptr rte_cfgfile; sectionname: cstring): cint {.importc, header: "rte_cfgfile.h".}
proc rte_cfgfile_section_num_entries*(cfg: ptr rte_cfgfile; sectionname: cstring): cint {.importc, header: "rte_cfgfile.h".}
proc rte_cfgfile_section_entries*(cfg: ptr rte_cfgfile; sectionname: cstring;
                                 entries: ptr rte_cfgfile_entry; max_entries: cint): cint {.importc, header: "rte_cfgfile.h".}
proc rte_cfgfile_section_entries_by_index*(cfg: ptr rte_cfgfile; index: cint;
    sectionname: cstring; entries: ptr rte_cfgfile_entry; max_entries: cint): cint {.importc, header: "rte_cfgfile.h".}
proc rte_cfgfile_get_entry*(cfg: ptr rte_cfgfile; sectionname: cstring;
                           entryname: cstring): cstring {.importc, header: "rte_cfgfile.h".}
proc rte_cfgfile_has_entry*(cfg: ptr rte_cfgfile; sectionname: cstring;
                           entryname: cstring): cint {.importc, header: "rte_cfgfile.h".}
proc rte_cfgfile_close*(cfg: ptr rte_cfgfile): cint {.importc, header: "rte_cfgfile.h".}
