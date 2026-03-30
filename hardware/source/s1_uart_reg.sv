module s1_uart_reg
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
  import s1_uart_pkg::uart_ctrl_reg_t;
  import s1_uart_pkg::uart_cfg_reg_t;
  import s1_uart_pkg::uart_stat_reg_t;
#(
    // type of the AXI request
    parameter type axi_req_t  = axi_default_param_pkg::axi4l_req_t,
    // type of the AXI response
    parameter type axi_resp_t = axi_default_param_pkg::axi4l_resp_t
) (
    // clock input
    input logic clk_i,
    // asynchronous active low reset input
    input logic arst_ni,

    // AXI request input
    input  axi_req_t  req_i,
    // AXI response output
    output axi_resp_t resp_o,

    output uart_ctrl_reg_t uart_ctrl_o,
    output uart_cfg_reg_t  uart_cfg_o,
    output uart_stat_reg_t uart_stat_o,

    output logic [7:0] tx_data_o,
    output logic       tx_data_valid_o,
    input  logic       tx_data_ready_i,
    input  logic       tx_data_cnt_i,

    input  logic [7:0] rx_data_i,
    input  logic       rx_data_valid_i,
    output logic       rx_data_ready_o,
    input  logic       rx_data_cnt_i,

    output logic uart_int_o
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // IMPORTS
  //////////////////////////////////////////////////////////////////////////////////////////////////



  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // AXI request input
  axi_req_t fifo_req;
  // AXI response output
  axi_resp_t fifo_resp;

  logic write_en;
  logic read_en;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // COMBINATIONAL LOGICS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always_comb begin
    logic awaddr_ok;
    logic possible;

    awaddr_ok = 0;
    possible   = 0;

    if (fifo_req.aw.addr inside {
        UART_CTRL_OFFSET,
        UART_CFG_OFFSET,
        UART_TXR_OFFSET,
        UART_TXD_OFFSET,
        UART_RXR_OFFSET,
        UART_INT_OFFSET})
      awaddr_ok = 1;

    case (fifo_req.aw.addr == )
      UART_CFG_OFFSET: if (tx_data_cnt_i == 0 && rx_data_cnt_i == 0) possible = 1;
      default:                                                       possible = 1;
    endcase

    write_en = 1'b0;
  end

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SUBMODULES
  //////////////////////////////////////////////////////////////////////////////////////////////////

  axi_fifo #(
      .axi_req_t    (axi_req_t),
      .axi_resp_t   (axi_resp_t),
      .AW_FIFO_DEPTH(2),
      .W_FIFO_DEPTH (2),
      .B_FIFO_DEPTH (2),
      .AR_FIFO_DEPTH(2),
      .R_FIFO_DEPTH (2)
  ) u_axi_fifo (
      .clk_i  (clk_i),
      .arst_ni(arst_ni),
      .req_i  (req_i),
      .resp_o (resp_o),
      .req_o  (fifo_req),
      .resp_i (fifo_resp)
  );


endmodule
