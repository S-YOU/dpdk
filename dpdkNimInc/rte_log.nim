type
  rte_logs* = object
    `type`*: uint32
    level*: uint32
    file*: ptr FILE

const
  RTE_LOGTYPE_EAL* = 0x00000001
  RTE_LOGTYPE_MALLOC* = 0x00000002
  RTE_LOGTYPE_RING* = 0x00000004
  RTE_LOGTYPE_MEMPOOL* = 0x00000008
  RTE_LOGTYPE_TIMER* = 0x00000010
  RTE_LOGTYPE_PMD* = 0x00000020
  RTE_LOGTYPE_HASH* = 0x00000040
  RTE_LOGTYPE_LPM* = 0x00000080
  RTE_LOGTYPE_KNI* = 0x00000100
  RTE_LOGTYPE_ACL* = 0x00000200
  RTE_LOGTYPE_POWER* = 0x00000400
  RTE_LOGTYPE_METER* = 0x00000800
  RTE_LOGTYPE_SCHED* = 0x00001000
  RTE_LOGTYPE_PORT* = 0x00002000
  RTE_LOGTYPE_TABLE* = 0x00004000
  RTE_LOGTYPE_PIPELINE* = 0x00008000
  RTE_LOGTYPE_MBUF* = 0x00010000
  RTE_LOGTYPE_CRYPTODEV* = 0x00020000


const
  RTE_LOGTYPE_USER1* = 0x01000000
  RTE_LOGTYPE_USER2* = 0x02000000
  RTE_LOGTYPE_USER3* = 0x04000000
  RTE_LOGTYPE_USER4* = 0x08000000
  RTE_LOGTYPE_USER5* = 0x10000000
  RTE_LOGTYPE_USER6* = 0x20000000
  RTE_LOGTYPE_USER7* = 0x40000000
  RTE_LOGTYPE_USER8* = 0x80000000

const
  RTE_LOG_EMERG* = 1
  RTE_LOG_ALERT* = 2
  RTE_LOG_CRIT* = 3
  RTE_LOG_ERR* = 4
  RTE_LOG_WARNING* = 5
  RTE_LOG_NOTICE* = 6
  RTE_LOG_INFO* = 7
  RTE_LOG_DEBUG* = 8


type                     
  INNER_C_UNION_2963461344* = object {.union.}
    overflow_offset*: cuint
    overflow_arg_area*: cstring
                                     
  va_list_struct* = object
    gp_offset*: cuint
    fp_offset*: cuint   
    ano_1946648541*: INNER_C_UNION_2963461344
    reg_save_area*: cstring
                                         
  va_list* = ptr va_list_struct

proc rte_openlog_stream*(f: ptr FILE): cint {.importc, header: "rte_log.h".}
proc rte_set_log_level*(level: uint32) {.importc, header: "rte_log.h".}
proc rte_get_log_level*(): uint32 {.importc, header: "rte_log.h".}
proc rte_set_log_type*(`type`: uint32; enable: cint) {.importc, header: "rte_log.h".}
proc rte_get_log_type*(): uint32 {.importc, header: "rte_log.h".}
proc rte_log_cur_msg_loglevel*(): cint {.importc, header: "rte_log.h".}
proc rte_log_cur_msg_logtype*(): cint {.importc, header: "rte_log.h".}
proc rte_log_set_history*(enable: cint) {.importc, header: "rte_log.h".}
proc rte_log_dump_history*(f: ptr FILE) {.importc, header: "rte_log.h".}
proc rte_log_add_in_history*(buf: cstring; size: csize): cint {.importc, header: "rte_log.h".}
proc rte_log*(level: uint32; logtype: uint32; format: cstring): cint {.varargs, importc, header: "rte_log.h".}
proc rte_vlog*(level: uint32; logtype: uint32; format: cstring; ap: va_list): cint {.importc, header: "rte_log.h".}
