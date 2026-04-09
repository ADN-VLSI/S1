`include "axi/typedef.svh"
`include "simple_axi_m_driver.svh"

module s1_tb_axi_dwc;

  localparam bit UP_CONVERT = 0;

  localparam int DST_AW = 16;
  localparam int DST_IW = 4;
  localparam int DST_UW = 8;

  localparam int SRC_DW = UP_CONVERT ? 32 : 64;
  localparam int DST_DW = UP_CONVERT ? 64 : 32;

  `AXI_TYPEDEF_ALL(type_3, logic [DST_AW-1:0], logic [DST_IW-1:0], logic [SRC_DW-1:0],
                   logic [SRC_DW/8-1:0], logic [DST_UW-1:0])
  `AXI_TYPEDEF_ALL(type_4, logic [DST_AW-1:0], logic [DST_IW-1:0], logic [DST_DW-1:0],
                   logic [DST_DW/8-1:0], logic [DST_UW-1:0])

  logic internal_clk;
  logic arst_ni;

  type_3_req_t n_3_req;
  type_3_resp_t n_3_resp;
  type_4_req_t n_4_req;
  type_4_resp_t n_4_resp;

  axi_dw_converter #(
      .AxiMaxReads        (1),
      .AxiSlvPortDataWidth(SRC_DW),
      .AxiMstPortDataWidth(DST_DW),
      .AxiAddrWidth       (DST_AW),
      .AxiIdWidth         (DST_IW),
      .aw_chan_t          (type_4_aw_chan_t),
      .mst_w_chan_t       (type_4_w_chan_t),
      .slv_w_chan_t       (type_3_w_chan_t),
      .b_chan_t           (type_4_b_chan_t),
      .ar_chan_t          (type_4_ar_chan_t),
      .mst_r_chan_t       (type_4_r_chan_t),
      .slv_r_chan_t       (type_3_r_chan_t),
      .axi_mst_req_t      (type_4_req_t),
      .axi_mst_resp_t     (type_4_resp_t),
      .axi_slv_req_t      (type_3_req_t),
      .axi_slv_resp_t     (type_3_resp_t)
  ) u_dwc (
      .clk_i     (internal_clk),
      .rst_ni    (arst_ni),
      .slv_req_i (n_3_req),
      .slv_resp_o(n_3_resp),
      .mst_req_o (n_4_req),
      .mst_resp_i(n_4_resp)
  );

  task automatic apply_reset();
    #100ns;
    arst_ni <= '0;
    internal_clk <= '0;
    n_3_req <= '0;
    #100ns;
    arst_ni <= '1;
    #100ns;
  endtask

  task automatic start_clock();
    fork
      forever begin
        internal_clk <= '1;
        #5ns;
        internal_clk <= '0;
        #5ns;
      end
    join_none
    @(posedge internal_clk);
  endtask

  axi_ram #(
      .MEM_BASE(0),
      .MEM_SIZE(16),
      .req_t   (type_4_req_t),
      .resp_t  (type_4_resp_t)
  ) u_axi_ram (
      .arst_ni(arst_ni),
      .clk_i  (internal_clk),
      .req_i  (n_4_req),
      .resp_o (n_4_resp)
  );

  // task automatic n_3_read_8(addr, data, resp);
  // task automatic n_3_write_8(addr, data, resp);
  // task automatic n_3_read_16(addr, data, resp);
  // task automatic n_3_write_16(addr, data, resp);
  // task automatic n_3_read_32(addr, data, resp);
  // task automatic n_3_write_32(addr, data, resp);
  // task automatic n_3_read_64(addr, data, resp);
  // task automatic n_3_write_64(addr, data, resp);
  `SIMPLE_AXI_M_DRIVER(n_3, internal_clk, arst_ni, n_3_req, n_3_resp)

  initial begin

    int data;
    int resp;

    $timeformat(-9, 0, "ns", 6);

    $dumpfile("s1_tb_axi_dwc.vcd");
    $dumpvars(0, s1_tb_axi_dwc);

    apply_reset();

    start_clock();

    n_3_write_32('h1234, 'hF00D_CAFE, resp);
    $display("Write addr: 0x1234, data: 0x%08X, resp: %0d", 'hF00D_CAFE, resp);

    n_3_write_32('h1238, 'hDEAD_BEEF, resp);
    $display("Write addr: 0x1238, data: 0x%08X, resp: %0d", 'hDEAD_BEEF, resp);

    n_3_read_32('h1234, data, resp);
    $display("Read  addr: 0x1234, data: 0x%08X, resp: %0d", data, resp);

    n_3_read_32('h1238, data, resp);
    $display("Read  addr: 0x1238, data: 0x%08X, resp: %0d", data, resp);

    $finish;
  end

  initial begin
    #2us;
    $fatal(1, "Test timed out!");
  end

endmodule
