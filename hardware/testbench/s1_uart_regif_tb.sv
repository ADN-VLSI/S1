`include "simple_axil_m_driver.svh"

module s1_uart_regif_tb;

  `include "vip/s1_start_end_display.sv"

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // IMPORTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // import s1_uart_pkg::uart_axil_aw_chan_t;
  // import s1_uart_pkg::uart_axil_w_chan_t;
  // import s1_uart_pkg::uart_axil_b_chan_t;
  // import s1_uart_pkg::uart_axil_ar_chan_t;
  // import s1_uart_pkg::uart_axil_r_chan_t;
  import s1_uart_pkg::uart_axil_req_t;
  import s1_uart_pkg::uart_axil_resp_t;

  import s1_uart_pkg::uart_ctrl_reg_t;
  import s1_uart_pkg::uart_cfg_reg_t;
  import s1_uart_pkg::uart_stat_reg_t;
  // import s1_uart_pkg::uart_id_t;
  import s1_uart_pkg::uart_data_t;
  import s1_uart_pkg::uart_count_t;
  import s1_uart_pkg::uart_int_reg_t;

  // import s1_uart_pkg::UART_CTRL_OFFSET;
  // import s1_uart_pkg::UART_CFG_OFFSET;
  // import s1_uart_pkg::UART_STAT_OFFSET;
  // import s1_uart_pkg::UART_TXR_OFFSET;
  // import s1_uart_pkg::UART_TXGP_OFFSET;
  // import s1_uart_pkg::UART_TXG_OFFSET;
  // import s1_uart_pkg::UART_TXD_OFFSET;
  // import s1_uart_pkg::UART_RXR_OFFSET;
  // import s1_uart_pkg::UART_RXGP_OFFSET;
  // import s1_uart_pkg::UART_RXG_OFFSET;
  // import s1_uart_pkg::UART_RXD_OFFSET;
  // import s1_uart_pkg::UART_INT_OFFSET;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // DUT Signals
  logic            clk_i;
  logic            arst_ni;
  uart_axil_req_t  req_i;
  uart_axil_resp_t resp_o;
  uart_ctrl_reg_t  uart_ctrl_o;
  uart_cfg_reg_t   uart_cfg_o;
  uart_stat_reg_t  uart_stat_o;
  uart_count_t     tx_data_cnt_i;
  uart_data_t      tx_data_o;
  logic            tx_data_valid_o;
  logic            tx_data_ready_i;
  uart_count_t     rx_data_cnt_i;
  uart_data_t      rx_data_i;
  logic            rx_data_valid_i;
  logic            rx_data_ready_o;
  uart_int_reg_t   uart_int_o;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // DUT INSTANCE
  //////////////////////////////////////////////////////////////////////////////////////////////////

  s1_uart_regif u_dut (.*);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // task automatic axil_read_8(addr, data, resp);
  // task automatic axil_write_8(addr, data, resp);
  // task automatic axil_read_16(addr, data, resp);
  // task automatic axil_write_16(addr, data, resp);
  // task automatic axil_read_32(addr, data, resp);
  // task automatic axil_write_32(addr, data, resp);
  // task automatic axil_read_64(addr, data, resp);
  // task automatic axil_write_64(addr, data, resp);
  `SIMPLE_AXIL_M_DRIVER(axil, clk_i, arst_ni, req_i, resp_o)

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin
    #100ns;
    $finish;
  end

endmodule
