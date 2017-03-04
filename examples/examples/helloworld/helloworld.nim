# -
##    BSD LICENSE
## 
##    Copyright(c) 2010-2014 Intel Corporation. All rights reserved.
##    All rights reserved.
## 
##    Redistribution and use in source and binary forms, with or without
##    modification, are permitted provided that the following conditions
##    are met:
## 
##      * Redistributions of source code must retain the above copyright
##        notice, this list of conditions and the following disclaimer.
##      * Redistributions in binary form must reproduce the above copyright
##        notice, this list of conditions and the following disclaimer in
##        the documentation and/or other materials provided with the
##        distribution.
##      * Neither the name of Intel Corporation nor the names of its
##        contributors may be used to endorse or promote products derived
##        from this software without specific prior written permission.
## 
##    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
##    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
##    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
##    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
##    OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
##    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
##    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
##    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
##    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
##    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
##    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
## 

import os

import "dpdk"

# To do the work of rte_panic from rte_debug.h.
# a. Print stack trace
# b. Abort
proc panic(str: string) =
  writeStackTrace()
  quit str

# declare the C prototype in Nim and export to c (exportc) and call it as a normal C function (cdecl)
proc lcore_hello(a2: pointer): cint {.exportc: "lcore_hello", cdecl.} =
  var lcore_id: cuint
  lcore_id = rte_lcore_id()
  echo "hello from core ", lcore_id
  return 0

proc go(argc: cint; argv: cstringArray): cint =
  var ret: cint

  ret = rte_eal_init(argc, argv);
  if ret < 0:
    panic("Cannot init EAL\n");
  else:
    echo "rte_eal_init() ok"

  ret = rte_eal_mp_remote_launch(cast[ptr lcore_function_t](lcore_hello), nil, CALL_MASTER);

  if ret < 0:
    panic("rte_eal_mp_remote_launch() failed\n")
  else:
    echo "rte_eal_mp_remote_launch() ok"

  # call it on master lcore too 
  ret = lcore_hello(nil)

  rte_eal_mp_wait_lcore()

when isMainModule:

  var argc: int = paramCount() + 1

  var argv: cstringArray = allocCStringArray(["dummy"])

  var i = 0
  while i < argc:
    argv[i] = paramStr(i)
    inc(i)

  var ret: cint = go(argc.cint, argv)

  deallocCStringArray(argv)
