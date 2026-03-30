module s1_fifo #(
    parameter bit PIPELINED  = 1,
    parameter int DATA_WIDTH = 8,
    parameter int FIFO_SIZE  = 4
) (
    input logic clk_i,
    input logic arst_ni,

    input  logic [DATA_WIDTH-1:0] data_in_i,
    input  logic                  data_in_valid_i,
    output logic                  data_in_ready_o,

    output logic [DATA_WIDTH-1:0] data_out_o,
    output logic                  data_out_valid_o,
    input  logic                  data_out_ready_i
);

  logic full;
  logic empty;

  logic push;
  logic pop;

  always_comb data_in_ready_o = !full;
  always_comb data_out_valid_o = !empty;

  always_comb push = data_in_valid_i && !full;
  always_comb pop = data_out_ready_i && !empty;

  fifo_v3 #(
      .FALL_THROUGH(~PIPELINED),
      .DATA_WIDTH  (DATA_WIDTH),
      .DEPTH       (2 ** FIFO_SIZE),
      .dtype       (logic [DATA_WIDTH-1:0])
  ) u_fifo (
      .clk_i(clk_i),
      .rst_ni(arst_ni),
      .flush_i('0),
      .testmode_i('0),
      .data_i(data_in_i),
      .push_i(push),
      .full_o(full),
      .data_o(data_out_o),
      .pop_i(pop),
      .empty_o(empty),
      .usage_o()
  );

endmodule
