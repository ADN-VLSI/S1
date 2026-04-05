module s1_axil_2_apb #(
    parameter int  ADDR_WIDTH = 32,
    parameter int  DATA_WIDTH = 32,
    parameter type apb_req_t  = logic,
    parameter type apb_resp_t = logic,
    parameter type aw_chan_t  = logic,
    parameter type w_chan_t   = logic,
    parameter type b_chan_t   = logic,
    parameter type ar_chan_t  = logic,
    parameter type r_chan_t   = logic,
    parameter type axi_req_t  = logic,
    parameter type axi_resp_t = logic
) (

    ////////////////////////////////////////////////////////////////////////////////////////////////
    // APB Slave Interface
    ////////////////////////////////////////////////////////////////////////////////////////////////

    input  logic      apb_clk_i,
    input  logic      apb_arst_ni,
    output apb_req_t  apb_req_o,
    input  apb_resp_t apb_resp_i,

    ////////////////////////////////////////////////////////////////////////////////////////////////
    // AXI4-Lite Master Interface Outputs
    ////////////////////////////////////////////////////////////////////////////////////////////////

    input  logic      axi_clk_i,
    input  logic      axi_arst_ni,
    input  axi_req_t  axi_req_i,
    output axi_resp_t axi_resp_o

);

  axi_req_t intr_axi_req;
  axi_resp_t intr_axi_resp;

  logic cst_arst_n;

  always_comb cst_arst_n = apb_arst_ni & axi_arst_ni;

  axi_cdc #(
      .aw_chan_t (aw_chan_t),
      .w_chan_t  (w_chan_t),
      .b_chan_t  (b_chan_t),
      .ar_chan_t (ar_chan_t),
      .r_chan_t  (r_chan_t),
      .axi_req_t (axi_req_t),
      .axi_resp_t(axi_resp_t),
      .LogDepth  (2),
      .SyncStages(2)
  ) u_axi_cdc (
      .src_clk_i (axi_clk_i),
      .src_rst_ni(cst_arst_n),
      .src_req_i (axi_req_i),
      .src_resp_o(axi_resp_o),
      .dst_clk_i (apb_clk_i),
      .dst_rst_ni(cst_arst_n),
      .dst_req_o (intr_axi_req),
      .dst_resp_i(intr_axi_resp)
  );

  typedef enum int {
    IDLE,
    SETUP,
    SEND_AW,
    SEND_W,
    RECV_B,
    SEND_AR,
    RECV_R,
    ACCESS
  } state_t;

  state_t current_state;
  state_t next_state;

  always_ff @(posedge apb_clk_i or negedge cst_arst_n) begin
    if (~cst_arst_n) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  // TODO FSM

endmodule
