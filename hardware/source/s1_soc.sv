module s1_soc
  import axi_pkg::xbar_rule_64_t;
  import s1_soc_pkg::AXI_ADDR_WIDTH;
  import s1_soc_pkg::AXI_DATA_WIDTH;
  import s1_soc_pkg::AXI_ID_WIDTH;
  import s1_soc_pkg::AXI_USER_WIDTH;
  import s1_soc_pkg::AXIL_ADDR_WIDTH;
  import s1_soc_pkg::AXIL_DATA_WIDTH;
  import s1_soc_pkg::cnoc_mp_ar_chan_t;
  import s1_soc_pkg::cnoc_mp_aw_chan_t;
  import s1_soc_pkg::cnoc_mp_b_chan_t;
  import s1_soc_pkg::cnoc_mp_r_chan_t;
  import s1_soc_pkg::cnoc_mp_req_t;
  import s1_soc_pkg::cnoc_mp_resp_t;
  import s1_soc_pkg::cnoc_mp_w_chan_t;
  import s1_soc_pkg::cnoc_sp_ar_chan_t;
  import s1_soc_pkg::cnoc_sp_aw_chan_t;
  import s1_soc_pkg::cnoc_sp_b_chan_t;
  import s1_soc_pkg::cnoc_sp_r_chan_t;
  import s1_soc_pkg::cnoc_sp_req_t;
  import s1_soc_pkg::cnoc_sp_resp_t;
  import s1_soc_pkg::cnoc_sp_w_chan_t;
  import s1_soc_pkg::cnoc_xbar_cfg;
  import s1_soc_pkg::CnocXbarRule;
  import s1_soc_pkg::pnoc_mp_req_t;
  import s1_soc_pkg::pnoc_mp_resp_t;
  import s1_soc_pkg::pnoc_sp_ar_chan_t;
  import s1_soc_pkg::pnoc_sp_aw_chan_t;
  import s1_soc_pkg::pnoc_sp_b_chan_t;
  import s1_soc_pkg::pnoc_sp_r_chan_t;
  import s1_soc_pkg::pnoc_sp_req_t;
  import s1_soc_pkg::pnoc_sp_resp_t;
  import s1_soc_pkg::pnoc_sp_w_chan_t;
  import s1_soc_pkg::pnoc_xbar_cfg;
  import s1_soc_pkg::PnocXbarRule;
  import s1_soc_pkg::snoc_mp_ar_chan_t;
  import s1_soc_pkg::snoc_mp_aw_chan_t;
  import s1_soc_pkg::snoc_mp_b_chan_t;
  import s1_soc_pkg::snoc_mp_r_chan_t;
  import s1_soc_pkg::snoc_mp_req_t;
  import s1_soc_pkg::snoc_mp_resp_t;
  import s1_soc_pkg::snoc_mp_w_chan_t;
  import s1_soc_pkg::snoc_mpn_ar_chan_t;
  import s1_soc_pkg::snoc_mpn_aw_chan_t;
  import s1_soc_pkg::snoc_mpn_b_chan_t;
  import s1_soc_pkg::snoc_mpn_r_chan_t;
  import s1_soc_pkg::snoc_mpn_req_t;
  import s1_soc_pkg::snoc_mpn_resp_t;
  import s1_soc_pkg::snoc_mpn_w_chan_t;
  import s1_soc_pkg::snoc_sp_ar_chan_t;
  import s1_soc_pkg::snoc_sp_aw_chan_t;
  import s1_soc_pkg::snoc_sp_b_chan_t;
  import s1_soc_pkg::snoc_sp_r_chan_t;
  import s1_soc_pkg::snoc_sp_req_t;
  import s1_soc_pkg::snoc_sp_resp_t;
  import s1_soc_pkg::snoc_sp_w_chan_t;
  import s1_soc_pkg::snoc_spn_ar_chan_t;
  import s1_soc_pkg::snoc_spn_aw_chan_t;
  import s1_soc_pkg::snoc_spn_b_chan_t;
  import s1_soc_pkg::snoc_spn_r_chan_t;
  import s1_soc_pkg::snoc_spn_req_t;
  import s1_soc_pkg::snoc_spn_resp_t;
  import s1_soc_pkg::snoc_spn_w_chan_t;
  import s1_soc_pkg::snoc_xbar_cfg;
  import s1_soc_pkg::SnocXbarRule;
  import s1_soc_pkg::std_apb_req_t;
  import s1_soc_pkg::std_apb_resp_t;
  import s1_soc_pkg::std_axi_req_t;
  import s1_soc_pkg::std_axi_resp_t;
  import s1_soc_pkg::std_axil_ar_chan_t;
  import s1_soc_pkg::std_axil_aw_chan_t;
  import s1_soc_pkg::std_axil_b_chan_t;
  import s1_soc_pkg::std_axil_r_chan_t;
  import s1_soc_pkg::std_axil_req_t;
  import s1_soc_pkg::std_axil_resp_t;
  import s1_soc_pkg::std_axil_w_chan_t;
