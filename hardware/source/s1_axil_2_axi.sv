module s1_axil_to_axi #(
    parameter type axil_req_t  = logic,
    parameter type axil_resp_t = logic,
    parameter type axi_req_t   = logic,
    parameter type axi_resp_t  = logic
) (
    input  axil_req_t  axil_req_i,
    output axil_resp_t axil_resp_o,
    output axi_req_t   axi_req_o,
    input  axi_resp_t  axi_resp_i
);

  always_comb begin
    axi_req_o          = '0;
    axi_req_o.aw.addr  = axil_req_i.aw.addr;
    axi_req_o.aw.size  = $clog2($bits(axil_req_i.w.data) / 8);
    axi_req_o.aw.burst = 2'b01;
    axi_req_o.aw.prot  = axil_req_i.aw.prot;
    axi_req_o.aw_valid = axil_req_i.aw_valid;
    axi_req_o.w.data   = axil_req_i.w.data;
    axi_req_o.w.strb   = axil_req_i.w.strb;
    axi_req_o.w.last   = 1'b1;
    axi_req_o.w_valid  = axil_req_i.w_valid;
    axi_req_o.b_ready  = axil_req_i.b_ready;
    axi_req_o.ar.addr  = axil_req_i.ar.addr;
    axi_req_o.ar.size  = $clog2($bits(axil_req_i.w.data) / 8);
    axi_req_o.ar.burst = 2'b01;
    axi_req_o.ar.prot  = axil_req_i.ar.prot;
    axi_req_o.ar_valid = axil_req_i.ar_valid;
    axi_req_o.r_ready  = axil_req_i.r_ready;
  end

  always_comb begin
    axil_resp_o          = '0;
    axil_resp_o.aw_ready = axi_resp_i.aw_ready;
    axil_resp_o.w_ready  = axi_resp_i.w_ready;
    axil_resp_o.b.resp   = axi_resp_i.b.resp;
    axil_resp_o.b_valid  = axi_resp_i.b_valid;
    axil_resp_o.ar_ready = axi_resp_i.ar_ready;
    axil_resp_o.r.data   = axi_resp_i.r.data;
    axil_resp_o.r_valid  = axi_resp_i.r_valid;
  end

endmodule
