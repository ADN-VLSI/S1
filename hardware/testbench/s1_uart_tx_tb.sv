module s1_uart_tx_tb;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNAL DECLARATIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////
  // DUT Signals
  ////////////////////////////////////////////////

  logic          arst_ni;
  logic          clk_i;
  logic          sb_i;
  logic          ptp_i;
  logic          pen_i;
  logic    [1:0] db_i;
  logic    [7:0] data_i;
  logic          data_valid_i;
  logic          data_ready_o;
  logic          tx_o;

  ////////////////////////////////////////////////
  // Internal Variables
  ////////////////////////////////////////////////

  realtime       TP = 8.68us;  // Corresponds to 115200 baud rate

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // DUT INSTANTIATION
  //////////////////////////////////////////////////////////////////////////////////////////////////

  s1_uart_tx u_dut (.*);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  task automatic apply_reset();
    #5ns;
    arst_ni      <= '0;
    clk_i        <= '0;
    sb_i         <= '0;
    ptp_i        <= '0;
    pen_i        <= '0;
    db_i         <= '0;
    data_i       <= '0;
    data_valid_i <= '0;
    #5ns;
    arst_ni <= '1;
    #5ns;
  endtask

  task automatic start_clock();
    realtime sample_time;
    fork
      forever begin
        sample_time = TP / 8;  // 4x2
        clk_i <= '1;
        #(sample_time);
        clk_i <= '0;
        #(sample_time);
      end
    join_none
    @(posedge clk_i);
  endtask

  task automatic send(input logic [7:0] data, input logic sb, input logic ptp, input logic pen,
                      input logic [1:0] db, input int baud_rate);
    TP           <= 1s / baud_rate;

    sb_i         <= sb;
    ptp_i        <= ptp;
    pen_i        <= pen;
    db_i         <= db;

    data_i       <= data;
    data_valid_i <= '0;

    @(posedge clk_i);

    data_valid_i <= '1;
    do @(posedge clk_i); while (!data_ready_o);
    data_valid_i <= '0;

    data_valid_i <= '1;
    do @(posedge clk_i); while (!data_ready_o);
    data_valid_i <= '0;

    data_valid_i <= '1;
    do @(posedge clk_i); while (!data_ready_o);
    data_valid_i <= '0;

    @(posedge clk_i);

  endtask

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PROCEDURAL BLOCKS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin

    $dumpfile("s1_uart_tx_tb.vcd");
    $dumpvars(0, s1_uart_tx_tb);

    apply_reset();
    start_clock();

    send(8'hA5, 0, 0, 0, 2'b00, 115200);
    send(8'h5A, 1, 1, 1, 2'b11, 9600);
    send(8'hFF, 0, 1, 0, 2'b01, 19200);

    $finish();

  end


endmodule
