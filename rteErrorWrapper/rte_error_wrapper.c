#include <rte_errno.h>
#include "rte_error_wrapper.h"

/**
 * wrapper to return rte_errno
 * @return
 *  rte_errno
 */
int get_rte_errno() {
  return rte_errno;
}
