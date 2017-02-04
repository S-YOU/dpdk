const
  CHAR_BIT* = 8
  EXIT_FAILURE* = 1
  UINT8_MAX* = 255

type
  off_t* = int
  timespec* = object
    tv_sec*: int64
    tv_nsec*: int64

template builtin_expect*(x: untyped, y: int): int =
  return x == y

# /usr/include/netinet/in.h
type
  in_addr_t* = uint32
  in_addr* {.importc: "struct in_addr", header: "in.h".} = object
    s_addr*: in_addr_t

  in6_addr* {.importc: "struct in6_addr", header: "in.h".} = object
   u6_addr8*: array[16, uint8]

