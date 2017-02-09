#ifndef __CDECSTRUCTS_H_
#define __CDECSTRUCTS_H_

#include <sys/queue.h>

#include <rte_acl.h>
#include <rte_cfgfile.h>
#include <rte_distributor.h>
#include <rte_config.h>
#include <rte_mbuf.h>
#include <rte_hash.h>
#include <generic/rte_spinlock.h>
#include <rte_keepalive.h>
#include <exec-env/rte_kni_common.h>
#include <rte_mempool.h>
#include <rte_kni.h>
#include <rte_lpm6.h>
#include <rte_port.h>
#include <rte_pipeline.h>
#include <rte_mbuf.h>
#include <rte_reciprocal.h>
#include <rte_bitmap>
#include <rte_sched.h>

// start lib/librte_acl/acl.h
typedef int bits_t;
#define RTE_ACL_BIT_SET_SIZE  ((UINT8_MAX + 1) / (sizeof(bits_t) * CHAR_BIT))
#define RTE_ACL_QUAD_SIZE 4
#define RTE_ACL_DFA_SIZE (UINT8_MAX + 1)
#define RTE_ACL_DFA_GR64_SIZE 64
#define  RTE_ACL_DFA_GR64_NUM  (RTE_ACL_DFA_SIZE / RTE_ACL_DFA_GR64_SIZE)

#define RTE_ACL_MAX_TRIES 8

#define RTE_DISTRIB_MAX_WORKERS 64
#define RTE_DISTRIB_BACKLOG_SIZE 8
#define RTE_DISTRIB_MAX_RETURNS 128

struct rte_acl_bitset {
  bits_t             bits[RTE_ACL_BIT_SET_SIZE];
};


struct rte_acl_ptr_set {
  struct rte_acl_bitset values; /* input values associated with ptr */
  struct rte_acl_node  *ptr;  /* transition to next node */
};


struct rte_acl_match_results {
  uint32_t results[RTE_ACL_MAX_CATEGORIES];
  int32_t priority[RTE_ACL_MAX_CATEGORIES];
};

struct rte_acl_node {
  uint64_t node_index;  /* index for this node */
  uint32_t level;       /* level 0-n in the trie */
  uint32_t ref_count;   /* ref count for this node */
  struct rte_acl_bitset  values;
  /* set of all values that map to another node
   * (union of bits in each transition.
   */
  uint32_t                num_ptrs; /* number of ptr_set in use */
  uint32_t                max_ptrs; /* number of allocated ptr_set */
  uint32_t                min_add;  /* number of ptr_set per allocation */
  struct rte_acl_ptr_set *ptrs;     /* transitions array for this node */
  int32_t                 match_flag;
  int32_t                 match_index; /* index to match data */
  uint32_t                node_type;
  int32_t                 fanout;
  /* number of ranges (transitions w/ consecutive bits) */
  int32_t                 id;
  struct rte_acl_match_results *mrt; /* only valid when match_flag != 0 */
  union {
    char            transitions[RTE_ACL_QUAD_SIZE];
    /* boundaries for ranged node */
    uint8_t         dfa_gr64[RTE_ACL_DFA_GR64_NUM];
  };
  struct rte_acl_node     *next;
  /* free list link or pointer to duplicate node during merge */
  struct rte_acl_node     *prev;
  /* points to node from which this node was duplicated */
};

struct rte_acl_trie {
  uint32_t        type;
  uint32_t        count;
  uint32_t        root_index;
  const uint32_t *data_index;
  uint32_t        num_data_indexes;
};

struct rte_acl_bld_trie {
  struct rte_acl_node *trie;
};

struct rte_acl_ctx {
  char                name[RTE_ACL_NAMESIZE];
  /** Name of the ACL context. */
  int32_t             socket_id;
  /** Socket ID to allocate memory from. */
  enum rte_acl_classify_alg alg;
  void               *rules;
  uint32_t            max_rules;
  uint32_t            rule_sz;
  uint32_t            num_rules;
  uint32_t            num_categories;
  uint32_t            num_tries;
  uint32_t            match_index;
  uint64_t            no_match;
  uint64_t            idle;
  uint64_t           *trans_table;
  uint32_t           *data_indexes;
  struct rte_acl_trie trie[RTE_ACL_MAX_TRIES];
  void               *mem;
  size_t              mem_sz;
  struct rte_acl_config config; /* copy of build config. */
};
// end lib/librte_acl/acl.h

