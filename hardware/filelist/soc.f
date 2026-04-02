-d XSIM
-d VERILATOR

-i ${COMMON_CELLS}/include
-i ${AXI}/include

${AXI}/src/axi_pkg.sv

${SOC}/package/ariane_axi_pkg.sv
${SOC}/package/soc_pkg.sv

${AXI}/src/axi_demux_id_counters.sv
${S1}/hardware/fixed/axi_burst_splitter_gran.sv

${SOC}/source/axi_to_simple_if.sv
${SOC}/source/axi_ram.sv
