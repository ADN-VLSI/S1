module s1_soc
  import s1_soc_pkg::std_apb_req_t;
  import s1_soc_pkg::std_apb_resp_t;
(
    input logic temp_arst_snoc_ni,
    input logic temp_arst_periph_ni,
    input logic temp_clk_snoc_i,
    input logic temp_clk_periph_i,

    ////////////////////////////////////////////////

    input logic global_arst_ni,
    input logic xtal_16MHz_i,

    input  logic          apb_s_clk_i,
    input  logic          apb_s_arst_ni,
    input  std_apb_req_t  apb_s_req_i,
    output std_apb_resp_t apb_s_resp_o,

    output logic          apb_m_clk_o,
    output logic          apb_m_arst_no,
    output std_apb_req_t  apb_m_req_o,
    input  std_apb_resp_t apb_m_resp_i
);

  always_comb begin  // TODO REMOVE
    apb_m_clk_o   = apb_s_clk_i;
    apb_m_arst_no = apb_s_arst_ni;
    apb_m_req_o   = apb_s_req_i;
    apb_s_resp_o  = apb_m_resp_i;
  end

endmodule
