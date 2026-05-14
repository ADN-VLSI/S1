module s1_obi_2_axil #(
    parameter int  OBI_ADDRW   = 32,
    parameter int  OBI_DATAW   = 32,
    parameter type axil_req_t  = logic,
    parameter type axil_resp_t = logic
) (

    input logic clk_i,
    input logic arst_ni,

    input  logic [    OBI_ADDRW-1:0] addr_i,
    input  logic                     we_i,
    input  logic [    OBI_DATAW-1:0] wdata_i,
    input  logic [OBI_DATAW / 8-1:0] be_i,
    input  logic                     req_i,
    output logic                     gnt_o,

    output logic                 rvalid_o,
    output logic [OBI_DATAW-1:0] rdata_o,

    output axil_req_t  axil_req_o,
    input  axil_resp_t axil_resp_i
);

  logic [    OBI_ADDRW-1:0] addr_i_;
  logic                     we_i_;
  logic [    OBI_DATAW-1:0] wdata_i_;
  logic [OBI_DATAW / 8-1:0] be_i_;
  logic                     req_i_;
  logic                     gnt_o_;

  s1_fifo #(
      .PIPELINED (1),
      .DATA_WIDTH(OBI_ADDRW + 1 + OBI_DATAW + OBI_DATAW / 8),
      .FIFO_SIZE (1)
  ) u_fifo (
      .clk_i           (clk_i),
      .arst_ni         (arst_ni),
      .data_in_i       ({addr_i, we_i, wdata_i, be_i}),
      .data_in_valid_i (req_i),
      .data_in_ready_o (gnt_o),
      .data_out_o      ({addr_i_, we_i_, wdata_i_, be_i_}),
      .data_out_valid_o(req_i_),
      .data_out_ready_i(gnt_o_)
  );

  typedef enum {
    IDLE,
    SEND_AR,
    RECV_R,
    SEND_AW,
    SEND_W,
    RECV_B
  } state_t;

  state_t current_state;
  state_t next_state;

  always_comb begin
    next_state          = current_state;
    axil_req_o          = '0;
    axil_req_o.aw.addr  = addr_i_;
    axil_req_o.ar.addr  = addr_i_;
    axil_req_o.w.data   = wdata_i_;
    axil_req_o.w.strb   = be_i_;
    rdata_o             = axil_resp_i.r.data;
    gnt_o_              = '0;
    rvalid_o            = '0;
    axil_req_o.ar_valid = '0;
    axil_req_o.r_ready  = '0;
    axil_req_o.aw_valid = '0;
    axil_req_o.w_valid  = '0;
    axil_req_o.b_ready  = '0;

    case (current_state)

      IDLE: begin
        if (req_i_) begin
          next_state = we_i_ ? SEND_AW : SEND_AR;
        end
      end

      SEND_AR: begin
        axil_req_o.ar_valid = '1;
        if (axil_resp_i.ar_ready) begin
          next_state = RECV_R;
        end
      end

      RECV_R: begin
        axil_req_o.r_ready = '1;
        if (axil_resp_i.r_valid) begin
          next_state = IDLE;
          gnt_o_     = '1;
          rvalid_o   = '1;
          rdata_o    = axil_resp_i.r.data;
        end
      end

      SEND_AW: begin
        axil_req_o.aw_valid = '1;
        if (axil_resp_i.aw_ready) begin
          next_state = SEND_W;
        end
      end

      SEND_W: begin
        axil_req_o.w_valid = '1;
        if (axil_resp_i.w_ready) begin
          next_state = RECV_B;
        end
      end

      RECV_B: begin
        axil_req_o.b_ready = '1;
        if (axil_resp_i.b_valid) begin
          next_state = IDLE;
          gnt_o_     = '1;
          rvalid_o   = '1;
        end
      end

      default: begin
      end
    endcase
  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

endmodule
