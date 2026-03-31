module s1_uart_parity_gen (
    input logic [1:0] data_size,
    input logic [7:0] data,

    output logic even_parity,
    output logic odd_parity
);

  always_comb begin
    logic [7:0] _data;
    _data[4:0] = data[4:0];
    _data[5] = data[5] & (data_size[0] | data_size[1]);
    _data[6] = data[6] & (data_size[1]);
    _data[7] = data[7] & (data_size[0] & data_size[1]);
    even_parity = ^_data;
    odd_parity = ~even_parity;
  end

endmodule
