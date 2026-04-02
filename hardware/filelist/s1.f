-i ${S1}/hardware/include
-i ${AXI}/include

${AXI}/src/axi_pkg.sv

${S1}/hardware/package/s1_soc_pkg.sv
${S1}/hardware/package/s1_uart_pkg.sv

${S1}/hardware/source/s1_clk_div.sv
${S1}/hardware/source/s1_dual_edge_register.sv
${S1}/hardware/source/s1_fifo.sv

${S1}/hardware/source/s1_uart_parity_gen.sv
${S1}/hardware/source/s1_uart_rx.sv
${S1}/hardware/source/s1_uart_tx.sv
${S1}/hardware/source/s1_uart_regif.sv

${S1}/hardware/source/s1_axi_cvtr.sv
