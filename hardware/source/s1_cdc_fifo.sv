module cdc_fifo #(
    parameter int ELEM_WIDTH = 8,
    parameter int FIFO_SIZE  = 2
) (

    input logic arst_ni,

    input  logic                            elem_in_clk_i,
    input  logic [          ELEM_WIDTH-1:0] elem_in_i,
    input  logic                            elem_in_valid_i,
    output logic                            elem_in_ready_o,
    output logic [$clog2(2**FIFO_SIZE)-1:0] elem_in_count_o,

    input  logic                            elem_out_clk_i,
    output logic [          ELEM_WIDTH-1:0] elem_out_o,
    output logic                            elem_out_valid_o,
    input  logic                            elem_out_ready_i,
    output logic [$clog2(2**FIFO_SIZE)-1:0] elem_out_count_o
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic [FIFO_SIZE:0] wr_ptr_pass;
  logic [FIFO_SIZE:0] rd_ptr_pass;

  logic hsi;
  logic hso;

  logic [FIFO_SIZE:0] wr_addr;
  logic [FIFO_SIZE:0] rd_addr;

  logic [FIFO_SIZE:0] wr_addr_;
  logic [FIFO_SIZE:0] rd_addr_;

  logic [FIFO_SIZE:0] wr_addr_p1;
  logic [FIFO_SIZE:0] rd_addr_p1;

  logic [FIFO_SIZE:0] wpgi;
  logic [FIFO_SIZE:0] rpgi;

  logic [FIFO_SIZE:0] wpgo;
  logic [FIFO_SIZE:0] rpgo;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-ASSIGNMENTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  assign hsi = elem_in_valid_i & elem_in_ready_o;
  assign hso = elem_out_valid_o & elem_out_ready_i;

  assign wr_addr_p1 = wr_addr + 1;
  assign rd_addr_p1 = rd_addr + 1;

  if (FIFO_SIZE > 0) begin : g_elem_in_ready_o
    assign elem_in_ready_o = arst_ni & !(
                                (wr_addr[FIFO_SIZE] != rd_addr_[FIFO_SIZE])
                                &&
                                (wr_addr[FIFO_SIZE-1:0] == rd_addr_[FIFO_SIZE-1:0])
                              );
  end else begin : g_elem_in_ready_o
    assign elem_in_ready_o = arst_ni & (wr_addr_ == rd_addr);
  end

  assign elem_out_valid_o = (wr_addr_ != rd_addr);

  assign elem_in_count_o  = wr_addr[FIFO_SIZE-1:0] - rd_addr_[FIFO_SIZE-1:0];
  assign elem_out_count_o = wr_addr_[FIFO_SIZE-1:0] - rd_addr[FIFO_SIZE-1:0];

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  function automatic logic [FIFO_SIZE:0] bin_to_gray(input logic [FIFO_SIZE:0] bin);
    return (bin >> 1) ^ bin;
  endfunction

  function automatic logic [FIFO_SIZE:0] gray_to_bin(input logic [FIFO_SIZE:0] gray);
    logic [FIFO_SIZE:0] bin;
    bin[FIFO_SIZE] = gray[FIFO_SIZE];
    for (int i = FIFO_SIZE - 1; i >= 0; i--) begin
      bin[i] = bin[i+1] ^ gray[i];
    end
    return bin;
  endfunction


  always_comb wr_addr = gray_to_bin(wr_ptr_pass);
  always_comb rd_addr_ = gray_to_bin(rpgo);
  always_comb wr_addr_ = gray_to_bin(wpgo);
  always_comb rd_addr = gray_to_bin(rd_ptr_pass);

  always_comb wpgi = bin_to_gray(wr_addr_p1);
  always_comb rpgi = bin_to_gray(rd_addr_p1);

  always_ff @(posedge elem_in_clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      wr_ptr_pass <= '0;
    end else if (hsi) begin
      wr_ptr_pass <= wpgi;
    end
  end

  s1_register_dual_flop #(
      .ELEM_WIDTH(FIFO_SIZE + 1),
      .RESET_VALUE('0),
      .FIRST_FF_EDGE_POSEDGED(0),
      .LAST_FF_EDGE_POSEDGED(1)
  ) rd_ptr_ic (
      .clk_i  (elem_in_clk_i),
      .arst_ni(arst_ni),
      .en_i   ('1),
      .d_i    (rd_ptr_pass),
      .q_o    (rpgo)
  );

  s1_register_dual_flop #(
      .ELEM_WIDTH(FIFO_SIZE + 1),
      .RESET_VALUE('0),
      .FIRST_FF_EDGE_POSEDGED(0),
      .LAST_FF_EDGE_POSEDGED(1)
  ) wr_ptr_oc (
      .clk_i  (elem_out_clk_i),
      .arst_ni(arst_ni),
      .en_i   ('1),
      .d_i    (wr_ptr_pass),
      .q_o    (wpgo)
  );

  always_ff @(posedge elem_out_clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      rd_ptr_pass <= '0;
    end else if (hso) begin
      rd_ptr_pass <= rpgi;
    end
  end

  if (FIFO_SIZE > 0) begin : g_mem

    logic [ELEM_WIDTH-1:0] mem[(2**FIFO_SIZE)];

    always_ff @(posedge elem_in_clk_i or negedge arst_ni) begin
      if (hsi & arst_ni) begin
        mem[wr_addr[FIFO_SIZE-1:0]] <= elem_in_i;
      end
    end

    always_comb begin
      elem_out_o = mem[rd_addr[FIFO_SIZE-1:0]];
    end

  end else begin : g_mem

    always_ff @(posedge elem_in_clk_i or negedge arst_ni) begin
      if (~arst_ni) begin
        elem_out_o <= '0;
      end else if (hsi) begin
        elem_out_o <= elem_in_i;
      end
    end

  end

endmodule
