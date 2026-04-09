`include "axi/typedef.svh"

package s1_ecss_pkg;

  localparam int ROM_BASE = 64'h0200_0000;
  localparam int ROM_LEN = (2 ** 16);  // 64 KiB

  localparam axi_pkg::xbar_cfg_t XbarConfig = '{
      NoSlvPorts : 3,
      NoMstPorts : 2,
      MaxMstTrans: 2,
      MaxSlvTrans: 2,
      FallThrough: 0,
      LatencyMode: axi_pkg::CUT_ALL_PORTS,
      PipelineStages: 2,
      AxiIdWidthSlvPorts: 2,
      AxiIdUsedSlvPorts: 2,
      UniqueIds: 1,
      AxiAddrWidth: 32,
      AxiDataWidth: 32,
      NoAddrRules: 1
  };

  localparam axi_pkg::xbar_rule_32_t [0:0] XbarRule = '{
      '{idx: 1, start_addr: (ROM_BASE), end_addr: (ROM_BASE + ROM_LEN - 1)}
  };

  `AXI_LITE_TYPEDEF_ALL(spl, logic [31:0], logic [31:0], logic [3:0])

  `AXI_TYPEDEF_ALL(sp, logic [31:0], logic [1:0], logic [31:0], logic [3:0], logic)
  `AXI_TYPEDEF_ALL(mp, logic [31:0], logic [3:0], logic [31:0], logic [3:0], logic)

endpackage
