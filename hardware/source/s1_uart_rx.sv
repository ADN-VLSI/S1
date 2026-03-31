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
  import s1_uart_pkg::txrx_states_t;
(
    input logic arst_ni,
    input logic clk_i,

    input logic       ptp_i,
    input logic       pen_i,
    input logic [1:0] db_i,

    output logic [7:0] data_o,
    output logic       data_err_o,
    output logic       data_valid_o,

    input logic rx_i
);

  logic         [7:0] data_next;

  logic               even_parity;
  logic               odd_parity;

  logic               received_parity;

  txrx_states_t       state;
  txrx_states_t       next_state;

  logic         [1:0] sample_cnt;
  logic               sample_now;

  always_comb begin
    data_err_o = '0;
    if (pen_i) begin
      data_err_o = ptp_i ? (odd_parity != received_parity) : (even_parity != received_parity);
    end
  end

  always_comb sample_now = (state == IDLE) ? '1 : (sample_cnt == 2'b10);

  always_comb data_valid_o = (state == STOP) && sample_now;

  always_comb begin

    txrx_states_t PARITY_STOP;

    PARITY_STOP = pen_i ? PARITY : STOP;

    next_state  = state;
    data_next   = data_o;

    case (state)

      IDLE: begin
        if (rx_i == '0) begin
          next_state = START;
        end
      end

      START: begin
        data_next = '0;
        if (rx_i == '0) begin
          next_state = D0;
        end else begin
          next_state = IDLE;
        end
      end

      D0: begin
        data_next[0] = rx_i;
        next_state   = D1;
      end

      D1: begin
        data_next[1] = rx_i;
        next_state   = D2;
      end

      D2: begin
        data_next[2] = rx_i;
        next_state   = D3;
      end

      D3: begin
        data_next[3] = rx_i;
        next_state   = D4;
      end

      D4: begin
        data_next[4] = rx_i;
        next_state   = (db_i == 2'b00) ? PARITY_STOP : D5;
      end

      D5: begin
        data_next[5] = rx_i;
        next_state   = (db_i == 2'b01) ? PARITY_STOP : D6;
      end

      D6: begin
        data_next[6] = rx_i;
        next_state   = (db_i == 2'b10) ? PARITY_STOP : D7;
      end

      D7: begin
        data_next[7] = rx_i;
        next_state   = PARITY_STOP;
      end

      PARITY: begin
        next_state = STOP;
      end

      STOP: begin
        next_state = IDLE;
      end

      default: begin
        next_state = IDLE;
      end

    endcase
  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      sample_cnt <= '0;
    end else begin
      if (state == IDLE) begin
        sample_cnt <= '0;
      end else begin
        sample_cnt <= sample_cnt + 1;
      end
    end
  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      state <= IDLE;
    end else if (sample_now) begin
      state <= next_state;
    end
  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      data_o <= '0;
    end else begin
      data_o <= data_next;
    end
  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      received_parity <= '0;
    end else if (sample_now && state == PARITY) begin
      received_parity <= rx_i;
    end
  end

  s1_uart_parity_gen u_parity_calc (
      .data_size(db_i),
      .data(data_o),
      .even_parity(even_parity),
      .odd_parity(odd_parity)
  );

endmodule
