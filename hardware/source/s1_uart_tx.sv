module s1_uart_tx (
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

  s1_uart_pkg::txrx_states_t state;
  s1_uart_pkg::txrx_states_t next_state;

  always_comb begin

    s1_uart_pkg::txrx_states_t PARITY_STOP;

    PARITY_STOP = pen_i ? s1_uart_pkg::PARITY : s1_uart_pkg::STOP;

    next_state = state;
    tx_o = '1;
    data_ready_o = '0;

    case (state)

      s1_uart_pkg::IDLE: begin
        if (data_valid_i) begin
          next_state = s1_uart_pkg::START;
        end
      end

      s1_uart_pkg::START: begin
        tx_o = '0;
        next_state = s1_uart_pkg::D0;
      end

      s1_uart_pkg::D0: begin
        tx_o = data_i[0];
        next_state = s1_uart_pkg::D1;
      end

      s1_uart_pkg::D1: begin
        tx_o = data_i[1];
        next_state = s1_uart_pkg::D2;
      end

      s1_uart_pkg::D2: begin
        tx_o = data_i[2];
        next_state = s1_uart_pkg::D3;
      end

      s1_uart_pkg::D3: begin
        tx_o = data_i[3];
        next_state = s1_uart_pkg::D4;
      end

      s1_uart_pkg::D4: begin
        tx_o = data_i[4];
        next_state = (db_i == 2'b00) ? PARITY_STOP : s1_uart_pkg::D5;
      end

      s1_uart_pkg::D5: begin
        tx_o = data_i[5];
        next_state = (db_i == 2'b01) ? PARITY_STOP : s1_uart_pkg::D6;
      end

      s1_uart_pkg::D6: begin
        tx_o = data_i[6];
        next_state = (db_i == 2'b10) ? PARITY_STOP : s1_uart_pkg::D7;
      end

      s1_uart_pkg::D7: begin
        tx_o = data_i[7];
        next_state = PARITY_STOP;
      end

      s1_uart_pkg::PARITY: begin
        tx_o = ptp_i ? odd_parity : even_parity;
        next_state = s1_uart_pkg::STOP;
      end

      s1_uart_pkg::STOP: begin
        tx_o = '1;
        next_state = sb_i ? s1_uart_pkg::STOP_2 : s1_uart_pkg::IDLE;
        data_ready_o = 1'b1;
      end

      s1_uart_pkg::STOP_2: begin
        tx_o = '1;
        next_state = s1_uart_pkg::IDLE;
      end

      default: begin
        next_state = s1_uart_pkg::IDLE;
      end

    endcase

  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      state <= s1_uart_pkg::IDLE;
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
