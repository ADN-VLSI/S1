module s1_uart_regif

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
  import s1_uart_pkg::UART_INT_OFFSET;

(
    // clock input
    input logic clk_i,
    // asynchronous active low reset input
    input logic arst_ni,

    // AXI request input
    input  uart_axil_req_t  req_i,
    // AXI response output
    output uart_axil_resp_t resp_o,

    output uart_ctrl_reg_t uart_ctrl_o,
    output uart_cfg_reg_t  uart_cfg_o,
    output uart_stat_reg_t uart_stat_o,

    input  uart_count_t tx_data_cnt_i,
    output uart_data_t  tx_data_o,
    output logic        tx_data_valid_o,
    input  logic        tx_data_ready_i,

    input  uart_count_t rx_data_cnt_i,
    input  uart_data_t  rx_data_i,
    input  logic        rx_data_valid_i,
    output logic        rx_data_ready_o,

    output uart_int_reg_t uart_int_o
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // AXI request input
  uart_axil_req_t  fifo_req;
  // AXI response output
  uart_axil_resp_t fifo_resp;

  logic            wr_en;
  logic            rd_en;

  uart_id_t        tx_id_queue_in;
  logic            tx_id_queue_in_valid;
  logic            tx_id_queue_in_ready;

  uart_id_t        tx_id_queue_out;
  logic            tx_id_queue_out_valid;
  logic            tx_id_queue_out_ready;

  uart_id_t        rx_id_queue_in;
  logic            rx_id_queue_in_valid;
  logic            rx_id_queue_in_ready;

  uart_id_t        rx_id_queue_out;
  logic            rx_id_queue_out_valid;
  logic            rx_id_queue_out_ready;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // COMBINATIONAL LOGICS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always_comb begin
    wr_en = fifo_req.aw_valid && fifo_req.w_valid && fifo_req.b_ready;
    fifo_resp.aw_ready = wr_en;
    fifo_resp.w_ready = wr_en;
    fifo_resp.b_valid = wr_en;
  end

  always_comb begin
    rd_en = fifo_req.ar_valid && fifo_req.r_ready;
    fifo_resp.ar_ready = rd_en;
    fifo_resp.r_valid = rd_en;
  end

  always_comb tx_data_o = fifo_req.w.data;
  always_comb tx_id_queue_in = fifo_req.w.data;
  always_comb rx_id_queue_in = fifo_req.w.data;

  always_comb begin

    fifo_resp.r.data = '0;
    fifo_resp.r.resp = 2'b10;
    tx_id_queue_out_ready = '0;

    case (fifo_req.ar.addr)

      UART_CTRL_OFFSET: begin
        fifo_resp.r.data = uart_ctrl_o;
        fifo_resp.r.resp = '0;
      end

      UART_CFG_OFFSET: begin
        fifo_resp.r.data = uart_cfg_o;
        fifo_resp.r.resp = '0;
      end

      UART_STAT_OFFSET: begin
        fifo_resp.r.data = uart_stat_o;
        fifo_resp.r.resp = '0;
      end

      UART_TXGP_OFFSET: begin
        if (tx_id_queue_out_valid) begin
          fifo_resp.r.data = tx_id_queue_out;
          fifo_resp.r.resp = '0;
        end
      end

      UART_TXG_OFFSET: begin
        if (tx_id_queue_out_valid) begin
          fifo_resp.r.data = tx_id_queue_out;
          fifo_resp.r.resp = '0;
          tx_id_queue_out_ready = rd_en;
        end
      end

      UART_RXGP_OFFSET: begin
        if (rx_id_queue_out_valid) begin
          fifo_resp.r.data = rx_id_queue_out;
          fifo_resp.r.resp = '0;
        end
      end

      UART_RXG_OFFSET: begin
        if (rx_id_queue_out_valid) begin
          fifo_resp.r.data = rx_id_queue_out;
          fifo_resp.r.resp = '0;
          rx_id_queue_out_ready = rd_en;
        end
      end

      UART_RXD_OFFSET: begin
        if (rx_data_valid_i) begin
          fifo_resp.r.data = rx_data_i;
          fifo_resp.r.resp = '0;
          rx_data_ready_o  = rd_en;
        end
      end

      UART_INT_OFFSET: begin
        fifo_resp.r.data = uart_int_o;
        fifo_resp.r.resp = '0;
      end

      default: begin
      end

    endcase

  end

  always_comb begin

    fifo_resp.b.resp = 2'b10;
    tx_id_queue_in_valid = '0;

    case (fifo_req.aw.addr)

      UART_CTRL_OFFSET: begin
        fifo_resp.b.resp = '0;
      end

      UART_CFG_OFFSET: begin
        if (tx_data_cnt_i == '0 && rx_data_cnt_i == '0) begin
          fifo_resp.b.resp = '0;
        end
      end

      UART_TXR_OFFSET: begin
        if (tx_id_queue_in_ready) begin
          fifo_resp.b.resp = '0;
          tx_id_queue_in_valid = wr_en;
        end
      end

      UART_TXD_OFFSET: begin
        if (tx_data_ready_i) begin
          fifo_resp.b.resp = '0;
          tx_data_valid_o  = wr_en;
        end
      end

      UART_RXR_OFFSET: begin
        if (rx_id_queue_in_ready) begin
          fifo_resp.b.resp = '0;
          rx_id_queue_in_valid = wr_en;
        end
      end

      UART_INT_OFFSET: begin
        fifo_resp.b.resp = '0;
      end

      default: begin
      end

    endcase

  end

  always_ff @(posedge clk_i or negedge arst_ni) begin

    if (!arst_ni) begin
      uart_ctrl_o <= '0;
      uart_cfg_o  <= '0;
    end else if (fifo_resp.b.resp == '0) begin

      case (fifo_req.aw.addr)

        UART_CTRL_OFFSET: uart_ctrl_o <= fifo_req.w.data;
        UART_CFG_OFFSET:  uart_cfg_o <= fifo_req.w.data;
        UART_INT_OFFSET:  uart_int_o <= fifo_req.w.data;

        default: begin
        end

      endcase

    end

  end

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SUBMODULES
  //////////////////////////////////////////////////////////////////////////////////////////////////

  axi_fifo #(
      .Depth      (4),
      .FallThrough(0),
      .aw_chan_t  (uart_axil_aw_chan_t),
      .w_chan_t   (uart_axil_w_chan_t),
      .b_chan_t   (uart_axil_b_chan_t),
      .ar_chan_t  (uart_axil_ar_chan_t),
      .r_chan_t   (uart_axil_r_chan_t),
      .axi_req_t  (uart_axil_req_t),
      .axi_resp_t (uart_axil_resp_t)
  ) u_axi_fifo (
      .clk_i     (clk_i),
      .rst_ni    (arst_ni),
      .test_i    ('0),
      .slv_req_i (req_i),
      .slv_resp_o(resp_o),
      .mst_req_o (fifo_req),
      .mst_resp_i(fifo_resp)
  );

  fifo #(
      .PIPELINED (1),
      .ELEM_WIDTH($bits(tx_id_queue_in)),
      .FIFO_SIZE (3)
  ) tx_id_queue (
      .clk_i           (clk_i),
      .arst_ni         (arst_ni),
      .elem_in_i       (tx_id_queue_in),
      .elem_in_valid_i (tx_id_queue_in_valid),
      .elem_in_ready_o (tx_id_queue_in_ready),
      .elem_out_o      (tx_id_queue_out),
      .elem_out_valid_o(tx_id_queue_out_valid),
      .elem_out_ready_i(tx_id_queue_out_ready),
      .el_cnt_o        ()
  );

  fifo #(
      .PIPELINED (1),
      .ELEM_WIDTH($bits(rx_id_queue_in)),
      .FIFO_SIZE (3)
  ) rx_id_queue (
      .clk_i           (clk_i),
      .arst_ni         (arst_ni),
      .elem_in_i       (rx_id_queue_in),
      .elem_in_valid_i (rx_id_queue_in_valid),
      .elem_in_ready_o (rx_id_queue_in_ready),
      .elem_out_o      (rx_id_queue_out),
      .elem_out_valid_o(rx_id_queue_out_valid),
      .elem_out_ready_i(rx_id_queue_out_ready),
      .el_cnt_o        ()
  );

endmodule
