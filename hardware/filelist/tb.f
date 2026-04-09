-d SIMULATION=0

-i ${S1}/hardware/include
-i ${SOC}/include/vip

-i ${AXI}/include
-i ${APB}/include

${AXI}/src/axi_pkg.sv
${APB}/src/apb_pkg.sv

${S1}/hardware/package/s1_ecss_pkg.sv
${S1}/hardware/package/s1_pcss_pkg.sv

${S1}/hardware/interface/s1_apb_if.sv
${S1}/hardware/interface/s1_uart_if.sv

${S1}/hardware/testbench/s1_uart_tx_tb.sv
${S1}/hardware/testbench/s1_uart_rx_tb.sv
${S1}/hardware/testbench/s1_uart_regif_tb.sv

${S1}/hardware/testbench/s1_axi_ram_tb.sv
${S1}/hardware/testbench/s1_axil_2_apb_tb.sv

${S1}/hardware/testbench/s1_ecss_tb.sv
${S1}/hardware/testbench/s1_pcss_tb.sv

${S1}/hardware/testbench/s1_soc_tb.sv
