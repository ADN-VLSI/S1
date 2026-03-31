module uart_tx (
    input logic arst_ni,  // Asynchronous reset, active low
    input logic clk_i,    // Clock input (8x baud rate)

    input logic [1:0] data_i,   // 8-bit data to transmit
    input logic parity_en_i,     // Enable parity bit
    input logic parity_type_i,   // REMOVE if not needed (parity type, e.g., even/odd)
    input logic extra_stop_i,    // Enable extra stop bit

    input  logic [7:0] data_i,        // 8-bit data to transmit
    input  logic       data_valid_i,  // Data valid signal
    output logic       data_ready_o,  // Ready for next data


    output logic tx_o  // UART TX output
);

endmodule
