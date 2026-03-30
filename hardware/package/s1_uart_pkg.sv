`include "axi/typedef.svh"

package s1_uart_pkg;

  parameter int UART_BASE = 'h4000_0000;  // TODO FIXME

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PARAMTERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Register Offsets
  parameter int UART_CTRL_OFFSET = 'h00;
  parameter int UART_CFG_OFFSET = 'h04;
  parameter int UART_STAT_OFFSET = 'h08;
  parameter int UART_TXR_OFFSET = 'h10;
  parameter int UART_TXGP_OFFSET = 'h14;
  parameter int UART_TXG_OFFSET = 'h18;
  parameter int UART_TXD_OFFSET = 'h1C;
  parameter int UART_RXR_OFFSET = 'h20;
  parameter int UART_RXGP_OFFSET = 'h24;
  parameter int UART_RXG_OFFSET = 'h28;
  parameter int UART_RXD_OFFSET = 'h2C;
  parameter int UART_INT_OFFSET = 'h30;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // TYPE DEFINITIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // AXI Lite Interface Type Definitions
  `AXI_LITE_TYPEDEF_ALL(uart_axil, logic [7:0], logic [31:0], logic [3:0])

  // Control Register Bitfield Definitions
  typedef struct packed {
    logic rx_en;
    logic tx_en;
    logic rx_fifo_flush;
    logic tx_fifo_flush;
    logic uart_rst;
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
  typedef struct packed {logic [7:0] id;} uart_id_t;

  // Data Register Bitfield Definitions
  typedef struct packed {logic [7:0] data;} uart_data_t;

  // Count Register Bitfield Definitions
  typedef struct packed {logic [9:0] count;} uart_count_t;

  // Interrupt Register Bitfield Definitions
  typedef struct packed {
    logic tx_full;
    logic tx_empty;
    logic rx_empty;
    logic rx_full;
  } uart_int_reg_t;

endpackage
