module s1_pcss_tb;

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

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////
  // DUT SINGALS
  ////////////////////////////////////////////////

  logic arst_ni;
  logic clk_i;
  logic pclk_i;

  logic [63:0] boot_addr_i;
  logic [63:0] hart_id_i;

  logic mei_i;
  logic msi_i;
  logic mti_i;

  mp_req_t m_req_o;
  mp_resp_t m_resp_i;

  sp_req_t s_req_i;
  sp_resp_t s_resp_o;

  s1_pcss dut (.*);

  ////////////////////////////////////////////////
  // INTERNAL SIGNALS
  ////////////////////////////////////////////////

  bit clk_en;
  bit pclk_en;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  task automatic apply_reset();
    #100ns;
    arst_ni     <= '0;
    clk_i       <= '0;
    pclk_i      <= '0;
    boot_addr_i <= 'h0100_0000;
    hart_id_i   <= 'h0001;
    mei_i       <= '0;
    msi_i       <= '0;
    mti_i       <= '0;
    m_resp_i    <= '0;
    s_req_i     <= '0;
    clk_en      <= '0;
    pclk_en     <= '0;
    #100ns;
    arst_ni <= '1;
    #100ns;
  endtask

  function automatic void enable_clk(input bit en = 1);
    clk_en <= en;
  endfunction

  function automatic void enable_pclk(input bit en = 1);
    pclk_en <= en;
  endfunction

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always begin
    clk_i  <= clk_en;
    pclk_i <= pclk_en;
    #5ns;
    clk_i  <= '0;
    pclk_i <= '0;
    #5ns;
  end

  initial begin

    $dumpfile("s1_pcss_tb.vcd");
    $dumpvars(0, s1_pcss_tb);

    apply_reset();
    enable_clk();
    enable_pclk();

    #1000ns;
    $finish;

  end

endmodule

