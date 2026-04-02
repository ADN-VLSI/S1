module s1_axi_ram_tb;

  axi_ram u_dut (
      .clk_i  (1'b0),
      .arst_ni(1'b0),
      .req_i  ('0),
      .resp_o (  /* keep open */)
  );

  initial begin
    #1000;
    $finish;
  end

endmodule