// start lib/librte_cfgfile/rte_cfgfile.c
struct rte_cfgfile_section {
  char name[CFG_NAME_LEN];
  int num_entries;
  struct rte_cfgfile_entry *entries[0];
};

struct rte_cfgfile {
  int flags;
  int num_sections;
  struct rte_cfgfile_section *sections[0];
};
// end lib/librte_cfgfile/rte_cfgfile.c

// start lib/librte_distributor/rte_distributor.c

struct rte_distributor_returned_pkts {
  unsigned start;
  unsigned count;
  struct rte_mbuf *mbufs[RTE_DISTRIB_MAX_RETURNS];
};

union rte_distributor_buffer {
  volatile int64_t bufptr64;
  char pad[RTE_CACHE_LINE_SIZE*3];
} __rte_cache_aligned;

struct rte_distributor_backlog {
  unsigned start;
  unsigned count;
  int64_t pkts[RTE_DISTRIB_BACKLOG_SIZE];
};

struct rte_distributor {
  TAILQ_ENTRY(rte_distributor) next;    /**< Next in list. */

  char name[RTE_DISTRIBUTOR_NAMESIZE];  /**< Name of the ring. */
  unsigned num_workers;                 /**< Number of workers polling */

  uint32_t in_flight_tags[RTE_DISTRIB_MAX_WORKERS];
    /**< Tracks the tag being processed per core */
  uint64_t in_flight_bitmask;
    /**< on/off bits for in-flight tags.
     * Note that if RTE_DISTRIB_MAX_WORKERS is larger than 64 then
     * the bitmask has to expand.
     */

  struct rte_distributor_backlog backlog[RTE_DISTRIB_MAX_WORKERS];

  union rte_distributor_buffer bufs[RTE_DISTRIB_MAX_WORKERS];

  struct rte_distributor_returned_pkts returns;
};

// end lib/librte_distributor/rte_distributor.c

// start lib/librte_ether/rte_ethdev.c
struct rte_eth_dev_callback {
  TAILQ_ENTRY(rte_eth_dev_callback) next; /**< Callbacks list */
  rte_eth_dev_cb_fn cb_fn;                /**< Callback address */
  void *cb_arg;                           /**< Parameter for callback */
  enum rte_eth_event_type event;          /**< Interrupt event type */
  uint32_t active;                        /**< Callback is executing */
};
// end lib/librte_ether/rte_ethdev.c

// start lib/librte_hash/rte_cuckoo_hash.h
#define LCORE_CACHE_SIZE    64
#define RTE_HASH_BUCKET_ENTRIES   4

enum add_key_case {
  ADD_KEY_SINGLEWRITER = 0,
  ADD_KEY_MULTIWRITER,
  ADD_KEY_MULTIWRITER_TM,
};

enum cmp_jump_table_case {
  KEY_CUSTOM = 0,
  KEY_16_BYTES,
  KEY_32_BYTES,
  KEY_48_BYTES,
  KEY_64_BYTES,
  KEY_80_BYTES,
  KEY_96_BYTES,
  KEY_112_BYTES,
  KEY_128_BYTES,
  KEY_OTHER_BYTES,
  NUM_KEY_CMP_CASES,
};

struct lcore_cache {
  unsigned len; /**< Cache len */
  void *objs[LCORE_CACHE_SIZE]; /**< Cache objects */
} __rte_cache_aligned;

struct rte_hash_signatures {
  union {
    struct {
      hash_sig_t current;
      hash_sig_t alt;
    };
    uint64_t sig;
  };
};

struct rte_hash_bucket {
  struct rte_hash_signatures signatures[RTE_HASH_BUCKET_ENTRIES];
  /* Includes dummy key index that always contains index 0 */
  uint32_t key_idx[RTE_HASH_BUCKET_ENTRIES + 1];
  uint8_t flag[RTE_HASH_BUCKET_ENTRIES];
} __rte_cache_aligned;


