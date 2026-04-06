`include "simple_axil_m_driver.svh"

module s1_axil_2_apb_tb;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // IMPORTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  import s1_soc_pkg::APB_ADDR_WIDTH;
  import s1_soc_pkg::APB_DATA_WIDTH;
  import s1_soc_pkg::std_apb_req_t;
  import s1_soc_pkg::std_apb_resp_t;
  import s1_soc_pkg::std_axil_aw_chan_t;
  import s1_soc_pkg::std_axil_w_chan_t;
  import s1_soc_pkg::std_axil_b_chan_t;
  import s1_soc_pkg::std_axil_ar_chan_t;
  import s1_soc_pkg::std_axil_r_chan_t;
  import s1_soc_pkg::std_axil_req_t;
  import s1_soc_pkg::std_axil_resp_t;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // DUT SIGNALS
  logic           axi_clk_i;
  logic           axi_arst_ni;
  std_axil_req_t  axi_req_i;
  std_axil_resp_t axi_resp_o;
  logic           apb_clk_i;
  logic           apb_arst_ni;
  std_apb_req_t   apb_req_o;
  std_apb_resp_t  apb_resp_i;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // DUT
  //////////////////////////////////////////////////////////////////////////////////////////////////

  s1_axil_2_apb #(
      .ADDR_WIDTH(APB_ADDR_WIDTH),
      .DATA_WIDTH(APB_DATA_WIDTH),
      .apb_req_t (std_apb_req_t),
      .apb_resp_t(std_apb_resp_t),
      .aw_chan_t (std_axil_aw_chan_t),
      .w_chan_t  (std_axil_w_chan_t),
      .b_chan_t  (std_axil_b_chan_t),
      .ar_chan_t (std_axil_ar_chan_t),
      .r_chan_t  (std_axil_r_chan_t),
      .axi_req_t (std_axil_req_t),
      .axi_resp_t(std_axil_resp_t)
  ) u_dut (
      .*
  );

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  task automatic apply_reset();
    #100ns;
    axi_clk_i   <= '0;
    axi_arst_ni <= '0;
    axi_req_i   <= '0;
    apb_clk_i   <= '0;
    apb_arst_ni <= '0;
    #100ns;
    axi_arst_ni <= '1;
    apb_arst_ni <= '1;
    #100ns;
  endtask

  task automatic start_clock();
    fork
      forever #5ns axi_clk_i <= ~axi_clk_i;
      forever #6ns apb_clk_i <= ~apb_clk_i;
    join_none
    @(posedge axi_clk_i);
  endtask

  // task automatic dut_read_32(addr, data, resp);
  // task automatic dut_write_32(addr, data, resp);
  `SIMPLE_AXIL_M_DRIVER(dut, axi_clk_i, axi_arst_ni, axi_req_i, axi_resp_o)

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SEQUENTIALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always_ff @(posedge apb_clk_i or negedge apb_arst_ni) begin
    if (~apb_arst_ni) begin
      apb_resp_i <= '0;
    end else begin
      apb_resp_i <= {$urandom, $urandom};
    end
  end

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin
    int nobody_cares;
    int nobody_cares_either;

    $dumpfile("s1_axil_2_apb_tb.vcd");
    $dumpvars(0, s1_axil_2_apb_tb);

    apply_reset();
    start_clock();

    repeat (5) begin
      repeat (2) @(posedge axi_clk_i);
      randcase
        1: dut_write_32($urandom, $urandom, nobody_cares);
        1: dut_read_32($urandom, nobody_cares, nobody_cares_either);
      endcase
    end

    #100ns;
    $finish;
  end

endmodule
