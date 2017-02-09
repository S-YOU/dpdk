type
  rte_intr_callback_fn* = proc (intr_handle: ptr rte_intr_handle; cb_arg: pointer) {.cdecl.}
  rte_intr_handle_type* = enum
    RTE_INTR_HANDLE_UNKNOWN = 0, RTE_INTR_HANDLE_UIO, RTE_INTR_HANDLE_UIO_INTX,
    RTE_INTR_HANDLE_VFIO_LEGACY, RTE_INTR_HANDLE_VFIO_MSI,
    RTE_INTR_HANDLE_VFIO_MSIX, RTE_INTR_HANDLE_ALARM, RTE_INTR_HANDLE_EXT,
    RTE_INTR_HANDLE_MAX

  rte_intr_event_cb_t* = proc (fd: cint; arg: pointer) {.cdecl.}
  rte_epoll_data* {.importc: "struct rte_epoll_data", header: "rte_interrupts.h".} = object
    event*: uint32
    data*: pointer
    cb_fun*: rte_intr_event_cb_t
    cb_arg*: pointer

  rte_epoll_event* {.importc: "struct rte_epoll_event", header: "rte_interrupts.h".} = object
    status*: uint32
    fd*: cint
    epfd*: cint
    epdata*: rte_epoll_data

  INNER_C_UNION_2687080802* = object {.union.}
    vfio_dev_fd*: cint
    uio_cfg_fd*: cint

  rte_intr_handle* {.importc: "struct rte_intr_handle", header: "rte_interrupts.h".} = object
    ano_2703603810*: INNER_C_UNION_2687080802
    fd*: cint
    `type`*: rte_intr_handle_type
    max_intr*: uint32
    nb_efd*: uint32
    efds*: array[32, cint]
    elist*: array[32, rte_epoll_event]
    intr_vec*: ptr cint

const
  RTE_EPOLL_INVALID* = 0
  RTE_EPOLL_VALID* = 1
  RTE_EPOLL_EXEC* = 2

proc rte_epoll_wait*(epfd: cint; events: ptr rte_epoll_event; maxevents: cint;
                    timeout: cint): cint {.importc, header: "rte_interrupts.h".}
proc rte_epoll_ctl*(epfd: cint; op: cint; fd: cint; event: ptr rte_epoll_event): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_tls_epfd*(): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_rx_ctl*(intr_handle: ptr rte_intr_handle; epfd: cint; op: cint;
                     vec: cuint; data: pointer): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_efd_enable*(intr_handle: ptr rte_intr_handle; nb_efd: uint32): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_efd_disable*(intr_handle: ptr rte_intr_handle) {.importc, header: "rte_interrupts.h".}
proc rte_intr_dp_is_en*(intr_handle: ptr rte_intr_handle): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_allow_others*(intr_handle: ptr rte_intr_handle): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_cap_multiple*(intr_handle: ptr rte_intr_handle): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_callback_register*(intr_handle: ptr rte_intr_handle;
                                cb: rte_intr_callback_fn; cb_arg: pointer): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_callback_unregister*(intr_handle: ptr rte_intr_handle;
                                  cb: rte_intr_callback_fn; cb_arg: pointer): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_enable*(intr_handle: ptr rte_intr_handle): cint {.importc, header: "rte_interrupts.h".}
proc rte_intr_disable*(intr_handle: ptr rte_intr_handle): cint {.importc, header: "rte_interrupts.h".}
