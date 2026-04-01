-d SIMULATION=0

-i ${S1}/hardware/include
-i ${SOC}/include/vip

${S1}/hardware/interface/s1_uart_if.sv

${S1}/hardware/testbench/s1_uart_tx_tb.sv
${S1}/hardware/testbench/s1_uart_rx_tb.sv
${S1}/hardware/testbench/s1_uart_regif_tb.sv
