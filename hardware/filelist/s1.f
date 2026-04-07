-i ${S1}/hardware/include
-i ${AXI}/include
-i ${APB}/include

${AXI}/src/axi_pkg.sv
${APB}/src/apb_pkg.sv

${S1}/hardware/package/s1_pcss_pkg.sv
${S1}/hardware/package/s1_uart_pkg.sv
${S1}/hardware/package/s1_soc_pkg.sv

${S1}/hardware/source/s1_clk_div.sv
${S1}/hardware/source/s1_dual_edge_register.sv
${S1}/hardware/source/s1_register_dual_flop.sv
${S1}/hardware/source/s1_fifo.sv
${S1}/hardware/source/s1_cdc_fifo.sv
${SOC}/source/clk_gate.sv

${S1}/hardware/source/s1_uart_parity_gen.sv
${S1}/hardware/source/s1_uart_rx.sv
${S1}/hardware/source/s1_uart_tx.sv
${S1}/hardware/source/s1_uart_regif.sv
${S1}/hardware/source/s1_uart.sv

${S1}/hardware/source/s1_apb_2_axil.sv
${S1}/hardware/source/s1_axil_2_apb.sv
${S1}/hardware/source/s1_axil_2_axi.sv

${S1}/hardware/source/s1_axi_cvtr.sv

${S1}/hardware/source/s1_pcss.sv

${S1}/hardware/source/s1_soc.sv
