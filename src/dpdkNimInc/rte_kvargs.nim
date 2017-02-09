const
  RTE_KVARGS_MAX* = 32
  RTE_KVARGS_PAIRS_DELIM* = ","
  RTE_KVARGS_KV_DELIM* = "="

type
  arg_handler_t* = proc (key: cstring; value: cstring; opaque: pointer): cint {.cdecl.}
  rte_kvargs_pair* {.importc: "struct rte_kvargs_pair", header: "rte_kvargs.h".} = object
    key*: cstring
    value*: cstring

  rte_kvargs* {.importc: "struct rte_kvargs", header: "rte_kvargs.h".} = object
    str*: cstring
    count*: cuint
    pairs*: array[32, rte_kvargs_pair]


proc rte_kvargs_parse*(args: cstring; valid_keys: ptr cstring): ptr rte_kvargs {.importc, header: "rte_kvargs.h".}
proc rte_kvargs_free*(kvlist: ptr rte_kvargs) {.importc, header: "rte_kvargs.h".}
proc rte_kvargs_process*(kvlist: ptr rte_kvargs; key_match: cstring;
                        handler: arg_handler_t; opaque_arg: pointer): cint {.importc, header: "rte_kvargs.h".}
proc rte_kvargs_count*(kvlist: ptr rte_kvargs; key_match: cstring): cuint {.importc, header: "rte_kvargs.h".}
