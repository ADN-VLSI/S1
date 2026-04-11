module s1_uart_regif (
    // clock input
    input logic clk_i,
    // asynchronous active low reset input
    input logic arst_ni,

    // AXI request input
    input  s1_uart_pkg::uart_axil_req_t  req_i,
    // AXI response output
    output s1_uart_pkg::uart_axil_resp_t resp_o,

    output s1_uart_pkg::uart_ctrl_reg_t uart_ctrl_o,
    output s1_uart_pkg::uart_cfg_reg_t  uart_cfg_o,
    output s1_uart_pkg::uart_stat_reg_t uart_stat_o,

    input  s1_uart_pkg::uart_count_t tx_data_cnt_i,
    output s1_uart_pkg::uart_data_t  tx_data_o,
    output logic                     tx_data_valid_o,
    input  logic                     tx_data_ready_i,

    input  s1_uart_pkg::uart_count_t rx_data_cnt_i,
    input  s1_uart_pkg::uart_data_t  rx_data_i,
    input  logic                     rx_data_valid_i,
    output logic                     rx_data_ready_o,

    output s1_uart_pkg::uart_int_reg_t uart_int_en_o
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // AXI request input
  s1_uart_pkg::uart_axil_req_t  fifo_req;
  // AXI response output
  s1_uart_pkg::uart_axil_resp_t fifo_resp;

  logic                         wr_en;
  logic                         rd_en;

  s1_uart_pkg::uart_id_t        tx_id_queue_in;
  logic                         tx_id_queue_in_valid;
  logic                         tx_id_queue_in_ready;

  s1_uart_pkg::uart_id_t        tx_id_queue_out;
  logic                         tx_id_queue_out_valid;
  logic                         tx_id_queue_out_ready;

  s1_uart_pkg::uart_id_t        rx_id_queue_in;
  logic                         rx_id_queue_in_valid;
  logic                         rx_id_queue_in_ready;

  s1_uart_pkg::uart_id_t        rx_id_queue_out;
  logic                         rx_id_queue_out_valid;
  logic                         rx_id_queue_out_ready;

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

    case ({
      fifo_req.ar.prot[1], fifo_req.ar.addr
    })

      s1_uart_pkg::UART_CTRL_OFFSET: begin
        fifo_resp.r.data = {'0, uart_ctrl_o};
        fifo_resp.r.resp = '0;
      end

      s1_uart_pkg::UART_CFG_OFFSET: begin
        fifo_resp.r.data = {'0, uart_cfg_o};
        fifo_resp.r.resp = '0;
      end

      s1_uart_pkg::UART_STAT_OFFSET: begin
        fifo_resp.r.data = {'0, uart_stat_o};
        fifo_resp.r.resp = '0;
      end

      s1_uart_pkg::UART_TXGP_OFFSET: begin
        if (tx_id_queue_out_valid) begin
          fifo_resp.r.data = {'0, tx_id_queue_out};
          fifo_resp.r.resp = '0;
        end
      end

      s1_uart_pkg::UART_TXG_OFFSET: begin
        if (tx_id_queue_out_valid) begin
          fifo_resp.r.data = {'0, tx_id_queue_out};
          fifo_resp.r.resp = '0;
          tx_id_queue_out_ready = rd_en;
        end
      end

      s1_uart_pkg::UART_RXGP_OFFSET: begin
        if (rx_id_queue_out_valid) begin
          fifo_resp.r.data = {'0, rx_id_queue_out};
          fifo_resp.r.resp = '0;
        end
      end

      s1_uart_pkg::UART_RXG_OFFSET: begin
        if (rx_id_queue_out_valid) begin
          fifo_resp.r.data = {'0, rx_id_queue_out};
          fifo_resp.r.resp = '0;
          rx_id_queue_out_ready = rd_en;
        end
      end

      s1_uart_pkg::UART_RXD_OFFSET: begin
        if (rx_data_valid_i) begin
          fifo_resp.r.data = {'0, rx_data_i};
          fifo_resp.r.resp = '0;
          rx_data_ready_o  = rd_en;
        end
      end

      s1_uart_pkg::UART_INT_EN_OFFSET: begin
        fifo_resp.r.data = {'0, uart_int_en_o};
        fifo_resp.r.resp = '0;
      end

      default: begin
      end

    endcase

  end

  always_comb begin

    fifo_resp.b.resp = 2'b10;
    tx_id_queue_in_valid = '0;

    if (fifo_req.w.strb == 4'b1111) begin
      case ({
        fifo_req.aw.prot[1], fifo_req.aw.addr
      })

        s1_uart_pkg::UART_CTRL_OFFSET: begin
          fifo_resp.b.resp = '0;
        end

        s1_uart_pkg::UART_CFG_OFFSET: begin
          if (tx_data_cnt_i == '0 && rx_data_cnt_i == '0) begin
            fifo_resp.b.resp = '0;
          end
        end

        s1_uart_pkg::UART_TXR_OFFSET: begin
          if (tx_id_queue_in_ready) begin
            fifo_resp.b.resp = '0;
            tx_id_queue_in_valid = wr_en;
          end
        end

        s1_uart_pkg::UART_TXD_OFFSET: begin
          if (tx_data_ready_i) begin
            fifo_resp.b.resp = '0;
            tx_data_valid_o  = wr_en;
          end
        end

        s1_uart_pkg::UART_RXR_OFFSET: begin
          if (rx_id_queue_in_ready) begin
            fifo_resp.b.resp = '0;
            rx_id_queue_in_valid = wr_en;
          end
        end

        s1_uart_pkg::UART_INT_EN_OFFSET: begin
          fifo_resp.b.resp = '0;
        end

        default: begin
        end

      endcase

    end

  end

  always_ff @(posedge clk_i or negedge arst_ni) begin

    if (!arst_ni) begin
      uart_ctrl_o <= '0;
      uart_cfg_o  <= '0;
    end else if (fifo_resp.b.resp == '0) begin

      case (fifo_req.aw.addr)

        s1_uart_pkg::UART_CTRL_OFFSET:   uart_ctrl_o   <= fifo_req.w.data;
        s1_uart_pkg::UART_CFG_OFFSET:    uart_cfg_o    <= fifo_req.w.data;
        s1_uart_pkg::UART_INT_EN_OFFSET: uart_int_en_o <= fifo_req.w.data;

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
      .aw_chan_t  (s1_uart_pkg::uart_axil_aw_chan_t),
      .w_chan_t   (s1_uart_pkg::uart_axil_w_chan_t),
      .b_chan_t   (s1_uart_pkg::uart_axil_b_chan_t),
      .ar_chan_t  (s1_uart_pkg::uart_axil_ar_chan_t),
      .r_chan_t   (s1_uart_pkg::uart_axil_r_chan_t),
      .axi_req_t  (s1_uart_pkg::uart_axil_req_t),
      .axi_resp_t (s1_uart_pkg::uart_axil_resp_t)
  ) u_axi_fifo (
      .clk_i     (clk_i),
      .rst_ni    (arst_ni),
      .test_i    ('0),
      .slv_req_i (req_i),
      .slv_resp_o(resp_o),
      .mst_req_o (fifo_req),
      .mst_resp_i(fifo_resp)
  );

  s1_fifo #(
      .PIPELINED (1),
      .DATA_WIDTH($bits(tx_id_queue_in)),
      .FIFO_SIZE (3)
  ) tx_id_queue (
      .clk_i           (clk_i),
      .arst_ni         (arst_ni),
      .data_in_i       (tx_id_queue_in),
      .data_in_valid_i (tx_id_queue_in_valid),
      .data_in_ready_o (tx_id_queue_in_ready),
      .data_out_o      (tx_id_queue_out),
      .data_out_valid_o(tx_id_queue_out_valid),
      .data_out_ready_i(tx_id_queue_out_ready)
  );

  s1_fifo #(
      .PIPELINED (1),
      .DATA_WIDTH($bits(rx_id_queue_in)),
      .FIFO_SIZE (3)
  ) rx_id_queue (
      .clk_i           (clk_i),
      .arst_ni         (arst_ni),
      .data_in_i       (rx_id_queue_in),
      .data_in_valid_i (rx_id_queue_in_valid),
      .data_in_ready_o (rx_id_queue_in_ready),
      .data_out_o      (rx_id_queue_out),
      .data_out_valid_o(rx_id_queue_out_valid),
      .data_out_ready_i(rx_id_queue_out_ready)
  );

endmodule
