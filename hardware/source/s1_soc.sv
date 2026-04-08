module s1_soc
  import s1_soc_pkg::std_apb_req_t;
  import s1_soc_pkg::std_apb_resp_t;

  import s1_soc_pkg::AXIL_ADDR_WIDTH;
  import s1_soc_pkg::AXIL_DATA_WIDTH;
  import s1_soc_pkg::AXI_ID_WIDTH;
  import s1_soc_pkg::AXI_ADDR_WIDTH;
  import s1_soc_pkg::AXI_DATA_WIDTH;
  import s1_soc_pkg::AXI_USER_WIDTH;
  import s1_soc_pkg::std_axil_aw_chan_t;
  import s1_soc_pkg::std_axil_w_chan_t;
  import s1_soc_pkg::std_axil_b_chan_t;
  import s1_soc_pkg::std_axil_ar_chan_t;
  import s1_soc_pkg::std_axil_r_chan_t;
  import s1_soc_pkg::std_axil_req_t;
  import s1_soc_pkg::std_axil_resp_t;
  import s1_soc_pkg::std_axi_req_t;
  import s1_soc_pkg::std_axi_resp_t;
  import s1_soc_pkg::snoc_sp_req_t;
  import s1_soc_pkg::snoc_sp_resp_t;
  import s1_soc_pkg::snoc_mp_req_t;
  import s1_soc_pkg::snoc_mp_aw_chan_t;
  import s1_soc_pkg::snoc_mp_resp_t;
  import s1_soc_pkg::cnoc_sp_req_t;
  import s1_soc_pkg::cnoc_sp_resp_t;
  import s1_soc_pkg::cnoc_mp_req_t;
  import s1_soc_pkg::cnoc_mp_resp_t;
  import s1_soc_pkg::pnoc_sp_req_t;
  import s1_soc_pkg::pnoc_sp_resp_t
  import s1_soc_pkg::pnoc_mp_req_t;
  import s1_soc_pkg::pnoc_mp_resp_t;
  import s1_soc_pkg::snoc_xbar_cfg;
  import s1_soc_pkg::SnocXbarRule;
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

  always_comb begin  // TODO REMOVE
    apb_m_clk_o   = apb_s_clk_i;
    apb_m_arst_no = apb_s_arst_ni;
  end

  std_axil_req_t  asi_asian_req;
  std_axil_resp_t asi_asian_resp;
  std_axi_req_t   asin_asiw_req;  // TODO REMOVE
  std_axi_resp_t  asin_asiw_resp;  // TODO REMOVE

  snoc_sp_req_t   asiw_snoc_req;
  snoc_sp_resp_t  asiw_snoc_resp;

  snoc_mp_req_t   snoc_snocn_req;
  snoc_mp_resp_t  snoc_snocn_resp;

  std_axil_req_t  axi_to_axil_req;  // TODO REMOVE
  std_axil_resp_t axi_to_axil_resp;  // TODO REMOVE

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
      .axi_clk_i  (temp_clk_snoc_i),
      .axi_arst_ni(temp_arst_snoc_ni),
      .axi_req_o  (asi_asian_req),
      .axi_resp_i (asi_asian_resp)
  );

  s1_axil_2_axi #(
      .axil_req_t (std_axil_req_t),
      .axil_resp_t(std_axil_resp_t),
      .axi_req_t  (std_axi_req_t),
      .axi_resp_t (std_axi_resp_t)
  ) asin (  // apb_slave_in_axi_narrow
      .axil_req_i (asi_asian_req  ),
      .axil_resp_o(asi_asian_resp ),
      .axi_req_o  (asin_asiw_req  ),
      .axi_resp_i (asin_asiw_resp )
  );

  s1_axi_cvtr #(
      .src_req_t (std_axi_req_t),
      .src_resp_t(std_axi_resp_t),
      .dst_req_t (std_axi_req_t),
      .dst_resp_t(std_axi_resp_t),
      .enable_cdc(0),
      .faster_src(1)
  ) asiw (
      .arst_ni     ( temp_arst_snoc_ni),
      .src_clk_i   ( temp_clk_snoc_i  ),
      .src_req_i   ( asin_asiw_req    ),
      .src_resp_o  ( asin_asiw_resp   ),
      .dst_clk_i   ( temp_clk_snoc_i  ),
      .dst_req_o   ( asiw_snoc_req    ),
      .dst_resp_i  ( asiw_snoc_resp   ),
      .addr_shift_i( )      // TODO:fill
  );

  axi_xbar #(
    .Cfg           ( snoc_xbar_cfg     ),
    .ATOPs         ( '0                ),
    .Connectivity  ( '1                ),
    .slv_aw_chan_t ( snoc_mp_aw_chan_t ),
    .mst_aw_chan_t ( snoc_sp_aw_chan_t ),
    .w_chan_t      ( snoc_mp_w_chant_t ),    //TODO: connection
    .slv_b_chan_t  ( snoc_mp_b_chan_t  ),
    .mst_b_chan_t  ( snoc_sp_b_chan_t  ),
    .slv_ar_chan_t ( snoc_mp_ar_chan_t ),
    .mst_ar_chan_t ( snoc_sp_ar_chan_t ),
    .slv_r_chan_t  ( snoc_mp_r_chan_t  ),
    .mst_r_chan_t  ( snoc_sp_r_chant_t ),
    .slv_req_t     ( snoc_mp_req_t     ),
    .slv_resp_t    ( snoc_mp_resp_t    ),
    .mst_req_t     ( snoc_sp_req_t     ),
    .mst_resp_t    ( snoc_sp_resp_t    ),
    .rule_t        ( xbar_rule_64_t    )
) snoc (
    .clk_i                 (temp_clk_snoc_i   ),
    .rst_ni                (temp_arst_snoc_ni ),
    .test_i                ('0                ),
    .slv_ports_req_i       (asiw_snoc_req     ),  //TODO confusion
    .slv_ports_resp_o      (asiw_snoc_resp    ),  //TODO confusion
    .mst_ports_req_o       (snoc_snocn_req    ),  //TODO confusion
    .mst_ports_resp_i      (snoc_snocn_resp   ),  //TODO confusion
    .addr_map_i            (SnocXbarRule      ),
    .en_default_mst_port_i ('1 ),
    .default_mst_port_i    ('0 )
);


  axi_to_axi_lite #(
      .AxiAddrWidth   (AXI_ADDR_WIDTH),
      .AxiDataWidth   (AXI_DATA_WIDTH),
      .AxiIdWidth     (AXI_ID_WIDTH),
      .AxiUserWidth   (AXI_USER_WIDTH),
      .AxiMaxWriteTxns(2),
      .AxiMaxReadTxns (2),
      .FullBW         (0),
      .FallThrough    (0),
      .full_req_t     (std_axi_req_t),
      .full_resp_t    (std_axi_resp_t),
      .lite_req_t     (std_axil_req_t),
      .lite_resp_t    (std_axil_resp_t)
  ) u_axi_to_axi_lite (
      .clk_i(temp_clk_pnoc_i),
      .rst_ni(temp_arst_pnoc_ni),
      .test_i('0),
      .slv_req_i(asin_asiw_req),
      .slv_resp_o(asin_asiw_resp),
      .mst_req_o(axi_to_axil_req),
      .mst_resp_i(axi_to_axil_resp)
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
      .axi_clk_i  (temp_clk_pnoc_i),
      .axi_arst_ni(temp_arst_pnoc_ni),
      .axi_req_i  (axi_to_axil_req),
      .axi_resp_o (axi_to_axil_resp),
      .apb_clk_i  (apb_m_clk_o),
      .apb_arst_ni(apb_m_arst_no),
      .apb_req_o  (apb_m_req_o),
      .apb_resp_i (apb_m_resp_i)
  );

endmodule
