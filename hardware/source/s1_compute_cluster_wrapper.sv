module s1_compute_cluster_wrapper (
    input logic arst_cc1_ni,
    input logic arst_cc2_ni,
    input logic arst_cc3_ni,
    input logic arst_cnoc_ni,

    input logic clk_cc1_i,
    input logic clk_cc2_i,
    input logic clk_cc3_i,

    input logic pclk_cc1_i,
    input logic pclk_cc2_i,
    input logic pclk_cc3_i,

    input logic clk_cnoc_i,
    input logic clk_snoc_i,

    input logic [63:0] p1_boot_addr_i,
    input logic [63:0] p1_hart_id_i,
    input logic        p1_mei_i,
    input logic        p1_msi_i,
    input logic        p1_mti_i,

    input logic [63:0] p2_boot_addr_i,
    input logic [63:0] p2_hart_id_i,
    input logic        p2_mei_i,
    input logic        p2_msi_i,
    input logic        p2_mti_i,

    input logic [31:0] e3_boot_addr_i,
    input logic [31:0] e3_hart_id_i,
    input logic        e3_mei_i,
    input logic        e3_msi_i,
    input logic        e3_mti_i,

    input  s1_soc_pkg::snoc_mp_req_t  snoc_mp_req_i,
    output s1_soc_pkg::snoc_mp_resp_t snoc_mp_resp_o,

    output s1_soc_pkg::snoc_sp_req_t  snoc_sp_req_o,
    input  s1_soc_pkg::snoc_sp_resp_t snoc_sp_resp_i
);

  s1_pcss_pkg::mp_req_t            p1_mp_req;
  s1_pcss_pkg::mp_resp_t           p1_mp_resp;
  s1_pcss_pkg::sp_req_t            p1_sp_req;
  s1_pcss_pkg::sp_resp_t           p1_sp_resp;
  s1_pcss_pkg::mp_req_t            p2_mp_req;
  s1_pcss_pkg::mp_resp_t           p2_mp_resp;
  s1_pcss_pkg::sp_req_t            p2_sp_req;
  s1_pcss_pkg::sp_resp_t           p2_sp_resp;
  s1_ecss_pkg::mp_req_t            e3_mp_req;
  s1_ecss_pkg::mp_resp_t           e3_mp_resp;
  s1_ecss_pkg::sp_req_t            e3_sp_req;
  s1_ecss_pkg::sp_resp_t           e3_sp_resp;

  s1_soc_pkg::cnoc_sp_req_t  [3:0] cnoc_sp_req;
  s1_soc_pkg::cnoc_sp_resp_t [3:0] cnoc_sp_resp;

  s1_soc_pkg::cnoc_mp_req_t  [3:0] cnoc_mp_req;
  s1_soc_pkg::cnoc_mp_resp_t [3:0] cnoc_mp_resp;

  s1_pcss pcss1 (
      .arst_ni(arst_cc1_ni),
      .clk_i(clk_cc1_i),
      .pclk_i(pclk_cc1_i),
      .boot_addr_i(p1_boot_addr_i),
      .hart_id_i(p1_hart_id_i),
      .mei_i(p1_mei_i),
      .msi_i(p1_msi_i),
      .mti_i(p1_mti_i),
      .m_req_o(p1_mp_req),
      .m_resp_i(p1_mp_resp),
      .s_req_i(p1_sp_req),
      .s_resp_o(p1_sp_resp)
  );

  s1_pcss pcss2 (
      .arst_ni(arst_cc2_ni),
      .clk_i(clk_cc2_i),
      .pclk_i(pclk_cc2_i),
      .boot_addr_i(p2_boot_addr_i),
      .hart_id_i(p2_hart_id_i),
      .mei_i(p2_mei_i),
      .msi_i(p2_msi_i),
      .mti_i(p2_mti_i),
      .m_req_o(p2_mp_req),
      .m_resp_i(p2_mp_resp),
      .s_req_i(p2_sp_req),
      .s_resp_o(p2_sp_resp)
  );

  s1_ecss ecss (
      .arst_ni(arst_cc3_ni),
      .clk_i(clk_cc3_i),
      .pclk_i(pclk_cc3_i),
      .boot_addr_i(e3_boot_addr_i),
      .hart_id_i(e3_hart_id_i),
      .mei_i(e3_mei_i),
      .msi_i(e3_msi_i),
      .mti_i(e3_mti_i),
      .m_req_o(e3_mp_req),
      .m_resp_i(e3_mp_resp),
      .s_req_i(e3_sp_req),
      .s_resp_o(e3_sp_resp)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_pcss_pkg::mp_req_t),
      .src_resp_t(s1_pcss_pkg::mp_resp_t),
      .dst_req_t (s1_soc_pkg::cnoc_sp_req_t),
      .dst_resp_t(s1_soc_pkg::cnoc_sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) p1_conc_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_cc1_i),
      .src_req_i   (p1_mp_req),
      .src_resp_o  (p1_mp_resp),
      .dst_clk_i   (clk_cnoc_i),
      .dst_req_o   (cnoc_sp_req[1]),
      .dst_resp_i  (cnoc_sp_resp[1]),
      .addr_shift_i('0)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_soc_pkg::cnoc_mp_req_t),
      .src_resp_t(s1_soc_pkg::cnoc_mp_resp_t),
      .dst_req_t (s1_pcss_pkg::sp_req_t),
      .dst_resp_t(s1_pcss_pkg::sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) cnoc_p1_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_cnoc_i),
      .src_req_i   (cnoc_mp_req[1]),
      .src_resp_o  (cnoc_mp_resp[1]),
      .dst_clk_i   (clk_cc1_i),
      .dst_req_o   (p1_sp_req),
      .dst_resp_i  (p1_sp_resp),
      .addr_shift_i('0)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_pcss_pkg::mp_req_t),
      .src_resp_t(s1_pcss_pkg::mp_resp_t),
      .dst_req_t (s1_soc_pkg::cnoc_sp_req_t),
      .dst_resp_t(s1_soc_pkg::cnoc_sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) p2_conc_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_cc2_i),
      .src_req_i   (p2_mp_req),
      .src_resp_o  (p2_mp_resp),
      .dst_clk_i   (clk_cnoc_i),
      .dst_req_o   (cnoc_sp_req[2]),
      .dst_resp_i  (cnoc_sp_resp[2]),
      .addr_shift_i('0)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_soc_pkg::cnoc_mp_req_t),
      .src_resp_t(s1_soc_pkg::cnoc_mp_resp_t),
      .dst_req_t (s1_pcss_pkg::sp_req_t),
      .dst_resp_t(s1_pcss_pkg::sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) cnoc_p2_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_cnoc_i),
      .src_req_i   (cnoc_mp_req[2]),
      .src_resp_o  (cnoc_mp_resp[2]),
      .dst_clk_i   (clk_cc2_i),
      .dst_req_o   (p2_sp_req),
      .dst_resp_i  (p2_sp_resp),
      .addr_shift_i('0)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_ecss_pkg::mp_req_t),
      .src_resp_t(s1_ecss_pkg::mp_resp_t),
      .dst_req_t (s1_soc_pkg::cnoc_sp_req_t),
      .dst_resp_t(s1_soc_pkg::cnoc_sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) e3_conc_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_cc3_i),
      .src_req_i   (e3_mp_req),
      .src_resp_o  (e3_mp_resp),
      .dst_clk_i   (clk_cnoc_i),
      .dst_req_o   (cnoc_sp_req[3]),
      .dst_resp_i  (cnoc_sp_resp[3]),
      .addr_shift_i('0)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_soc_pkg::cnoc_mp_req_t),
      .src_resp_t(s1_soc_pkg::cnoc_mp_resp_t),
      .dst_req_t (s1_ecss_pkg::sp_req_t),
      .dst_resp_t(s1_ecss_pkg::sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) cnoc_e3_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_cnoc_i),
      .src_req_i   (cnoc_mp_req[3]),
      .src_resp_o  (cnoc_mp_resp[3]),
      .dst_clk_i   (clk_cc3_i),
      .dst_req_o   (e3_sp_req),
      .dst_resp_i  (e3_sp_resp),
      .addr_shift_i('0)
  );

  axi_xbar #(
      .Cfg          (s1_soc_pkg::cnoc_xbar_cfg),
      .ATOPs        ('0),
      .Connectivity ('1),
      .slv_aw_chan_t(s1_soc_pkg::cnoc_sp_aw_chan_t),
      .mst_aw_chan_t(s1_soc_pkg::cnoc_mp_aw_chan_t),
      .w_chan_t     (s1_soc_pkg::cnoc_sp_w_chan_t),
      .slv_b_chan_t (s1_soc_pkg::cnoc_sp_b_chan_t),
      .mst_b_chan_t (s1_soc_pkg::cnoc_mp_b_chan_t),
      .slv_ar_chan_t(s1_soc_pkg::cnoc_sp_ar_chan_t),
      .mst_ar_chan_t(s1_soc_pkg::cnoc_mp_ar_chan_t),
      .slv_r_chan_t (s1_soc_pkg::cnoc_sp_r_chan_t),
      .mst_r_chan_t (s1_soc_pkg::cnoc_mp_r_chan_t),
      .slv_req_t    (s1_soc_pkg::cnoc_sp_req_t),
      .slv_resp_t   (s1_soc_pkg::cnoc_sp_resp_t),
      .mst_req_t    (s1_soc_pkg::cnoc_mp_req_t),
      .mst_resp_t   (s1_soc_pkg::cnoc_mp_resp_t),
      .rule_t       (axi_pkg::xbar_rule_64_t)
  ) cnoc (
      .clk_i                (clk_cnoc_i),
      .rst_ni               (arst_cnoc_ni),
      .test_i               ('0),
      .slv_ports_req_i      (cnoc_sp_req),
      .slv_ports_resp_o     (cnoc_sp_resp),
      .mst_ports_req_o      (cnoc_mp_req),
      .mst_ports_resp_i     (cnoc_mp_resp),
      .addr_map_i           (s1_soc_pkg::CnocXbarRule),
      .en_default_mst_port_i('1),
      .default_mst_port_i   ('0)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_soc_pkg::snoc_mp_req_t),
      .src_resp_t(s1_soc_pkg::snoc_mp_resp_t),
      .dst_req_t (s1_soc_pkg::cnoc_sp_req_t),
      .dst_resp_t(s1_soc_pkg::cnoc_sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) snoc_conc_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_snoc_i),
      .src_req_i   (snoc_mp_req_i),
      .src_resp_o  (snoc_mp_resp_o),
      .dst_clk_i   (clk_cnoc_i),
      .dst_req_o   (cnoc_sp_req[0]),
      .dst_resp_i  (cnoc_sp_resp[0]),
      .addr_shift_i('0)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_soc_pkg::cnoc_mp_req_t),
      .src_resp_t(s1_soc_pkg::cnoc_mp_resp_t),
      .dst_req_t (s1_soc_pkg::snoc_sp_req_t),
      .dst_resp_t(s1_soc_pkg::snoc_sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) cnoc_snoc_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_cnoc_i),
      .src_req_i   (cnoc_mp_req[0]),
      .src_resp_o  (cnoc_mp_resp[0]),
      .dst_clk_i   (clk_snoc_i),
      .dst_req_o   (snoc_sp_req_o),
      .dst_resp_i  (snoc_sp_resp_i),
      .addr_shift_i('0)
  );

endmodule
