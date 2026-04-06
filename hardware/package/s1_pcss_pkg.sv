`include "axi/typedef.svh"

package s1_pcss_pkg;

  localparam int TCM_LENGTH = (2 ** 19);  // 512 KiB

  localparam axi_pkg::xbar_cfg_t XbarConfig = '{
      NoSlvPorts : 2,
      NoMstPorts : 2,
      MaxMstTrans: 2,
      MaxSlvTrans: 2,
      FallThrough: 0,
      LatencyMode: axi_pkg::CUT_ALL_PORTS,
      PipelineStages: 2,
      AxiIdWidthSlvPorts: 4,
      AxiIdUsedSlvPorts: 4,
      UniqueIds: 1,
      AxiAddrWidth: 64,
      AxiDataWidth: 64,
      NoAddrRules: 1
  };

  `AXI_TYPEDEF_ALL(sp, logic [63:0], logic [3:0], logic [63:0], logic [7:0], logic)
  `AXI_TYPEDEF_ALL(mp, logic [63:0], logic [4:0], logic [63:0], logic [7:0], logic)

endpackage
