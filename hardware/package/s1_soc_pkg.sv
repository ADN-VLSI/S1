`include "axi/typedef.svh"
`include "apb/typedef.svh"

package s1_soc_pkg;


  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PARAMTERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // STANDARD AXI
  parameter int AXI_ID_WIDTH = 4;
  parameter int AXI_ADDR_WIDTH = 32;
  parameter int AXI_DATA_WIDTH = 32;
  parameter int AXI_USER_WIDTH = 8;

  // STANDARD AXIL
  parameter int AXIL_ADDR_WIDTH = 32;
  parameter int AXIL_DATA_WIDTH = 32;

  // STANDARD APB
  parameter int APB_ADDR_WIDTH = 32;
  parameter int APB_DATA_WIDTH = 32;

  // Base Address
  parameter int UART_BASE = 'h0001_1000;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // TYPE DEFINITIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  `AXI_TYPEDEF_ALL(std_axi, logic [AXI_ADDR_WIDTH-1:0], logic [AXI_ID_WIDTH-1:0],
                   logic [AXI_DATA_WIDTH-1:0], logic [AXI_DATA_WIDTH/8-1:0],
                   logic [AXI_USER_WIDTH-1:0])

  `AXI_LITE_TYPEDEF_ALL(std_axil, logic [AXIL_ADDR_WIDTH-1:0], logic [AXIL_DATA_WIDTH-1:0],
                        logic [AXIL_DATA_WIDTH/8-1:0])

  `APB_TYPEDEF_ALL(std_apb, logic [APB_ADDR_WIDTH-1:0], logic [APB_DATA_WIDTH-1:0],
                   logic [APB_DATA_WIDTH/8-1:0])

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // NOC CONFIGURATION
  //////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////
  // CNOC CONFIGURATION
  ////////////////////////////////////////////////

  localparam int NumCnocRules = 2;
  localparam axi_pkg::xbar_rule_64_t [NumCnocRules-1:0] XbarRule = '{
      '{idx: 1, start_addr: 64'h0100_0000, end_addr: 64'h0107_FFFF},  // TCM1
      '{idx: 2, start_addr: 64'h0108_0000, end_addr: 64'h010F_FFFF},  // TCM2
      '{idx: 3, start_addr: 64'h0200_0000, end_addr: 64'h0200_FFFF}  // BOOTROM
  // DEFAULT RULE (idx: 0) will route to SNOC
  };

  localparam axi_pkg::xbar_cfg_t cnoc_xbar_cfg = '{
      NoSlvPorts : 4,
      NoMstPorts : 4,
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
      NoAddrRules: NumCnocRules
  };

  ////////////////////////////////////////////////
  // SNOC CONFIGURATION
  ////////////////////////////////////////////////

  localparam int NumSnocRules = 3;
  localparam axi_pkg::xbar_rule_64_t [NumSnocRules-1:0] XbarRule = '{
      '{idx: 1, start_addr: 64'h0100_0000, end_addr: 64'h0200_FFFF},  // CNOC
      '{idx: 2, start_addr: 64'h0000_0000, end_addr: 64'h00FF_FFFF},  // PNOC peripheral
      '{idx: 3, start_addr: 64'h1000_0000, end_addr: 64'h1FFF_FFFF}  // PNOC APB
  // DEFAULT RULE (idx: 0) will route to RAM
  };

  localparam axi_pkg::xbar_cfg_t snoc_xbar_cfg = '{
      NoSlvPorts : 2,
      NoMstPorts : 3,
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
      NoAddrRules: NumSnocRules
  };

  ////////////////////////////////////////////////
  // PNOC CONFIGURATION
  ////////////////////////////////////////////////

  localparam int NumPnocRules = 5;
  localparam axi_pkg::xbar_rule_64_t [NumPnocRules-1:0] XbarRule = '{
      '{idx: 1, start_addr: 64'h0001_0000, end_addr: 64'h0001_0FFF},  // CTRL_SS
      '{idx: 2, start_addr: 64'h0001_4000, end_addr: 64'h0001_4FFF},  // CLINT
      '{idx: 3, start_addr: 64'h0001_3000, end_addr: 64'h0001_3FFF},  // PLIC
      '{idx: 4, start_addr: 64'h0001_1000, end_addr: 64'h0001_1FFF},  // UART
      '{idx: 5, start_addr: 64'h0001_2000, end_addr: 64'h0001_2FFF}  // GPIO
  // DEFAULT RULE (idx: 0) will route to APB
  };

  localparam axi_pkg::xbar_cfg_t pnoc_xbar_cfg = '{
      NoSlvPorts : 1,
      NoMstPorts : 6,
      MaxMstTrans: 2,
      MaxSlvTrans: 2,
      FallThrough: 0,
      LatencyMode: axi_pkg::CUT_ALL_PORTS,
      PipelineStages: 2,
      AxiIdWidthSlvPorts: 4,
      AxiIdUsedSlvPorts: 4,
      UniqueIds: 1,
      AxiAddrWidth: 32,
      AxiDataWidth: 32,
      NoAddrRules: NumPnocRules
  };

endpackage
