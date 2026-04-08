module s1_pcss
  import axi_pkg::xbar_rule_64_t;
  import s1_pcss_pkg::XbarConfig;
  import s1_pcss_pkg::TCM_LENGTH;
  import s1_pcss_pkg::sp_aw_chan_t;
  import s1_pcss_pkg::sp_w_chan_t;
  import s1_pcss_pkg::sp_b_chan_t;
  import s1_pcss_pkg::sp_ar_chan_t;
  import s1_pcss_pkg::sp_r_chan_t;
  import s1_pcss_pkg::sp_req_t;
  import s1_pcss_pkg::sp_resp_t;
  import s1_pcss_pkg::mp_aw_chan_t;
  import s1_pcss_pkg::mp_w_chan_t;
  import s1_pcss_pkg::mp_b_chan_t;
  import s1_pcss_pkg::mp_ar_chan_t;
  import s1_pcss_pkg::mp_r_chan_t;
  import s1_pcss_pkg::mp_req_t;
  import s1_pcss_pkg::mp_resp_t;
(

    input logic arst_ni,  // active low reset, asynchronous
    input logic clk_i,    // clock for xbar and memory
    input logic pclk_i,   // processor clock

    input logic [63:0] boot_addr_i,  // BOOT_ADDR
    input logic [63:0] hart_id_i,    // HARTID

    input logic mei_i,  // machine external interrupt
    input logic msi_i,  // machine software interrupt
    input logic mti_i,  // machine timer interrupt

    output mp_req_t  m_req_o,  // From Processor
    input  mp_resp_t m_resp_i, // From Processor

    input  sp_req_t  s_req_i,  // To TCM
    output sp_resp_t s_resp_o  // To TCM
);

  logic [63:0] tcm_base;
  always_comb begin
    tcm_base = 64'h0100_0000 + 64'h8_0000 * (hart_id_i[4:0] - 1);
  end

  xbar_rule_64_t [0:0] XbarRule;
  always_comb begin
    XbarRule = '{'{idx: 1, start_addr: (tcm_base), end_addr: (tcm_base + TCM_LENGTH - 1)}};
  end

  mp_req_t  tcm_req;
  mp_resp_t tcm_resp;

  mp_req_t  tcm_req_os;
  mp_resp_t tcm_resp_os;

  sp_req_t  ariane_axi_req;
  sp_resp_t ariane_axi_resp;

  ariane #(
      .DmBaseAddress('0),
      .CachedAddrBeg('1)
  ) u_core (
      .rst_ni(arst_ni),
      .clk_i(pclk_i),
      .boot_addr_i(boot_addr_i),
      .hart_id_i(hart_id_i),
      .irq_i({'0, mei_i}),
      .ipi_i(msi_i),
      .time_irq_i(mti_i),
      .debug_req_i('0),
      .axi_req_o(ariane_axi_req),
      .axi_resp_i(ariane_axi_resp)
  );

  s1_axi_cvtr #(
      .src_req_t (mp_req_t),
      .src_resp_t(mp_resp_t),
      .dst_req_t (mp_req_t),
      .dst_resp_t(mp_resp_t),
      .enable_cdc(0),
      .faster_src(0)
  ) u_cvtr (
      .arst_ni     (arst_ni),
      .src_clk_i   (clk_i),
      .src_req_i   (tcm_req),
      .src_resp_o  (tcm_resp),
      .dst_clk_i   (clk_i),
      .dst_req_o   (tcm_req_os),
      .dst_resp_i  (tcm_resp_os),
      .addr_shift_i(-tcm_base)
  );

  axi_ram #(
      .MEM_BASE(0),
      .MEM_SIZE(19),
      .req_t   (mp_req_t),
      .resp_t  (mp_resp_t)
  ) u_axi_ram (
      .arst_ni(arst_ni),
      .clk_i  (clk_i),
      .req_i  (tcm_req_os),
      .resp_o (tcm_resp_os)
  );

  axi_xbar #(
      .Cfg          (XbarConfig),
      .ATOPs        ('0),
      .Connectivity ('1),
      .slv_aw_chan_t(sp_aw_chan_t),
      .mst_aw_chan_t(mp_aw_chan_t),
      .w_chan_t     (mp_w_chan_t),
      .slv_b_chan_t (sp_b_chan_t),
      .mst_b_chan_t (mp_b_chan_t),
      .slv_ar_chan_t(sp_ar_chan_t),
      .mst_ar_chan_t(mp_ar_chan_t),
      .slv_r_chan_t (sp_r_chan_t),
      .mst_r_chan_t (mp_r_chan_t),
      .slv_req_t    (sp_req_t),
      .slv_resp_t   (sp_resp_t),
      .mst_req_t    (mp_req_t),
      .mst_resp_t   (mp_resp_t),
      .rule_t       (xbar_rule_64_t)
  ) u_xbar (
      .clk_i(clk_i),
      .rst_ni(arst_ni),
      .test_i('0),
      .slv_ports_req_i({ariane_axi_req, s_req_i}),
      .slv_ports_resp_o({ariane_axi_resp, s_resp_o}),
      .mst_ports_req_o({tcm_req, m_req_o}),
      .mst_ports_resp_i({tcm_resp, m_resp_i}),
      .addr_map_i(XbarRule),
      .en_default_mst_port_i('1),
      .default_mst_port_i('0)
  );

endmodule
