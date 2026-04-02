module s1_uart_top 
  import s1_uart_pkg::uart_axil_aw_chan_t;
  import s1_uart_pkg::uart_axil_w_chan_t;
  import s1_uart_pkg::uart_axil_b_chan_t;
  import s1_uart_pkg::uart_axil_ar_chan_t;
  import s1_uart_pkg::uart_axil_r_chan_t;
  import s1_uart_pkg::uart_axil_req_t;
  import s1_uart_pkg::uart_axil_resp_t;

  import s1_uart_pkg::uart_ctrl_reg_t;
  import s1_uart_pkg::uart_cfg_reg_t;
  import s1_uart_pkg::uart_stat_reg_t;
  import s1_uart_pkg::uart_id_t;
  import s1_uart_pkg::uart_data_t;
  import s1_uart_pkg::uart_count_t;
  import s1_uart_pkg::uart_int_reg_t;
  
(
    input logic clk_i,
    input logic arst_ni,

    input  uart_axil_req_t  req_i,
    output uart_axil_resp_t resp_o,

    output logic  tx_o,
    input  logic  rx_i,

    output uart_int_reg_t uart_int_en_o

);

    uart_ctrl_reg_t uart_ctrl_o     ;
    uart_cfg_reg_t  uart_cfg_o      ;
    uart_stat_reg_t uart_stat_o     ;

    uart_count_t    tx_data_cnt_i   ;
    uart_data_t     tx_data_o       ;
    logic           tx_data_valid_o ;
    logic           tx_data_ready_i ;

    // uart_count_t    to_tx_data_cnt_i   ; //! use case?
    uart_data_t     to_tx_data_o       ;
    logic           to_tx_data_valid_o ;
    logic           to_tx_data_ready_i ;

    uart_count_t    rx_data_cnt_i   ;
    uart_data_t     rx_data_i       ;
    logic           rx_data_valid_i ;
    logic           rx_data_ready_o ;

    // uart_count_t    from_rx_data_cnt_i   ;   //! usage?
    uart_data_t     from_rx_data_i       ;
    logic           from_rx_data_valid_i ;
    logic           from_rx_data_ready_o ;

    s1_uart_regif u_s1_uart_regif(
        .clk_i           (clk_i           ),
        .arst_ni         (arst_ni         ),
        .req_i           (req_i           ),
        .resp_o          (resp_o          ),
        .uart_ctrl_o     (uart_ctrl_o     ),
        .uart_cfg_o      (uart_cfg_o      ),
        .uart_stat_o     (uart_stat_o     ),
        .tx_data_cnt_i   (tx_data_cnt_i   ),
        .tx_data_o       (tx_data_o       ),
        .tx_data_valid_o (tx_data_valid_o ),
        .tx_data_ready_i (tx_data_ready_i ),
        .rx_data_cnt_i   (rx_data_cnt_i   ),
        .rx_data_i       (rx_data_i       ),
        .rx_data_valid_i (rx_data_valid_i ),
        .rx_data_ready_o (rx_data_ready_o ),
        .uart_int_en_o   (uart_int_en_o   )
    );


    logic tx_clk;
    logic rx_clk;
    logic sc_clk;   // scaled clock

    s1_clk_div #(
        .DIV_WIDTH(4)
    ) u_sc_s1_clk_div (
        .arst_ni (arst_ni),     
        .clk_i   (clk_i),            
        .div_i   (uart_cfg_o.psclr),            
        .clk_o   (sc_clk)             
    );
    
    s1_clk_div #(
        .DIV_WIDTH(10)
    ) u_rx_s1_clk_div (
        .arst_ni (arst_ni),
        .clk_i   (sc_clk),
        .div_i   (uart_cfg_o.clk_div[11:2]),
        .clk_o   (rx_clk)
    );

    s1_clk_div #(
        .DIV_WIDTH(3)
    ) u_tx_s1_clk_div (
        .arst_ni (arst_ni),     
        .clk_i   (rx_clk),            
        .div_i   (4),            
        .clk_o   (tx_clk)             
    );

    cdc_fifo_gray #(
        .WIDTH(8),
        .T(logic [WIDTH-1:0]),
        .LOG_DEPTH (3),         //! 8 elem?
        .SYNC_STAGES(2)         //! 2 stage synchronizer
    ) tx_fifo (
        .src_rst_ni  (arst_ni               ),
        .src_clk_i   (clk_i                 ),
        .src_data_i  (tx_data_o.data        ),
        .src_valid_i (tx_data_valid_o       ),
        .src_ready_o (tx_data_ready_i       ),

        .dst_rst_ni  (arst_ni               ),
        .dst_clk_i   (tx_clk                ),
        .dst_data_o  (to_tx_data_o.data     ),
        .dst_valid_o (to_tx_data_valid_o    ),
        .dst_ready_i (to_tx_data_ready_i    )
    );

    cdc_fifo_gray #(
        .WIDTH(8),
        .T(logic [WIDTH-1:0]),
        .LOG_DEPTH (3),         //! 8 elem?
        .SYNC_STAGES(2)         //! 2 stage synchronizer
    ) rx_fifo (
        .src_rst_ni  (arst_ni           ),
        .src_clk_i   (rx_clk            ),
        .src_data_i  (from_rx_data_i.data),
        .src_valid_i ( from_rx_data_valid_i),
        .src_ready_o ( 1),      //! always ready? since no ready in uart_rx

        .dst_rst_ni  (arst_ni           ),
        .dst_clk_i   (clk_i             ),
        .dst_data_o  (rx_data_i         ),
        .dst_valid_o (rx_data_valid_i   ),
        .dst_ready_i (rx_data_ready_o   )
    ); 
    
    s1_uart_tx u_s1_uart_tx (
        .arst_ni      (arst_ni             ),
        .clk_i        (clk_i               ),
        .sb_i         (uart_cfg_o.sb       ),
        .ptp_i        (uart_cfg_o.ptp      ),
        .pen_i        (uart_cfg_o.pen      ),
        .db_i         (uart_cfg_o.db       ),
        .data_i       (to_tx_data_o.data   ),
        .data_valid_i (to_tx_data_valid_o  ),
        .data_ready_o (to_tx_data_ready_i  ),
        .tx_o         (tx_o                )
    );


    s1_uart_rx u_s1_uart_rx (
        .arst_ni      (arst_ni                     ),
        .clk_i        (clk_i                       ),
        .ptp_i        (uart_cfg_o.ptp              ),
        .pen_i        (uart_cfg_o.pen              ),
        .db_i         (uart_cfg_o.db               ),
        .data_o       (from_rx_data_i.data         ),
        .data_err_o   (uart_int_en_o.rx_parity_err ),
        .data_valid_o (from_rx_data_valid_i        ),
        .rx_i         (rx_i                        )
    );


endmodule