struct rte_hash {
  char name[RTE_HASH_NAMESIZE];   /**< Name of the hash. */
  uint32_t entries;               /**< Total table entries. */
  uint32_t num_buckets;           /**< Number of buckets in table. */
  uint32_t key_len;               /**< Length of hash key. */
  rte_hash_function hash_func;    /**< Function used to calculate hash. */
  uint32_t hash_func_init_val;    /**< Init value used by hash_func. */
  rte_hash_cmp_eq_t rte_hash_custom_cmp_eq;
  /**< Custom function used to compare keys. */
  enum cmp_jump_table_case cmp_jump_table_idx;
  /**< Indicates which compare function to use. */
  uint32_t bucket_bitmask;        /**< Bitmask for getting bucket index
            from hash signature. */
  uint32_t key_entry_size;         /**< Size of each key entry. */

  struct rte_ring *free_slots;    /**< Ring that stores all indexes
            of the free slots in the key table */
  void *key_store;                /**< Table storing all keys and data */
  struct rte_hash_bucket *buckets;  /**< Table with buckets storing all the
              hash values and key indexes
              to the key table*/
  uint8_t hw_trans_mem_support; /**< Hardware transactional
              memory support */
  struct lcore_cache *local_free_slots;
  /**< Local cache per lcore, storing some indexes of the free slots */
  enum add_key_case add_key; /**< Multi-writer hash add behavior */

  rte_spinlock_t *multiwriter_lock; /**< Multi-writer spinlock for w/o TM */
} __rte_cache_aligned;

// end lib/librte_hash/rte_cuckoo_hash.h

// start lib/librte_eal/common/rte_keepalive.c

struct rte_keepalive {
  /** Core Liveness. */
  enum rte_keepalive_state __rte_cache_aligned state_flags[
    RTE_KEEPALIVE_MAXCORES];

  /** Last-seen-alive timestamps */
  uint64_t last_alive[RTE_KEEPALIVE_MAXCORES];

  /**
   * Cores to check.
   * Indexed by core id, non-zero if the core should be checked.
   */
  uint8_t active_cores[RTE_KEEPALIVE_MAXCORES];
  
  /** Dead core handler. */
  rte_keepalive_failure_callback_t callback;
  
  /**
   * Dead core handler app data.
   * Pointer is passed to dead core handler.
   */
  void *callback_data;
  uint64_t tsc_initial;
  uint64_t tsc_mhz;

  /** Core state relay handler. */
  rte_keepalive_relay_callback_t relay_callback;

  /**
   * Core state relay handler app data.
   * Pointer is passed to live core handler.
   */
  void *relay_callback_data;
};

// end lib/librte_eal/common/rte_keepalive.c

// start lib/librte_kni/rte_kni.c
struct rte_kni {
  char name[RTE_KNI_NAMESIZE];        /**< KNI interface name */
  uint16_t group_id;                  /**< Group ID of KNI devices */
  uint32_t slot_id;                   /**< KNI pool slot ID */
  struct rte_mempool *pktmbuf_pool;   /**< pkt mbuf mempool */
  unsigned mbuf_size;                 /**< mbuf size */

  struct rte_kni_fifo *tx_q;          /**< TX queue */
  struct rte_kni_fifo *rx_q;          /**< RX queue */
  struct rte_kni_fifo *alloc_q;       /**< Allocated mbufs queue */
  struct rte_kni_fifo *free_q;        /**< To be freed mbufs queue */

  /* For request & response */
  struct rte_kni_fifo *req_q;         /**< Request queue */
  struct rte_kni_fifo *resp_q;        /**< Response queue */
  void * sync_addr;                   /**< Req/Resp Mem address */

  struct rte_kni_ops ops;             /**< operations for request */
  uint8_t in_use : 1;                 /**< kni in use */
};

// end rte_lcore.h preprocessed by cpp

// start lib/librte_lpm/rte_lpm6.c
#define RTE_LPM6_TBL24_NUM_ENTRIES        (1 << 24)
struct rte_lpm6_rule {
  uint8_t ip[RTE_LPM6_IPV6_ADDR_SIZE]; /**< Rule IP address. */
  uint8_t next_hop; /**< Rule next hop. */
  uint8_t depth; /**< Rule depth. */
};

