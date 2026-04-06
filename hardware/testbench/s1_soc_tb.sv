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

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  task automatic apply_reset();
    #100ns;
    apb_master.reset();
    temp_arst_snoc_ni   <= '0;
    temp_arst_periph_ni <= '0;
    temp_clk_snoc_i     <= '0;
    temp_clk_periph_i   <= '0;
    global_arst_ni      <= '0;
    apb_s_arst_ni       <= '0;
    apb_s_clk_i         <= '0;
    #100ns;
    temp_arst_snoc_ni   <= '1;
    temp_arst_periph_ni <= '1;
    global_arst_ni      <= '1;
    apb_s_arst_ni       <= '1;
    #100ns;
  endtask

  task automatic start_clock();
    fork
      forever #1ns temp_clk_snoc_i <= ~temp_clk_snoc_i;  // 500 MHz
      forever #5ns temp_clk_periph_i <= ~temp_clk_periph_i;  // 100MHz
      forever #50ns apb_s_clk_i <= ~apb_s_clk_i;  // 10MHz
    join_none
  endtask

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin

    automatic int temp;

    $timeformat(-9, 0, "ns", 10);
    $dumpfile("s1_soc_tb.vcd");
    $dumpvars(0, s1_soc_tb);

    apb_slave.reset();
    apb_slave.run_as_slave_mem();

    apply_reset();
    start_clock();

    @(posedge apb_s_clk_i);

    apb_master.write(32'h0000_0000, 32'hF00D_CAFE);
    apb_master.write(32'h0000_0004, 32'hDEAD_BEEF);

    apb_master.read(32'h0000_0000, temp);
    $display("Read from 0x0000_0000: 0x%08X", temp);
    apb_master.read(32'h0000_0004, temp);
    $display("Read from 0x0000_0004: 0x%08X", temp);

    #10us;

    $finish;

  end

endmodule
