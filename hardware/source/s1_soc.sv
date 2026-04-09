module s1_soc
  import axi_pkg::xbar_rule_64_t;
  import s1_soc_pkg::AXI_ADDR_WIDTH;
  import s1_soc_pkg::AXI_DATA_WIDTH;
  import s1_soc_pkg::AXI_ID_WIDTH;
  import s1_soc_pkg::AXI_USER_WIDTH;
  import s1_soc_pkg::AXIL_ADDR_WIDTH;
  import s1_soc_pkg::AXIL_DATA_WIDTH;
  import s1_soc_pkg::cnoc_mp_req_t;
  import s1_soc_pkg::cnoc_mp_resp_t;
  import s1_soc_pkg::cnoc_sp_req_t;
  import s1_soc_pkg::cnoc_sp_resp_t;
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
    input logic temp_arst_snoc_ni,
    input logic temp_arst_pnoc_ni,
    input logic temp_clk_snoc_i,
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
    input  std_apb_resp_t apb_m_resp_i
);

  logic           arst_snoc_ni;
  logic           arst_pnoc_ni;

  logic           clk_snoc_i;
  logic           clk_pnoc_i;

  std_axil_req_t  asi_asin_req;
  std_axil_resp_t asi_asin_resp;
  std_axi_req_t   asin_asiw_req;
  std_axi_resp_t  asin_asiw_resp;

  snoc_sp_req_t   asiw_snoc_req;  // snoc s0
  snoc_sp_resp_t  asiw_snoc_resp;  // snoc s0

  snoc_mp_req_t   snoc_cnoc_req;  // snoc m1
  snoc_mp_resp_t  snoc_cnoc_resp;  // snoc m1

  snoc_sp_req_t   cnoc_snoc_req;  // snoc s1
  snoc_sp_resp_t  cnoc_snoc_resp;  // snoc s1

  snoc_mp_req_t   snoc_ram_req;  // snoc m0
  snoc_mp_resp_t  snoc_ram_resp;  // snoc m0 

  snoc_mp_req_t   snoc_snocn_req;  // snoc m2
  snoc_mp_resp_t  snoc_snocn_resp;  // snoc m2

  snoc_mpn_req_t   snocn_snocl_req;
  snoc_mpn_resp_t  snocn_snocl_resp;

  pnoc_sp_req_t   snocl_pnoc_req;
  pnoc_sp_resp_t  snocl_pnoc_resp;

  pnoc_mp_req_t   pnoc_gpio_req;
  pnoc_mp_resp_t  pnoc_gpio_resp;

  pnoc_mp_req_t   pnoc_uart_req;
  pnoc_mp_resp_t  pnoc_uart_resp;

  pnoc_mp_req_t   pnoc_plic_req;
  pnoc_mp_resp_t  pnoc_plic_resp;

  pnoc_mp_req_t   pnoc_clint_req;
  pnoc_mp_resp_t  pnoc_clint_resp;

  pnoc_mp_req_t   pnoc_ctrl_req;
  pnoc_mp_resp_t  pnoc_ctrl_resp;

  pnoc_mp_req_t   pnoc_amo_req;
  pnoc_mp_resp_t  pnoc_amo_resp;

  always_comb begin  // TODO REMOVE
    arst_snoc_ni = temp_arst_snoc_ni & global_arst_ni;
    arst_pnoc_ni = temp_arst_pnoc_ni & global_arst_ni;
    clk_snoc_i = temp_clk_snoc_i;
    clk_pnoc_i = temp_clk_pnoc_i;

    snoc_cnoc_resp = '0;
    cnoc_snoc_req = '0;
    snoc_ram_resp = '0;

    pnoc_gpio_resp = '0;
    pnoc_uart_resp = '0;
    pnoc_plic_resp = '0;
    pnoc_clint_resp = '0;
    pnoc_ctrl_resp = '0;

  end

  always_comb begin
    apb_m_clk_o   = clk_pnoc_i;
    apb_m_arst_no = arst_pnoc_ni;
  end

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
      .axi_req_t  (std_axi_req_t),
      .axi_resp_t (std_axi_resp_t)
  ) asin (  // apb_slave_in_axi_narrow
      .axil_req_i (asi_asin_req),
      .axil_resp_o(asi_asin_resp),
      .axi_req_o  (asin_asiw_req),
      .axi_resp_i (asin_asiw_resp)
  );

  s1_axi_cvtr #(
      .src_req_t (std_axi_req_t),
      .src_resp_t(std_axi_resp_t),
      .dst_req_t (std_axi_req_t),
      .dst_resp_t(std_axi_resp_t),
      .enable_cdc(0),
      .faster_src(1)
  ) asiw (  // apb_slave_in_axi_wide
      .arst_ni     (arst_snoc_ni),
      .src_clk_i   (clk_snoc_i),
      .src_req_i   (asin_asiw_req),
      .src_resp_o  (asin_asiw_resp),
      .dst_clk_i   (clk_snoc_i),
      .dst_req_o   (asiw_snoc_req),
      .dst_resp_i  (asiw_snoc_resp),
      .addr_shift_i('0)
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
      .slv_ports_req_i      ({cnoc_snoc_req, asiw_snoc_req}),
      .slv_ports_resp_o     ({cnoc_snoc_resp, asiw_snoc_resp}),
      .mst_ports_req_o      ({snoc_snocn_req, snoc_cnoc_req, snoc_ram_req}),
      .mst_ports_resp_i     ({snoc_snocn_resp, snoc_cnoc_resp, snoc_ram_resp}),
      .addr_map_i           (SnocXbarRule),
      .en_default_mst_port_i('1),
      .default_mst_port_i   ('0)
  );

  s1_axi_cvtr #(
      .src_req_t (snoc_mp_req_t),
      .src_resp_t(snoc_mp_resp_t),
      .dst_req_t (snoc_mpn_req_t),
      .dst_resp_t(snoc_mpn_resp_t),
      .enable_cdc(0),
      .faster_src(1)
  ) snocn (  // narrow conversion
      .arst_ni     (arst_snoc_ni),
      .src_clk_i   (clk_snoc_i),
      .src_req_i   (snoc_snocn_req),
      .src_resp_o  (snoc_snocn_resp),
      .dst_clk_i   (clk_pnoc_i),
      .dst_req_o   (snocn_snocl_req),
      .dst_resp_i  (snocn_snocl_resp),
      .addr_shift_i('0)
  );

  axi_to_axi_lite #(
      .AxiAddrWidth   (AXIL_ADDR_WIDTH),
      .AxiDataWidth   (AXIL_DATA_WIDTH),
      .AxiIdWidth     (AXI_ID_WIDTH),
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
      .mst_req_o (snocl_pnoc_req),
      .mst_resp_i(snocl_pnoc_resp)
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
      .slv_ports_req_i(snocl_pnoc_req),
      .slv_ports_resp_o(snocl_pnoc_resp),
      .mst_ports_req_o({
        pnoc_gpio_req, pnoc_uart_req, pnoc_plic_req, pnoc_clint_req, pnoc_ctrl_req, pnoc_amo_req
      }),
      .mst_ports_resp_i({
        pnoc_gpio_resp,
        pnoc_uart_resp,
        pnoc_plic_resp,
        pnoc_clint_resp,
        pnoc_ctrl_resp,
        pnoc_amo_resp
      }),
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
      .axi_req_i  (pnoc_amo_req),
      .axi_resp_o (pnoc_amo_resp),
      .apb_clk_i  (clk_pnoc_i),
      .apb_arst_ni(apb_m_arst_no),  //TODO apb or pnoc reset?
      .apb_req_o  (apb_m_req_o),
      .apb_resp_i (apb_m_resp_i)
  );

endmodule