(

    input logic temp_arst_cc1_ni,
    input logic temp_clk_cc1_i,
    input logic temp_pclk_cc1_i,

    input logic temp_arst_cc2_ni,
    input logic temp_clk_cc2_i,
    input logic temp_pclk_cc2_i,

    input logic temp_arst_cc3_ni,
    input logic temp_clk_cc3_i,
    input logic temp_pclk_cc3_i,

    input logic temp_arst_cnoc_ni,
    input logic temp_clk_cnoc_i,

    input logic temp_arst_snoc_ni,
    input logic temp_clk_snoc_i,

    input logic temp_arst_pnoc_ni,
    input logic temp_clk_pnoc_i,

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
    input  std_apb_resp_t apb_m_resp_i,

    output logic uart_tx_o,
    input  logic uart_rx_i
);

  logic                               arst_cc1_ni;
  logic                               arst_cc2_ni;
  logic                               arst_cc3_ni;
  logic                               arst_cnoc_ni;
  logic                               arst_snoc_ni;
  logic                               arst_pnoc_ni;

  logic                               clk_cc1_i;
  logic                               clk_cc2_i;
  logic                               clk_cc3_i;

  logic                               pclk_cc1_i;
  logic                               pclk_cc2_i;
  logic                               pclk_cc3_i;

  logic                               clk_cnoc_i;
  logic                               clk_snoc_i;
  logic                               clk_pnoc_i;

  std_axil_req_t                      asi_asin_req;
  std_axil_resp_t                     asi_asin_resp;
  snoc_spn_req_t                      asin_asiw_req;
  snoc_spn_resp_t                     asin_asiw_resp;

  snoc_mpn_req_t                      snocn_snocl_req;
  snoc_mpn_resp_t                     snocn_snocl_resp;

  s1_pcss_pkg::mp_req_t               p1_mp_req;
  s1_pcss_pkg::mp_resp_t              p1_mp_resp;
  s1_pcss_pkg::sp_req_t               p1_sp_req;
  s1_pcss_pkg::sp_resp_t              p1_sp_resp;
  s1_pcss_pkg::mp_req_t               p2_mp_req;
  s1_pcss_pkg::mp_resp_t              p2_mp_resp;
  s1_pcss_pkg::sp_req_t               p2_sp_req;
  s1_pcss_pkg::sp_resp_t              p2_sp_resp;
  s1_ecss_pkg::mp_req_t               e3_mp_req;
  s1_ecss_pkg::mp_resp_t              e3_mp_resp;
  s1_ecss_pkg::sp_req_t               e3_sp_req;
  s1_ecss_pkg::sp_resp_t              e3_sp_resp;

  cnoc_sp_req_t                 [3:0] cnoc_sp_req;
  cnoc_sp_resp_t                [3:0] cnoc_sp_resp;

  cnoc_mp_req_t                 [3:0] cnoc_mp_req;
  cnoc_mp_resp_t                [3:0] cnoc_mp_resp;

  snoc_sp_req_t                 [1:0] snoc_sp_req;
  snoc_sp_resp_t                [1:0] snoc_sp_resp;

  snoc_mp_req_t                 [2:0] snoc_mp_req;
  snoc_mp_resp_t                [2:0] snoc_mp_resp;

  pnoc_sp_req_t                 [0:0] pnoc_sp_req;
  pnoc_sp_resp_t                [0:0] pnoc_sp_resp;

  pnoc_mp_req_t                 [5:0] pnoc_mp_req;
  pnoc_mp_resp_t                [5:0] pnoc_mp_resp;

  s1_uart_pkg::uart_axil_req_t        uart_axil_req;
  s1_uart_pkg::uart_axil_resp_t       uart_axil_resp;
  s1_uart_pkg::uart_int_reg_t         uart_int_o;

  always_comb begin  // TODO REMOVE

    arst_cc1_ni = temp_arst_cc1_ni & global_arst_ni;
    arst_cc2_ni = temp_arst_cc2_ni & global_arst_ni;
    arst_cc3_ni = temp_arst_cc3_ni & global_arst_ni;
    arst_cnoc_ni = temp_arst_cnoc_ni & global_arst_ni;
    arst_snoc_ni = temp_arst_snoc_ni & global_arst_ni;
    arst_pnoc_ni = temp_arst_pnoc_ni & global_arst_ni;

    clk_cc1_i = temp_clk_cc1_i;
    clk_cc2_i = temp_clk_cc2_i;
    clk_cc3_i = temp_clk_cc3_i;
    pclk_cc1_i = temp_pclk_cc1_i;
    pclk_cc2_i = temp_pclk_cc2_i;
    pclk_cc3_i = temp_pclk_cc3_i;
    clk_cnoc_i = temp_clk_cnoc_i;
    clk_snoc_i = temp_clk_snoc_i;
    clk_pnoc_i = temp_clk_pnoc_i;

    pnoc_mp_resp[4] = '0;
    pnoc_mp_resp[3] = '0;
    pnoc_mp_resp[2] = '0;
    pnoc_mp_resp[1] = '0;

  end

  always_comb begin
    apb_m_clk_o   = clk_pnoc_i;
    apb_m_arst_no = arst_pnoc_ni;
  end

  always_comb begin
    uart_axil_req = '0;
    uart_axil_req.aw.addr = pnoc_mp_req[5].aw.addr;
    uart_axil_req.aw.prot = pnoc_mp_req[5].aw.prot;
    uart_axil_req.aw_valid = pnoc_mp_req[5].aw_valid;
    uart_axil_req.w.data = pnoc_mp_req[5].w.data;
    uart_axil_req.w.strb = pnoc_mp_req[5].w.strb;
    uart_axil_req.w_valid = pnoc_mp_req[5].w_valid;
    uart_axil_req.b_ready = pnoc_mp_req[5].b_ready;
    uart_axil_req.ar.addr = pnoc_mp_req[5].ar.addr;
    uart_axil_req.ar.prot = pnoc_mp_req[5].ar.prot;
    uart_axil_req.ar_valid = pnoc_mp_req[5].ar_valid;
    uart_axil_req.r_ready = pnoc_mp_req[5].r_ready;
  end

  always_comb begin
    pnoc_mp_resp[5] = '0;
    pnoc_mp_resp[5].aw_ready = uart_axil_resp.aw_ready;
    pnoc_mp_resp[5].w_ready = uart_axil_resp.w_ready;
    pnoc_mp_resp[5].b.resp = uart_axil_resp.b.resp;
    pnoc_mp_resp[5].b_valid = uart_axil_resp.b_valid;
    pnoc_mp_resp[5].ar_ready = uart_axil_resp.ar_ready;
    pnoc_mp_resp[5].r.data = uart_axil_resp.r.data;
    pnoc_mp_resp[5].r.resp = uart_axil_resp.r.resp;
    pnoc_mp_resp[5].r_valid = uart_axil_resp.r_valid;
  end

  s1_pcss pcss1 (
      .arst_ni(arst_cc1_ni),
      .clk_i(clk_cc1_i),
      .pclk_i(pclk_cc1_i),
      .boot_addr_i('0),  // TODO CONNECT
      .hart_id_i('h1),  // TODO CONNECT
      .mei_i('0),  // TODO CONNECT
      .msi_i('0),  // TODO CONNECT
      .mti_i('0),  // TODO CONNECT
      .m_req_o(p1_mp_req),
      .m_resp_i(p1_mp_resp),
      .s_req_i(p1_sp_req),
      .s_resp_o(p1_sp_resp)
  );

  s1_pcss pcss2 (
      .arst_ni(arst_cc2_ni),
      .clk_i(clk_cc2_i),
      .pclk_i(pclk_cc2_i),
      .boot_addr_i('0),  // TODO CONNECT
      .hart_id_i('h2),  // TODO CONNECT
      .mei_i('0),  // TODO CONNECT
      .msi_i('0),  // TODO CONNECT
      .mti_i('0),  // TODO CONNECT
      .m_req_o(p2_mp_req),
      .m_resp_i(p2_mp_resp),
      .s_req_i(p2_sp_req),
      .s_resp_o(p2_sp_resp)
  );

  s1_ecss ecss (
      .arst_ni(arst_cc3_ni),
      .clk_i(clk_cc3_i),
      .pclk_i(pclk_cc3_i),
      .boot_addr_i('0),  // TODO CONNECT
      .hart_id_i('h3),  // TODO CONNECT
      .mei_i('0),  // TODO CONNECT
      .msi_i('0),  // TODO CONNECT
      .mti_i('0),  // TODO CONNECT
      .m_req_o(e3_mp_req),
      .m_resp_i(e3_mp_resp),
      .s_req_i(e3_sp_req),
      .s_resp_o(e3_sp_resp)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_pcss_pkg::mp_req_t),
      .src_resp_t(s1_pcss_pkg::mp_resp_t),
      .dst_req_t (cnoc_sp_req_t),
      .dst_resp_t(cnoc_sp_resp_t),
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
      .src_req_t (cnoc_mp_req_t),
      .src_resp_t(cnoc_mp_resp_t),
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
      .dst_req_t (cnoc_sp_req_t),
      .dst_resp_t(cnoc_sp_resp_t),
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
      .src_req_t (cnoc_mp_req_t),
      .src_resp_t(cnoc_mp_resp_t),
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
      .dst_req_t (cnoc_sp_req_t),
      .dst_resp_t(cnoc_sp_resp_t),
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
      .src_req_t (cnoc_mp_req_t),
      .src_resp_t(cnoc_mp_resp_t),
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

  s1_axi_cvtr #(
      .src_req_t (snoc_mp_req_t),
      .src_resp_t(snoc_mp_resp_t),
      .dst_req_t (cnoc_sp_req_t),
      .dst_resp_t(cnoc_sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) snoc_conc_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_snoc_i),
      .src_req_i   (snoc_mp_req[1]),
      .src_resp_o  (snoc_mp_resp[1]),
      .dst_clk_i   (clk_cnoc_i),
      .dst_req_o   (cnoc_sp_req[0]),
      .dst_resp_i  (cnoc_sp_resp[0]),
      .addr_shift_i('0)
  );

  s1_axi_cvtr #(
      .src_req_t (cnoc_mp_req_t),
      .src_resp_t(cnoc_mp_resp_t),
      .dst_req_t (snoc_sp_req_t),
      .dst_resp_t(snoc_sp_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) cnoc_snoc_cvtr (
      .arst_ni     (arst_cnoc_ni),
      .src_clk_i   (clk_cnoc_i),
      .src_req_i   (cnoc_mp_req[0]),
      .src_resp_o  (cnoc_mp_resp[0]),
      .dst_clk_i   (clk_snoc_i),
      .dst_req_o   (snoc_sp_req[1]),
      .dst_resp_i  (snoc_sp_resp[1]),
      .addr_shift_i('0)
  );

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
  ) asi (  //apb_slave_in
      .apb_clk_i  (apb_s_clk_i),
      .apb_arst_ni(apb_s_arst_ni),
      .apb_req_i  (apb_s_req_i),
      .apb_resp_o (apb_s_resp_o),
      .axi_clk_i  (clk_snoc_i),
      .axi_arst_ni(arst_snoc_ni),
      .axi_req_o  (asi_asin_req),
      .axi_resp_i (asi_asin_resp)
  );

  s1_axil_2_axi #(
      .axil_req_t (std_axil_req_t),
      .axil_resp_t(std_axil_resp_t),
      .axi_req_t  (snoc_spn_req_t),
      .axi_resp_t (snoc_spn_resp_t)
  ) asin (  // apb_slave_in_axi_narrow
      .axil_req_i (asi_asin_req),
      .axil_resp_o(asi_asin_resp),
      .axi_req_o  (asin_asiw_req),
      .axi_resp_i (asin_asiw_resp)
  );

  s1_axi_cvtr #(
      .src_req_t (snoc_spn_req_t),
      .src_resp_t(snoc_spn_resp_t),
      .dst_req_t (snoc_sp_req_t),
      .dst_resp_t(snoc_sp_resp_t),
      .enable_cdc(0),
      .faster_src(1)
  ) asiw (  // apb_slave_in_axi_wide
      .arst_ni     (arst_snoc_ni),
      .src_clk_i   (clk_snoc_i),
      .src_req_i   (asin_asiw_req),
      .src_resp_o  (asin_asiw_resp),
      .dst_clk_i   (clk_snoc_i),
      .dst_req_o   (snoc_sp_req[0]),
      .dst_resp_i  (snoc_sp_resp[0]),
      .addr_shift_i('0)
  );

  axi_xbar #(
      .Cfg          (cnoc_xbar_cfg),
      .ATOPs        ('0),
      .Connectivity ('1),
      .slv_aw_chan_t(cnoc_sp_aw_chan_t),
      .mst_aw_chan_t(cnoc_mp_aw_chan_t),
      .w_chan_t     (cnoc_sp_w_chan_t),
      .slv_b_chan_t (cnoc_sp_b_chan_t),
      .mst_b_chan_t (cnoc_mp_b_chan_t),
      .slv_ar_chan_t(cnoc_sp_ar_chan_t),
      .mst_ar_chan_t(cnoc_mp_ar_chan_t),
      .slv_r_chan_t (cnoc_sp_r_chan_t),
      .mst_r_chan_t (cnoc_mp_r_chan_t),
      .slv_req_t    (cnoc_sp_req_t),
      .slv_resp_t   (cnoc_sp_resp_t),
      .mst_req_t    (cnoc_mp_req_t),
      .mst_resp_t   (cnoc_mp_resp_t),
      .rule_t       (xbar_rule_64_t)
  ) cnoc (
      .clk_i                (clk_cnoc_i),
      .rst_ni               (arst_cnoc_ni),
      .test_i               ('0),
      .slv_ports_req_i      (cnoc_sp_req),
      .slv_ports_resp_o     (cnoc_sp_resp),
      .mst_ports_req_o      (cnoc_mp_req),
      .mst_ports_resp_i     (cnoc_mp_resp),
      .addr_map_i           (CnocXbarRule),
      .en_default_mst_port_i('1),
      .default_mst_port_i   ('0)
  );

  axi_xbar #(
      .Cfg          (snoc_xbar_cfg),
      .ATOPs        ('0),
      .Connectivity ('1),
      .slv_aw_chan_t(snoc_sp_aw_chan_t),
      .mst_aw_chan_t(snoc_mp_aw_chan_t),
      .w_chan_t     (snoc_sp_w_chan_t),
      .slv_b_chan_t (snoc_sp_b_chan_t),
      .mst_b_chan_t (snoc_mp_b_chan_t),
      .slv_ar_chan_t(snoc_sp_ar_chan_t),
      .mst_ar_chan_t(snoc_mp_ar_chan_t),
      .slv_r_chan_t (snoc_sp_r_chan_t),
      .mst_r_chan_t (snoc_mp_r_chan_t),
      .slv_req_t    (snoc_sp_req_t),
      .slv_resp_t   (snoc_sp_resp_t),
      .mst_req_t    (snoc_mp_req_t),
      .mst_resp_t   (snoc_mp_resp_t),
      .rule_t       (xbar_rule_64_t)
  ) snoc (
      .clk_i                (clk_snoc_i),
      .rst_ni               (arst_snoc_ni),
      .test_i               ('0),
      .slv_ports_req_i      (snoc_sp_req),
      .slv_ports_resp_o     (snoc_sp_resp),
      .mst_ports_req_o      (snoc_mp_req),
      .mst_ports_resp_i     (snoc_mp_resp),
      .addr_map_i           (SnocXbarRule),
      .en_default_mst_port_i('1),
      .default_mst_port_i   ('0)
  );

  axi_ram #(
      .MEM_BASE('h2000_0000),
      .MEM_SIZE(30),
      .req_t   (snoc_mp_req_t),
      .resp_t  (snoc_mp_resp_t)
  ) ram (
      .arst_ni(arst_snoc_ni),
      .clk_i  (clk_snoc_i),
      .req_i  (snoc_mp_req[0]),
      .resp_o (snoc_mp_resp[0])
  );

  s1_axi_cvtr #(
      .src_req_t (snoc_mp_req_t),
      .src_resp_t(snoc_mp_resp_t),
      .dst_req_t (snoc_mpn_req_t),
      .dst_resp_t(snoc_mpn_resp_t),
      .enable_cdc(1),
      .faster_src(1)
  ) snocn (  // narrow conversion
      .arst_ni     (arst_snoc_ni),
      .src_clk_i   (clk_snoc_i),
      .src_req_i   (snoc_mp_req[2]),
      .src_resp_o  (snoc_mp_resp[2]),
      .dst_clk_i   (clk_pnoc_i),
      .dst_req_o   (snocn_snocl_req),
      .dst_resp_i  (snocn_snocl_resp),
      .addr_shift_i('0)
  );

  axi_to_axi_lite #(
      .AxiAddrWidth   (AXIL_ADDR_WIDTH),
      .AxiDataWidth   (AXIL_DATA_WIDTH),
      .AxiIdWidth     (AXI_ID_WIDTH + 1),
      .AxiUserWidth   (AXI_USER_WIDTH),
      .AxiMaxWriteTxns(2),
      .AxiMaxReadTxns (2),
      .FullBW         (0),
      .FallThrough    (0),
      .full_req_t     (snoc_mpn_req_t),
      .full_resp_t    (snoc_mpn_resp_t),
      .lite_req_t     (pnoc_sp_req_t),
      .lite_resp_t    (pnoc_sp_resp_t)
  ) snocl (  // lite conversion
      .clk_i     (clk_pnoc_i),
      .rst_ni    (arst_pnoc_ni),
      .test_i    ('0),
      .slv_req_i (snocn_snocl_req),
      .slv_resp_o(snocn_snocl_resp),
      .mst_req_o (pnoc_sp_req[0]),
      .mst_resp_i(pnoc_sp_resp[0])
  );

  axi_lite_xbar #(
      .Cfg       (pnoc_xbar_cfg),
      .aw_chan_t (pnoc_sp_aw_chan_t),
      .w_chan_t  (pnoc_sp_w_chan_t),
      .b_chan_t  (pnoc_sp_b_chan_t),
      .ar_chan_t (pnoc_sp_ar_chan_t),
      .r_chan_t  (pnoc_sp_r_chan_t),
      .axi_req_t (pnoc_sp_req_t),
      .axi_resp_t(pnoc_sp_resp_t),
      .rule_t    (xbar_rule_64_t)
  ) pnoc (
      .clk_i(clk_pnoc_i),
      .rst_ni(arst_pnoc_ni),
      .test_i('0),
      .slv_ports_req_i(pnoc_sp_req),
      .slv_ports_resp_o(pnoc_sp_resp),
      .mst_ports_req_o(pnoc_mp_req),
      .mst_ports_resp_i(pnoc_mp_resp),
      .addr_map_i(PnocXbarRule),
      .en_default_mst_port_i('1),
      .default_mst_port_i('0)
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
  ) amo (  // apb_master_out
      .axi_clk_i  (clk_pnoc_i),
      .axi_arst_ni(arst_pnoc_ni),
      .axi_req_i  (pnoc_mp_req[0]),
      .axi_resp_o (pnoc_mp_resp[0]),
      .apb_clk_i  (clk_pnoc_i),
      .apb_arst_ni(apb_m_arst_no),
      .apb_req_o  (apb_m_req_o),
      .apb_resp_i (apb_m_resp_i)
  );

  s1_uart_top u_uart (
      .clk_i(clk_pnoc_i),
      .arst_ni(arst_pnoc_ni),
      .req_i(uart_axil_req),
      .resp_o(uart_axil_resp),
      .tx_o(uart_tx_o),
      .rx_i(uart_rx_i),
      .uart_int_o(uart_int_o)
  );

endmodule
