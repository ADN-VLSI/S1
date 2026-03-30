package s1_uart_pkg;

  parameter int UART_BASE = 'h4000_0000;  // TODO FIXME

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PARAMTERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Register Offsets
  parameter int UART_CTRL_OFFSET = 'h000;
  parameter int UART_CFG_OFFSET = 'h004;
  parameter int UART_STAT_OFFSET = 'h008;
  parameter int UART_TXR_OFFSET = 'h010;
  parameter int UART_TXGP_OFFSET = 'h014;
  parameter int UART_TXG_OFFSET = 'h018;
  parameter int UART_TXD_OFFSET = 'h01C;
  parameter int UART_RXR_OFFSET = 'h020;
  parameter int UART_RXGP_OFFSET = 'h024;
  parameter int UART_RXG_OFFSET = 'h028;
  parameter int UART_RXD_OFFSET = 'h02C;
  parameter int UART_INT_OFFSET = 'h030;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // TYPE DEFINITIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Control Register Bitfield Definitions
  typedef struct packed {
    logic        rx_en;
    logic        tx_en;
    logic        rx_fifo_flush;
    logic        tx_fifo_flush;
    logic        uart_rst;
  } uart_ctrl_reg_t;

  // Configuration Register Bitfield Definitions
  typedef struct packed {
    logic        sb;
    logic        ptp;
    logic        pen;
    logic [1:0]  db;
    logic [3:0]  psclr;
    logic [11:0] clk_div;
  } uart_cfg_reg_t;

  // Status Register Bitfield Definitions
  typedef struct packed {
    logic       rx_full;
    logic       rx_empty;
    logic       tx_full;
    logic       tx_empty;
    logic [9:0] rx_cnt;
    logic [9:0] tx_cnt;
  } uart_stat_reg_t;

  // ID Register Bitfield Definitions
  typedef struct packed {
    logic [7:0]  id;
  } uart_id_t;

  // Data Register Bitfield Definitions
  typedef struct packed {
    logic [7:0]  data;
  } uart_data_t;

  // Count Register Bitfield Definitions
  typedef struct packed {
    logic [9:0]  count;
  } uart_count_t;

  // Interrupt Register Bitfield Definitions
  typedef struct packed {
    logic        tx_full;
    logic        tx_empty;
    logic        rx_empty;
    logic        rx_full;
  } uart_int_reg_t;

endpackage
