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


  /*
  
  | Device  | Base Address | Last Address |
  |---------|--------------|--------------|
  | DEBUG   | 0x0000_0000  | 0x0000_FFFF  |
  | CTRL_SS | 0x0001_0000  | 0x0001_0FFF  |
  | UART    | 0x0001_1000  | 0x0001_1FFF  |
  | GPIO    | 0x0001_2000  | 0x0001_2FFF  |
  | PLIC    | 0x0001_3000  | 0x0001_3FFF  |
  | CLINT   | 0x0001_4000  | 0x0001_4FFF  |
  | TCM     | 0x0100_0000  | 0x01FF_FFFF  |
  | APB     | 0x1000_0000  | 0x1FFF_FFFF  |
  | RAM     | 0x2000_0000  | 0x5FFF_FFFF  |

  */
  
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
