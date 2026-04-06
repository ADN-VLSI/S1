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

  import s1_uart_pkg::UART_CTRL_OFFSET;
  import s1_uart_pkg::UART_CFG_OFFSET;
  import s1_uart_pkg::UART_STAT_OFFSET;
  import s1_uart_pkg::UART_TXR_OFFSET;
  import s1_uart_pkg::UART_TXGP_OFFSET;
  import s1_uart_pkg::UART_TXG_OFFSET;
  import s1_uart_pkg::UART_TXD_OFFSET;
  import s1_uart_pkg::UART_RXR_OFFSET;
  import s1_uart_pkg::UART_RXGP_OFFSET;
  import s1_uart_pkg::UART_RXG_OFFSET;
  import s1_uart_pkg::UART_RXD_OFFSET;
  import s1_uart_pkg::UART_INT_EN_OFFSET;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // DUT Signals
  logic            clk_i = 0;
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
  uart_int_reg_t   uart_int_en_o;

  // Internal Outputs
  logic [1:0] internal_resp;
  logic [1:0] internal_data;

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

  task automatic start_clock();
    fork
      forever #5ns clk_i <= ~clk_i;
    join_none
    @(posedge clk_i);
  endtask

  task automatic apply_reset();
    #2ns;
    arst_ni         <= '0;
    req_i           <= '{default:0};
    tx_data_cnt_i   <= '{default:0};
    tx_data_ready_i <= '0;
    rx_data_cnt_i   <= '{default:0};
    rx_data_i       <= '{default:0};
    rx_data_valid_i <= '0;
    #5ns;
    arst_ni         <= 1'b1;
    tx_data_ready_i <= 1'b1;
    #5ns;
  endtask

  task automatic write_8_RW_WO();
    // writing to RW and WO registers:
    axil_write_8(UART_CTRL_OFFSET,  $urandom, internal_resp);
    axil_write_8(UART_CFG_OFFSET,   $urandom, internal_resp);
    axil_write_8(UART_TXR_OFFSET,   $urandom, internal_resp);
    axil_write_8(UART_TXD_OFFSET,   $urandom, internal_resp);
    axil_write_8(UART_RXR_OFFSET,   $urandom, internal_resp);
    axil_write_8(UART_INT_EN_OFFSET,$urandom, internal_resp);

    // reading from above RW and WO registers:
    axil_read_8(UART_CTRL_OFFSET,  internal_data, internal_resp);
    axil_read_8(UART_CFG_OFFSET,   internal_data, internal_resp);
    axil_read_8(UART_TXR_OFFSET,   internal_data, internal_resp);
    axil_read_8(UART_TXD_OFFSET,   internal_data, internal_resp);
    axil_read_8(UART_RXR_OFFSET,   internal_data, internal_resp);
    axil_read_8(UART_INT_EN_OFFSET,internal_data, internal_resp);
  endtask

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin
    $dumpfile("s1_uart_regif_tb.vcd");
    $dumpvars;
  end

  initial begin
    apply_reset();
    start_clock();
    write_8_RW_WO();


  end

  initial begin
    #1000ns;
    $finish;
  end

endmodule
