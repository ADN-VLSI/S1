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
    // AXI4-Lite Slave Interface
    ////////////////////////////////////////////////////////////////////////////////////////////////

    input  logic      axi_clk_i,
    input  logic      axi_arst_ni,
    input  axi_req_t  axi_req_i,
    output axi_resp_t axi_resp_o,

    ////////////////////////////////////////////////////////////////////////////////////////////////
    // APB Master Interface
    ////////////////////////////////////////////////////////////////////////////////////////////////

    input  logic      apb_clk_i,
    input  logic      apb_arst_ni,
    output apb_req_t  apb_req_o,
    input  apb_resp_t apb_resp_i

);

  axi_req_t intr_axi_req;
  axi_resp_t intr_axi_resp;

  logic cst_arst_n;

  always_comb cst_arst_n = apb_arst_ni & axi_arst_ni;

  logic write_possible;
  logic read_possible;

  always_comb begin
    write_possible = intr_axi_req.aw_valid & intr_axi_req.w_valid & intr_axi_req.b_ready;
    read_possible  = intr_axi_req.ar_valid & intr_axi_req.r_ready;
  end

  logic priority_to_write;
  logic next_priority_to_write;

  logic do_write;
  logic next_do_write;

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
      current_state     <= IDLE;
      priority_to_write <= '0;
      do_write          <= '0;
    end else begin
      current_state     <= next_state;
      priority_to_write <= next_priority_to_write;
      do_write          <= next_do_write;
    end
  end

  always_comb begin

    apb_req_o.psel = '0;
    apb_req_o.penable = '0;
    apb_req_o.paddr = do_write ? intr_axi_req.aw.addr : intr_axi_req.ar.addr;
    apb_req_o.pprot = do_write ? intr_axi_req.aw.prot : intr_axi_req.ar.prot;
    apb_req_o.pwrite = do_write;
    apb_req_o.pwdata = intr_axi_req.w.data;
    apb_req_o.pstrb = intr_axi_req.w.strb;

    intr_axi_resp.b.resp = {apb_resp_i.pslverr, 1'b0};
    intr_axi_resp.r.data = apb_resp_i.prdata;
    intr_axi_resp.r.resp = {apb_resp_i.pslverr, 1'b0};

    next_state = current_state;
    next_priority_to_write = priority_to_write;
    next_do_write = do_write;

    intr_axi_resp.aw_ready = '0;
    intr_axi_resp.w_ready = '0;
    intr_axi_resp.b_valid = '0;
    intr_axi_resp.ar_ready = '0;
    intr_axi_resp.r_valid = '0;

    case (current_state)

      IDLE: begin
        case ({
          write_possible, read_possible
        })

          2'b01: begin
            next_state = SETUP;
            next_do_write = '0;
            next_priority_to_write = '1;
          end

          2'b10: begin
            next_state = SETUP;
            next_do_write = '1;
            next_priority_to_write = '0;
          end

          2'b11: begin
            next_state = SETUP;
            next_do_write = priority_to_write;
            next_priority_to_write = ~priority_to_write;
          end

          default: begin
          end

        endcase
      end

      SETUP: begin
        apb_req_o.psel    = '1;
        next_state = ACCESS;
      end

      ACCESS: begin
        apb_req_o.psel    = '1;
        apb_req_o.penable = '1;
        if (apb_resp_i.pready) begin
          next_state = IDLE;
          if (do_write) begin
            intr_axi_resp.aw_ready = '1;
            intr_axi_resp.w_ready  = '1;
            intr_axi_resp.b_valid  = '1;
          end else begin
            intr_axi_resp.ar_ready = '1;
            intr_axi_resp.r_valid  = '1;
          end
        end
      end

      default: begin
      end

    endcase

  end

endmodule
