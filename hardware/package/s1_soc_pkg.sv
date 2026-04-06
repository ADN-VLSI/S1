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
  parameter int UART_BASE = 'h4000_0000;


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

endpackage