struct rte_lpm6_tbl_entry {
  uint32_t next_hop:  21;  /**< Next hop / next table to be checked. */
  uint32_t depth  :8;      /**< Rule depth. */

  /* Flags. */
  uint32_t valid     :1;   /**< Validation flag. */
  uint32_t valid_group :1; /**< Group validation flag. */
  uint32_t ext_entry :1;   /**< External entry. */
};

struct rte_lpm6 {
  /* LPM metadata. */
  char name[RTE_LPM6_NAMESIZE];    /**< Name of the lpm. */
  uint32_t max_rules;              /**< Max number of rules. */
  uint32_t used_rules;             /**< Used rules so far. */
  uint32_t number_tbl8s;           /**< Number of tbl8s to allocate. */
  uint32_t next_tbl8;              /**< Next tbl8 to be used. */

  /* LPM Tables. */
  struct rte_lpm6_rule *rules_tbl; /**< LPM rules. */
  struct rte_lpm6_tbl_entry tbl24[RTE_LPM6_TBL24_NUM_ENTRIES]
      __rte_cache_aligned; /**< LPM tbl24 table. */
  struct rte_lpm6_tbl_entry tbl8[0]
      __rte_cache_aligned; /**< LPM tbl8 table. */
};
// end lib/librte_lpm/rte_lpm6.c

// start lib/librte_eal/common/malloc_elem.h
enum elem_state {
  ELEM_FREE = 0,
  ELEM_BUSY,
  ELEM_PAD  /* element is a padding-only header */
};

struct malloc_elem {
  struct malloc_heap *heap;
  struct malloc_elem *volatile prev;      /* points to prev elem in memseg */
  LIST_ENTRY(malloc_elem) free_list;      /* list of free elements in heap */
  const struct rte_memseg *ms;
  volatile enum elem_state state;
  uint32_t pad;
  size_t size;
#ifdef RTE_LIBRTE_MALLOC_DEBUG
  uint64_t header_cookie;         /* Cookie marking start of data */
                                  /* trailer cookie at start + size */
#endif
} __rte_cache_aligned;
// end lib/librte_eal/common/malloc_elem.h

// start lib/librte_pipeline/rte_pipeline.c
#define RTE_PIPELINE_MAX_NAME_SZ                           124

struct rte_port_in {
  /* Input parameters */
  struct rte_port_in_ops ops;
  rte_pipeline_port_in_action_handler f_action;
  void *arg_ah;
  uint32_t burst_size;

  /* The table to which this port is connected */
  uint32_t table_id;

  /* Handle to low-level port */
  void *h_port;

  /* List of enabled ports */
  struct rte_port_in *next;

  /* Statistics */
  uint64_t n_pkts_dropped_by_ah;
};

struct rte_port_out {
  /* Input parameters */
  struct rte_port_out_ops ops;
  rte_pipeline_port_out_action_handler f_action;
  void *arg_ah;

  /* Handle to low-level port */
  void *h_port;

  /* Statistics */
  uint64_t n_pkts_dropped_by_ah;
};

struct rte_table {
  /* Input parameters */
  struct rte_table_ops ops;
  rte_pipeline_table_action_handler_hit f_action_hit;
  rte_pipeline_table_action_handler_miss f_action_miss;
  void *arg_ah;
  struct rte_pipeline_table_entry *default_entry;
  uint32_t entry_size;

  uint32_t table_next_id;
  uint32_t table_next_id_valid;

  /* Handle to the low-level table object */
  void *h_table;

  /* Statistics */
  uint64_t n_pkts_dropped_by_lkp_hit_ah;
  uint64_t n_pkts_dropped_by_lkp_miss_ah;
  uint64_t n_pkts_dropped_lkp_hit;
  uint64_t n_pkts_dropped_lkp_miss;
};

struct rte_pipeline {
  /* Input parameters */
  char name[RTE_PIPELINE_MAX_NAME_SZ];
  int socket_id;
  uint32_t offset_port_id;

