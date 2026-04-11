module s1_ecss (

    input logic arst_ni,  // active low reset, asynchronous
    input logic clk_i,    // clock for xbar and memory
    input logic pclk_i,   // processor clock

    input logic [31:0] boot_addr_i,  // BOOT_ADDR
    input logic [31:0] hart_id_i,    // HARTID

    input logic mei_i,  // machine external interrupt
    input logic msi_i,  // machine software interrupt
    input logic mti_i,  // machine timer interrupt

    output s1_ecss_pkg::mp_req_t  m_req_o,  // From Processor
    input  s1_ecss_pkg::mp_resp_t m_resp_i, // From Processor

    input  s1_ecss_pkg::sp_req_t  s_req_i,  // To ROM
    output s1_ecss_pkg::sp_resp_t s_resp_o  // To ROM
);

  s1_ecss_pkg::mp_req_t          rom_req;
  s1_ecss_pkg::mp_resp_t         rom_resp;
  s1_ecss_pkg::mp_req_t          rom_req_os;
  s1_ecss_pkg::mp_resp_t         rom_resp_os;

  s1_ecss_pkg::spl_req_t         core_imem_l_req;
  s1_ecss_pkg::spl_resp_t        core_imem_l_resp;
  s1_ecss_pkg::spl_req_t         core_dmem_l_req;
  s1_ecss_pkg::spl_resp_t        core_dmem_l_resp;

  s1_ecss_pkg::spl_req_t         core_imem_lf_req;
  s1_ecss_pkg::spl_resp_t        core_imem_lf_resp;
  s1_ecss_pkg::spl_req_t         core_dmem_lf_req;
  s1_ecss_pkg::spl_resp_t        core_dmem_lf_resp;

  s1_ecss_pkg::sp_req_t          core_imem_req;
  s1_ecss_pkg::sp_resp_t         core_imem_resp;
  s1_ecss_pkg::sp_req_t          core_dmem_req;
  s1_ecss_pkg::sp_resp_t         core_dmem_resp;

  logic                   [31:0] core_instr_addr;
  logic                          core_instr_req;
  logic                          core_instr_gnt;
  logic                          core_instr_rvalid;
  logic                   [31:0] core_instr_rdata;

  logic                   [31:0] core_data_addr;
  logic                          core_data_we;
  logic                   [31:0] core_data_wdata;
  logic                   [ 3:0] core_data_be;
  logic                          core_data_req;
  logic                          core_data_gnt;
  logic                          core_data_rvalid;
  logic                   [31:0] core_data_rdata;

  logic                   [31:0] core_irq;

  always_comb begin
    core_irq = '0;
    core_irq[11] = mei_i;
    core_irq[7] = mti_i;
    core_irq[3] = msi_i;
  end

  rv32imf u_core (
      .clk_i              (pclk_i),
      .rst_ni             (arst_ni),
      .boot_addr_i        (boot_addr_i),
      .dm_halt_addr_i     ('0),
      .hart_id_i          (hart_id_i),
      .dm_exception_addr_i('0),
      .instr_req_o        (core_instr_req),
      .instr_gnt_i        (core_instr_gnt),
      .instr_rvalid_i     (core_instr_rvalid),
      .instr_addr_o       (core_instr_addr),
      .instr_rdata_i      (core_instr_rdata),
      .data_req_o         (core_data_req),
      .data_gnt_i         (core_data_gnt),
      .data_rvalid_i      (core_data_rvalid),
      .data_we_o          (core_data_we),
      .data_be_o          (core_data_be),
      .data_addr_o        (core_data_addr),
      .data_wdata_o       (core_data_wdata),
      .data_rdata_i       (core_data_rdata),
      .irq_i              (core_irq),
      .irq_ack_o          (),
      .irq_id_o           ()
  );

  s1_obi_2_axil #(
      .OBI_ADDRW  (32),
      .OBI_DATAW  (32),
      .axil_req_t (s1_ecss_pkg::spl_req_t),
      .axil_resp_t(s1_ecss_pkg::spl_resp_t)
  ) i_obi (
      .clk_i      (pclk_i),
      .arst_ni    (arst_ni),
      .addr_i     (core_instr_addr),
      .we_i       ('0),
      .wdata_i    ('0),
      .be_i       ('0),
      .req_i      (core_instr_req),
      .gnt_o      (core_instr_gnt),
      .rvalid_o   (core_instr_rvalid),
      .rdata_o    (core_instr_rdata),
      .axil_req_o (core_imem_l_req),
      .axil_resp_i(core_imem_l_resp)
  );

  s1_obi_2_axil #(
      .OBI_ADDRW  (32),
      .OBI_DATAW  (32),
      .axil_req_t (s1_ecss_pkg::spl_req_t),
      .axil_resp_t(s1_ecss_pkg::spl_resp_t)
  ) d_obi (
      .clk_i      (pclk_i),
      .arst_ni    (arst_ni),
      .addr_i     (core_data_addr),
      .we_i       (core_data_we),
      .wdata_i    (core_data_wdata),
      .be_i       (core_data_be),
      .req_i      (core_data_req),
      .gnt_o      (core_data_gnt),
      .rvalid_o   (core_data_rvalid),
      .rdata_o    (core_data_rdata),
      .axil_req_o (core_dmem_l_req),
      .axil_resp_i(core_dmem_l_resp)
  );

  axi_fifo #(
      .Depth      (2),
      .FallThrough(0),
      .aw_chan_t  (s1_ecss_pkg::spl_aw_chan_t),
      .w_chan_t   (s1_ecss_pkg::spl_w_chan_t),
      .b_chan_t   (s1_ecss_pkg::spl_b_chan_t),
      .ar_chan_t  (s1_ecss_pkg::spl_ar_chan_t),
      .r_chan_t   (s1_ecss_pkg::spl_r_chan_t),
      .axi_req_t  (s1_ecss_pkg::spl_req_t),
      .axi_resp_t (s1_ecss_pkg::spl_resp_t)
  ) i_fifo (
      .clk_i     (pclk_i),
      .rst_ni    (arst_ni),
      .test_i    ('0),
      .slv_req_i (core_imem_l_req),
      .slv_resp_o(core_imem_l_resp),
      .mst_req_o (core_imem_lf_req),
      .mst_resp_i(core_imem_lf_resp)
  );

  axi_fifo #(
      .Depth      (2),
      .FallThrough(0),
      .aw_chan_t  (s1_ecss_pkg::spl_aw_chan_t),
      .w_chan_t   (s1_ecss_pkg::spl_w_chan_t),
      .b_chan_t   (s1_ecss_pkg::spl_b_chan_t),
      .ar_chan_t  (s1_ecss_pkg::spl_ar_chan_t),
      .r_chan_t   (s1_ecss_pkg::spl_r_chan_t),
      .axi_req_t  (s1_ecss_pkg::spl_req_t),
      .axi_resp_t (s1_ecss_pkg::spl_resp_t)
  ) d_fifo (
      .clk_i     (pclk_i),
      .rst_ni    (arst_ni),
      .test_i    ('0),
      .slv_req_i (core_dmem_l_req),
      .slv_resp_o(core_dmem_l_resp),
      .mst_req_o (core_dmem_lf_req),
      .mst_resp_i(core_dmem_lf_resp)
  );

  s1_axil_2_axi #(
      .axil_req_t (s1_ecss_pkg::spl_req_t),
      .axil_resp_t(s1_ecss_pkg::spl_resp_t),
      .axi_req_t  (s1_ecss_pkg::sp_req_t),
      .axi_resp_t (s1_ecss_pkg::sp_resp_t)
  ) i_cvtr (
      .axil_req_i (core_imem_lf_req),
      .axil_resp_o(core_imem_lf_resp),
      .axi_req_o  (core_imem_req),
      .axi_resp_i (core_imem_resp)
  );

  s1_axil_2_axi #(
      .axil_req_t (s1_ecss_pkg::spl_req_t),
      .axil_resp_t(s1_ecss_pkg::spl_resp_t),
      .axi_req_t  (s1_ecss_pkg::sp_req_t),
      .axi_resp_t (s1_ecss_pkg::sp_resp_t)
  ) d_cvtr (
      .axil_req_i (core_dmem_lf_req),
      .axil_resp_o(core_dmem_lf_resp),
      .axi_req_o  (core_dmem_req),
      .axi_resp_i (core_dmem_resp)
  );

  axi_ram #(
      .MEM_BASE(0),
      .MEM_SIZE(16),
      .req_t   (s1_ecss_pkg::mp_req_t),
      .resp_t  (s1_ecss_pkg::mp_resp_t)
  ) u_axi_ram (
      .arst_ni(arst_ni),
      .clk_i  (clk_i),
      .req_i  (rom_req_os),
      .resp_o (rom_resp_os)
  );

  s1_axi_cvtr #(
      .src_req_t (s1_ecss_pkg::mp_req_t),
      .src_resp_t(s1_ecss_pkg::mp_resp_t),
      .dst_req_t (s1_ecss_pkg::mp_req_t),
      .dst_resp_t(s1_ecss_pkg::mp_resp_t),
      .enable_cdc(0),
      .faster_src(0)
  ) rom_addr_shift (
      .arst_ni     (arst_ni),
      .src_clk_i   (clk_i),
      .src_req_i   (rom_req),
      .src_resp_o  (rom_resp),
      .dst_clk_i   (clk_i),
      .dst_req_o   (rom_req_os),
      .dst_resp_i  (rom_resp_os),
      .addr_shift_i(-longint'(s1_ecss_pkg::ROM_BASE))
  );

  axi_xbar #(
      .Cfg          (s1_ecss_pkg::XbarConfig),
      .ATOPs        ('0),
      .Connectivity ('1),
      .slv_aw_chan_t(s1_ecss_pkg::sp_aw_chan_t),
      .mst_aw_chan_t(s1_ecss_pkg::mp_aw_chan_t),
      .w_chan_t     (s1_ecss_pkg::mp_w_chan_t),
      .slv_b_chan_t (s1_ecss_pkg::sp_b_chan_t),
      .mst_b_chan_t (s1_ecss_pkg::mp_b_chan_t),
      .slv_ar_chan_t(s1_ecss_pkg::sp_ar_chan_t),
      .mst_ar_chan_t(s1_ecss_pkg::mp_ar_chan_t),
      .slv_r_chan_t (s1_ecss_pkg::sp_r_chan_t),
      .mst_r_chan_t (s1_ecss_pkg::mp_r_chan_t),
      .slv_req_t    (s1_ecss_pkg::sp_req_t),
      .slv_resp_t   (s1_ecss_pkg::sp_resp_t),
      .mst_req_t    (s1_ecss_pkg::mp_req_t),
      .mst_resp_t   (s1_ecss_pkg::mp_resp_t),
      .rule_t       (axi_pkg::xbar_rule_32_t)
  ) u_xbar (
      .clk_i(clk_i),
      .rst_ni(arst_ni),
      .test_i('0),
      .slv_ports_req_i({core_imem_req, core_dmem_req, s_req_i}),
      .slv_ports_resp_o({core_imem_resp, core_dmem_resp, s_resp_o}),
      .mst_ports_req_o({rom_req, m_req_o}),
      .mst_ports_resp_i({rom_resp, m_resp_i}),
      .addr_map_i(s1_ecss_pkg::XbarRule),
      .en_default_mst_port_i('1),
      .default_mst_port_i('0)
  );

endmodule
