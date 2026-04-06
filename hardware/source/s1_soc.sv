module s1_soc
  import s1_soc_pkg::std_apb_req_t;
  import s1_soc_pkg::std_apb_resp_t;

  import s1_soc_pkg::AXIL_ADDR_WIDTH;
  import s1_soc_pkg::AXIL_DATA_WIDTH;
  import s1_soc_pkg::std_axil_aw_chan_t;
  import s1_soc_pkg::std_axil_w_chan_t;
  import s1_soc_pkg::std_axil_b_chan_t;
  import s1_soc_pkg::std_axil_ar_chan_t;
  import s1_soc_pkg::std_axil_r_chan_t;
  import s1_soc_pkg::std_axil_req_t;
  import s1_soc_pkg::std_axil_resp_t;
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
  end

  std_axil_req_t  intr_axil_req;  // TODO REMOVE
  std_axil_resp_t intr_axil_resp;  // TODO REMOVE

  s1_apb_2_axil #(
      .ADDR_WIDTH(AXIL_ADDR_WIDTH),
      .DATA_WIDTH(AXIL_DATA_WIDTH),
      .apb_req_t (std_apb_req_t),
      .apb_resp_t(std_apb_resp_t),
      .aw_chan_t (std_axil_aw_chan_t),
      .w_chan_t  (std_axil_w_chan_t),
      .b_chan_t  (std_axil_b_chan_t),
      .ar_chan_t (std_axil_ar_chan_t),
      .r_chan_t  (std_axil_r_chan_t),
      .axi_req_t (std_axil_req_t),
      .axi_resp_t(std_axil_resp_t)
  ) apb_slave_in (
      .apb_clk_i  (apb_s_clk_i),
      .apb_arst_ni(apb_s_arst_ni),
      .apb_req_i  (apb_s_req_i),
      .apb_resp_o (apb_s_resp_o),
      .axi_clk_i  (temp_clk_snoc_i),
      .axi_arst_ni(temp_arst_snoc_ni),
      .axi_req_o  (intr_axil_req),
      .axi_resp_i (intr_axil_resp)
  );

  s1_axil_2_apb #(
      .ADDR_WIDTH(AXIL_ADDR_WIDTH),
      .DATA_WIDTH(AXIL_DATA_WIDTH),
      .apb_req_t (std_apb_req_t),
      .apb_resp_t(std_apb_resp_t),
      .aw_chan_t (std_axil_aw_chan_t),
      .w_chan_t  (std_axil_w_chan_t),
      .b_chan_t  (std_axil_b_chan_t),
      .ar_chan_t (std_axil_ar_chan_t),
      .r_chan_t  (std_axil_r_chan_t),
      .axi_req_t (std_axil_req_t),
      .axi_resp_t(std_axil_resp_t)
  ) apb_master_out (
      .axi_clk_i  (temp_clk_snoc_i),
      .axi_arst_ni(temp_arst_snoc_ni),
      .axi_req_i  (intr_axil_req),
      .axi_resp_o (intr_axil_resp),
      .apb_clk_i  (apb_m_clk_o),
      .apb_arst_ni(apb_m_arst_no),
      .apb_req_o  (apb_m_req_o),
      .apb_resp_i (apb_m_resp_i)
  );

endmodule