  /* Internal tables */
  struct rte_port_in ports_in[RTE_PIPELINE_PORT_IN_MAX];
  struct rte_port_out ports_out[RTE_PIPELINE_PORT_OUT_MAX];
  struct rte_table tables[RTE_PIPELINE_TABLE_MAX];

  /* Occupancy of internal tables */
  uint32_t num_ports_in;
  uint32_t num_ports_out;
  uint32_t num_tables;

  /* List of enabled ports */
  uint64_t enabled_port_in_mask;
  struct rte_port_in *port_in_next;

  /* Pipeline run structures */
  struct rte_mbuf *pkts[RTE_PORT_IN_BURST_SIZE_MAX];
  struct rte_pipeline_table_entry *entries[RTE_PORT_IN_BURST_SIZE_MAX];
  uint64_t action_mask0[RTE_PIPELINE_ACTIONS];
  uint64_t action_mask1[RTE_PIPELINE_ACTIONS];
  uint64_t pkts_mask;
  uint64_t n_pkts_ah_drop;
  uint64_t pkts_drop_mask;
} __rte_cache_aligned;
// end lib/librte_pipeline/rte_pipeline.c

// start lib/librte_reorder/rte_reorder.c
#define RTE_REORDER_NAMESIZE 32

struct cir_buffer {
  unsigned int size;   /**< Number of entries that can be stored */
  unsigned int mask;   /**< [buffer_size - 1]: used for wrap-around */
  unsigned int head;   /**< insertion point in buffer */
  unsigned int tail;   /**< extraction point in buffer */
  struct rte_mbuf **entries;
} __rte_cache_aligned;

struct rte_reorder_buffer {
  char name[RTE_REORDER_NAMESIZE];
  uint32_t min_seqn;  /**< Lowest seq. number that can be in the buffer */
  unsigned int memsize; /**< memory area size of reorder buffer */
  struct cir_buffer ready_buf; /**< temp buffer for dequeued entries */
  struct cir_buffer order_buf; /**< buffer used to reorder entries */
  int is_initialized;
} __rte_cache_aligned;
// end lib/librte_reorder/rte_reorder.c

// start lib/librte_sched/rte_sched.c
#undef RTE_SCHED_RED

#define RTE_SCHED_GRINDER_PCACHE_SIZE         (64 / RTE_SCHED_QUEUES_PER_PIPE)

enum grinder_state {
  e_GRINDER_PREFETCH_PIPE = 0,
  e_GRINDER_PREFETCH_TC_QUEUE_ARRAYS,
  e_GRINDER_PREFETCH_MBUF,
  e_GRINDER_READ_MBUF
};

struct rte_sched_pipe_profile {
  /* Token bucket (TB) */
  uint32_t tb_period;
  uint32_t tb_credits_per_period;
  uint32_t tb_size;

  /* Pipe traffic classes */
  uint32_t tc_period;
  uint32_t tc_credits_per_period[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
  uint8_t tc_ov_weight;

  /* Pipe queues */
  uint8_t  wrr_cost[RTE_SCHED_QUEUES_PER_PIPE];
};

struct rte_sched_queue_extra {
  struct rte_sched_queue_stats stats;
#ifdef RTE_SCHED_RED
  struct rte_red red;
#endif
};

struct rte_sched_queue {
  uint16_t qw;
  uint16_t qr;
};

struct rte_sched_pipe {
  /* Token bucket (TB) */
  uint64_t tb_time; /* time of last update */
  uint32_t tb_credits;

  /* Pipe profile and flags */
  uint32_t profile;

  /* Traffic classes (TCs) */
  uint64_t tc_time; /* time of next update */
  uint32_t tc_credits[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];

  /* Weighted Round Robin (WRR) */
  uint8_t wrr_tokens[RTE_SCHED_QUEUES_PER_PIPE];

  /* TC oversubscription */
  uint32_t tc_ov_credits;
  uint8_t tc_ov_period_id;
  uint8_t reserved[3];
} __rte_cache_aligned;

struct rte_sched_subport {
  /* Token bucket (TB) */
  uint64_t tb_time; /* time of last update */
  uint32_t tb_period;
  uint32_t tb_credits_per_period;
  uint32_t tb_size;
  uint32_t tb_credits;

