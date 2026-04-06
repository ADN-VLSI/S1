module s1 (
    input logic temp_arst_snoc_ni,
    input logic temp_arst_periph_ni,
    input logic temp_clk_snoc_i,
    input logic temp_clk_periph_i,

    input  logic      apb_s_clk_i,
    input  logic      apb_s_arst_ni,
    input  apb_req_t  apb_s_req_i,
    output apb_resp_t apb_s_resp_o,

    output logic      apb_m_clk_o,
    output logic      apb_m_arst_no,
    output apb_req_t  apb_m_req_o,
    input  apb_resp_t apb_m_resp_i
);



endmodule
