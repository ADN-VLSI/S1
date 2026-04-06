module s1_uart_top
  import s1_uart_pkg::uart_axil_aw_chan_t;
  import s1_uart_pkg::uart_axil_w_chan_t;
  import s1_uart_pkg::uart_axil_b_chan_t;
  import s1_uart_pkg::uart_axil_ar_chan_t;
  import s1_uart_pkg::uart_axil_r_chan_t;
  import s1_uart_pkg::uart_axil_req_t;
  import s1_uart_pkg::uart_axil_resp_t;

  import s1_uart_pkg::uart_ctrl_reg_t;
  import s1_uart_pkg::uart_cfg_reg_t;
  import s1_uart_pkg::uart_stat_reg_t;
  import s1_uart_pkg::uart_id_t;
  import s1_uart_pkg::uart_data_t;
  import s1_uart_pkg::uart_count_t;
  import s1_uart_pkg::uart_int_reg_t;

(
    input logic clk_i,
    input logic arst_ni,

    input  uart_axil_req_t  req_i,
    output uart_axil_resp_t resp_o,

    output logic tx_o,
    input  logic rx_i,

    output uart_int_reg_t uart_int_o

);


  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic           tx_clk;
  logic           rx_clk;
  logic           sc_clk;

  uart_ctrl_reg_t uart_ctrl;
  uart_cfg_reg_t  uart_cfg;
  uart_stat_reg_t uart_stat;

  uart_count_t    tx_data_cnt;
  uart_data_t     tx_data;
  logic           tx_data_valid;
  logic           tx_data_ready;

  uart_count_t    rx_data_cnt;
  uart_data_t     rx_data;
  logic           rx_data_valid;
  logic           rx_data_ready;

  uart_data_t     to_tx_data;
  logic           to_tx_data_valid;
  logic           to_tx_data_ready;
  uart_count_t    to_tx_data_cnt;

  uart_data_t     from_rx_data;
  logic           from_rx_data_valid;
  logic           from_rx_data_ready;
  uart_count_t    from_rx_data_cnt;

  logic           data_err;

  uart_int_reg_t  uart_int_en;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SUBMODULES
  //////////////////////////////////////////////////////////////////////////////////////////////////

  s1_uart_regif u_s1_uart_regif (
      .clk_i          (clk_i),
      .arst_ni        (arst_ni),
      .req_i          (req_i),
      .resp_o         (resp_o),
      .uart_ctrl_o    (uart_ctrl),
      .uart_cfg       (uart_cfg),
      .uart_stat_o    (uart_stat),
      .tx_data_cnt_i  (tx_data_cnt),
      .tx_data_o      (tx_data),
      .tx_data_valid_o(tx_data_valid),
      .tx_data_ready_i(tx_data_ready),
      .rx_data_cnt_i  (rx_data_cnt),
      .rx_data_i      (rx_data),
      .rx_data_valid_i(rx_data_valid),
      .rx_data_ready_o(rx_data_ready),
      .uart_int_en_o  (uart_int_en)
  );

  s1_clk_div #(
      .DIV_WIDTH(4)
  ) u_sc_s1_clk_div (
      .arst_ni(arst_ni),
      .clk_i  (clk_i),
      .div_i  (uart_cfg.psclr),
      .clk_o  (sc_clk)
  );

  s1_clk_div #(
      .DIV_WIDTH(10)
  ) u_rx_s1_clk_div (
      .arst_ni(arst_ni),
      .clk_i  (sc_clk),
      .div_i  (uart_cfg.clk_div[11:2]),
      .clk_o  (rx_clk)
  );

  s1_clk_div #(
      .DIV_WIDTH(3)
  ) u_tx_s1_clk_div (
      .arst_ni(arst_ni),
      .clk_i  (rx_clk),
      .div_i  (4),
      .clk_o  (tx_clk)
  );

  cdc_fifo #(
      .ELEM_WIDTH(8),
      .FIFO_SIZE (8)
  ) tx_fifo (
      .arst_ni         (arst_ni),
      .elem_in_clk_i   (clk_i),
      .elem_in_i       (tx_data),
      .elem_in_valid_i (tx_data_valid),
      .elem_in_ready_o (tx_data_ready),
      .elem_in_count_o (to_tx_data_cnt),
      .elem_out_clk_i  (tx_clk),
      .elem_out_o      (to_tx_data),
      .elem_out_valid_o(to_tx_data_valid),
      .elem_out_ready_i(to_tx_data_ready),
      .elem_out_count_o()
  );

  cdc_fifo #(
      .ELEM_WIDTH(8),
      .FIFO_SIZE (8)
  ) rx_fifo (
      .arst_ni         (arst_ni),
      .elem_in_clk_i   (rx_clk),
      .elem_in_i       (from_rx_data),
      .elem_in_valid_i (from_rx_data_valid),
      .elem_in_ready_o (from_rx_data_ready),
      .elem_in_count_o (from_rx_data_cnt),
      .elem_out_clk_i  (clk_i),
      .elem_out_o      (rx_data),
      .elem_out_valid_o(rx_data_valid),
      .elem_out_ready_i(rx_data_ready),
      .elem_out_count_o()
  );

  s1_uart_tx u_s1_uart_tx (
      .arst_ni     (arst_ni),
      .clk_i       (tx_clk),
      .sb_i        (uart_cfg.sb),
      .ptp_i       (uart_cfg.ptp),
      .pen_i       (uart_cfg.pen),
      .db_i        (uart_cfg.db),
      .data_i      (to_tx_data),
      .data_valid_i(to_tx_data_valid),
      .data_ready_o(to_tx_data_ready),
      .tx_o        (tx_o)
  );

  s1_uart_rx u_s1_uart_rx (
      .arst_ni     (arst_ni),
      .clk_i       (rx_clk),
      .ptp_i       (uart_cfg.ptp),
      .pen_i       (uart_cfg.pen),
      .db_i        (uart_cfg.db),
      .data_o      (from_rx_data),
      .data_err_o  (data_err),
      .data_valid_o(from_rx_data_valid),
      .rx_i        (rx_i)
  );

  always_comb begin
    uart_int_o.rx_overflow = uart_int_en.rx_overflow & from_rx_data_valid & ~from_rx_data_ready;
  end

  always_comb begin
    uart_int_o.rx_parity_err = uart_int_en.rx_parity_err & data_err;
  end

  always_comb begin
    uart_int_o.rx_empty = uart_int_en.rx_empty & ~rx_data_valid;
  end

  always_comb begin
    uart_int_o.rx_almost_full = uart_int_en.rx_almost_full & from_rx_data_cnt[9] & from_rx_data_cnt[8];
  end

  always_comb begin
    uart_int_o.rx_full = uart_int_en.rx_full & ~from_rx_data_ready;
  end

  always_comb begin
    uart_int_o.tx_empty = uart_int_en.tx_empty & (to_tx_data_cnt == 0);
  end

  always_comb begin
    uart_int_o.tx_almost_full = uart_int_en.tx_almost_full & to_tx_data_cnt[9] & to_tx_data_cnt[8];
  end

  always_comb begin
    uart_int_o.tx_full = uart_int_en.tx_full & ~tx_data_ready;
  end

endmodule