  /* Traffic classes (TCs) */
  uint64_t tc_time; /* time of next update */
  uint32_t tc_credits_per_period[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
  uint32_t tc_credits[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
  uint32_t tc_period;

  /* TC oversubscription */
  uint32_t tc_ov_wm;
  uint32_t tc_ov_wm_min;
  uint32_t tc_ov_wm_max;
  uint8_t tc_ov_period_id;
  uint8_t tc_ov;
  uint32_t tc_ov_n;
  double tc_ov_rate;

  /* Statistics */
  struct rte_sched_subport_stats stats;
};

struct rte_sched_grinder {
  /* Pipe cache */
  uint16_t pcache_qmask[RTE_SCHED_GRINDER_PCACHE_SIZE];
  uint32_t pcache_qindex[RTE_SCHED_GRINDER_PCACHE_SIZE];
  uint32_t pcache_w;
  uint32_t pcache_r;

  /* Current pipe */
  enum grinder_state state;
  uint32_t productive;
  uint32_t pindex;
  struct rte_sched_subport *subport;
  struct rte_sched_pipe *pipe;
  struct rte_sched_pipe_profile *pipe_params;

  /* TC cache */
  uint8_t tccache_qmask[4];
  uint32_t tccache_qindex[4];
  uint32_t tccache_w;
  uint32_t tccache_r;

  /* Current TC */
  uint32_t tc_index;
  struct rte_sched_queue *queue[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
  struct rte_mbuf **qbase[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
  uint32_t qindex[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
  uint16_t qsize;
  uint32_t qmask;
  uint32_t qpos;
  struct rte_mbuf *pkt;

  /* WRR */
  uint16_t wrr_tokens[RTE_SCHED_QUEUES_PER_TRAFFIC_CLASS];
  uint16_t wrr_mask[RTE_SCHED_QUEUES_PER_TRAFFIC_CLASS];
  uint8_t wrr_cost[RTE_SCHED_QUEUES_PER_TRAFFIC_CLASS];
};

struct rte_sched_port {
  /* User parameters */
  uint32_t n_subports_per_port;
  uint32_t n_pipes_per_subport;
  uint32_t rate;
  uint32_t mtu;
  uint32_t frame_overhead;
  uint16_t qsize[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
  uint32_t n_pipe_profiles;
  uint32_t pipe_tc3_rate_max;
#ifdef RTE_SCHED_RED
  struct rte_red_config red_config[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE][e_RTE_METER_COLORS];
#endif

  /* Timing */
  uint64_t time_cpu_cycles;     /* Current CPU time measured in CPU cyles */
  uint64_t time_cpu_bytes;      /* Current CPU time measured in bytes */
  uint64_t time;                /* Current NIC TX time measured in bytes */
  struct rte_reciprocal inv_cycles_per_byte; /* CPU cycles per byte */

  /* Scheduling loop detection */
  uint32_t pipe_loop;
  uint32_t pipe_exhaustion;

  /* Bitmap */
  struct rte_bitmap *bmp;
  uint32_t grinder_base_bmp_pos[RTE_SCHED_PORT_N_GRINDERS] __rte_aligned_16;

  /* Grinders */
  struct rte_sched_grinder grinder[RTE_SCHED_PORT_N_GRINDERS];
  uint32_t busy_grinders;
  struct rte_mbuf **pkts_out;
  uint32_t n_pkts_out;

  /* Queue base calculation */
  uint32_t qsize_add[RTE_SCHED_QUEUES_PER_PIPE];
  uint32_t qsize_sum;

  /* Large data structures */
  struct rte_sched_subport *subport;
  struct rte_sched_pipe *pipe;
  struct rte_sched_queue *queue;
  struct rte_sched_queue_extra *queue_extra;
  struct rte_sched_pipe_profile *pipe_profiles;
  uint8_t *bmp_array;
  struct rte_mbuf **queue_array;
  uint8_t memory[0] __rte_cache_aligned;
} __rte_cache_aligned;
// end lib/librte_sched/rte_sched.c

#endif
