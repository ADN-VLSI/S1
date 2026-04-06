module s1_soc_tb;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // IMPORTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  import s1_soc_pkg::std_apb_req_t;
  import s1_soc_pkg::std_apb_resp_t;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // DUT SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic          temp_arst_snoc_ni;
  logic          temp_arst_periph_ni;

  logic          temp_clk_snoc_i;
  logic          temp_clk_periph_i;

  ////////////////////////////////////////////////

  logic          global_arst_ni;
  logic          xtal_16MHz_i;

  logic          apb_s_clk_i;
  logic          apb_s_arst_ni;
  std_apb_req_t  apb_s_req_i;
  std_apb_resp_t apb_s_resp_o;

  logic          apb_m_clk_o;
  logic          apb_m_arst_no;
  std_apb_req_t  apb_m_req_o;
  std_apb_resp_t apb_m_resp_i;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // INTERFACES
  //////////////////////////////////////////////////////////////////////////////////////////////////

  apb_if #(
      .ADDR_WIDTH(32),
      .DATA_WIDTH(32)
  ) apb_master (
      .arst_ni(apb_s_arst_ni),
      .clk_i  (apb_s_clk_i)
  );

  apb_if #(
      .ADDR_WIDTH(32),
      .DATA_WIDTH(32)
  ) apb_slave (
      .arst_ni(apb_m_arst_no),
      .clk_i  (apb_m_clk_o)
  );

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // ASSIGNMENTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always_comb begin
    apb_s_req_i         = '0;
    apb_s_req_i.psel    = apb_master.psel;
    apb_s_req_i.penable = apb_master.penable;
    apb_s_req_i.paddr   = apb_master.paddr;
    apb_s_req_i.pprot   = apb_master.pprot;
    apb_s_req_i.pwrite  = apb_master.pwrite;
    apb_s_req_i.pwdata  = apb_master.pwdata;
    apb_s_req_i.pstrb   = apb_master.pstrb;
    apb_master.pready   = apb_s_resp_o.pready;
    apb_master.prdata   = apb_s_resp_o.prdata;
    apb_master.pslverr  = apb_s_resp_o.pslverr;
  end

  always_comb begin
    apb_m_resp_i         = '0;
    apb_slave.psel       = apb_m_req_o.psel;
    apb_slave.penable    = apb_m_req_o.penable;
    apb_slave.paddr      = apb_m_req_o.paddr;
    apb_slave.pprot      = apb_m_req_o.pprot;
    apb_slave.pwrite     = apb_m_req_o.pwrite;
    apb_slave.pwdata     = apb_m_req_o.pwdata;
    apb_slave.pstrb      = apb_m_req_o.pstrb;
    apb_m_resp_i.pready  = apb_slave.pready;
    apb_m_resp_i.prdata  = apb_slave.prdata;
    apb_m_resp_i.pslverr = apb_slave.pslverr;
  end

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // DUT
  //////////////////////////////////////////////////////////////////////////////////////////////////

  s1_soc u_dut (.*);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always begin  // 16MHz
    xtal_16MHz_i <= '0;
    #31.25ns;
    xtal_16MHz_i <= '1;
    #31.25ns;
  end

  always begin  // 10MHz
    apb_s_clk_i <= '0;
    #50ns;
    apb_s_clk_i <= '1;
    #50ns;
  end

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin
    #100ns;
    $finish;
  end

endmodule
