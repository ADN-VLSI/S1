module uart_tx
  import s1_uart_pkg::IDLE;
  import s1_uart_pkg::START;
  import s1_uart_pkg::D0;
  import s1_uart_pkg::D1;
  import s1_uart_pkg::D2;
  import s1_uart_pkg::D3;
  import s1_uart_pkg::D4;
  import s1_uart_pkg::D5;
  import s1_uart_pkg::D6;
  import s1_uart_pkg::D7;
  import s1_uart_pkg::PARITY;
  import s1_uart_pkg::STOP;
  import s1_uart_pkg::STOP_2;
  import s1_uart_pkg::txrx_states_t;
(
    input logic arst_ni,
    input logic clk_i,

    input logic       sb_i,
    input logic       ptp_i,
    input logic       pen_i,
    input logic [1:0] db_i,

    input  logic [7:0] data_i,
    input  logic       data_valid_i,
    output logic       data_ready_o,

    output logic tx_o
);

  logic even_parity;
  logic odd_parity;

  txrx_states_t state;
  txrx_states_t next_state;

  always_comb begin

    txrx_states_t PARITY_STOP;

    PARITY_STOP = pen_i ? PARITY : STOP;

    next_state = state;
    tx_o = '1;
    data_ready_o = '0;

    case (state)

      IDLE: begin
        if (data_valid_i) begin
          next_state = START;
        end
      end

      START: begin
        tx_o = '0;
        next_state = D0;
      end

      D0: begin
        tx_o = data_i[0];
        next_state = D1;
      end

      D1: begin
        tx_o = data_i[1];
        next_state = D2;
      end

      D2: begin
        tx_o = data_i[2];
        next_state = D3;
      end

      D3: begin
        tx_o = data_i[3];
        next_state = D4;
      end

      D4: begin
        tx_o = data_i[4];
        next_state = (db_i == 2'b00) ? PARITY_STOP : D5;
      end

      D5: begin
        tx_o = data_i[5];
        next_state = (db_i == 2'b01) ? PARITY_STOP : D6;
      end

      D6: begin
        tx_o = data_i[6];
        next_state = (db_i == 2'b10) ? PARITY_STOP : D7;
      end

      D7: begin
        tx_o = data_i[7];
        next_state = PARITY_STOP;
      end

      PARITY: begin
        tx_o = ptp_i ? odd_parity : even_parity;
        next_state = STOP;
      end

      STOP: begin
        tx_o = '1;
        next_state = sb_i ? STOP_2 : IDLE;
        data_ready_o = 1'b1;
      end

      STOP_2: begin
        tx_o = '1;
        next_state = IDLE;
      end

      default: begin
        next_state = IDLE;
      end

    endcase

  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  s1_uart_parity_gen u_parity_calc (
      .data_size(db_i),
      .data(data_i),
      .even_parity(even_parity),
      .odd_parity(odd_parity)
  );


endmodule
