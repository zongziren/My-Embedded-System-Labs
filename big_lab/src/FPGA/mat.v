module mat_13x13(
           //System Interfaces
           input                   sclk            ,
           input                   rst_n           ,
           //Communication Interfaces
           input           [ 7:0]  rx_data         ,
           input                   pi_flag         ,
           output  wire    [ 7:0]  mat_row1        ,
           output  wire    [ 7:0]  mat_row2        ,
           output  wire    [ 7:0]  mat_row3        ,
           output  wire    [ 7:0]  mat_row4        ,
           output  wire    [ 7:0]  mat_row5        ,
           output  wire    [ 7:0]  mat_row6        ,
           output  wire    [ 7:0]  mat_row7        ,
           output  wire    [ 7:0]  mat_row8        ,
           output  wire    [ 7:0]  mat_row9        ,
           output  wire    [ 7:0]  mat_row10       ,
           output  wire    [ 7:0]  mat_row11       ,
           output  wire    [ 7:0]  mat_row12       ,
           output  wire    [ 7:0]  mat_row13       ,
           output  wire            mat_flag

       );


parameter           COL_NUM     =   1024    ;
parameter           ROW_NUM     =   768     ;

reg                 [10:0]  col_cnt         ;
reg                 [10:0]  row_cnt         ;
wire 						            wr_en1 			    ;
wire                        wr_en2          ;
wire                        wr_en3          ;
wire 						            wr_en4 			    ;
wire 						            wr_en5 			    ;
wire 						            wr_en6 			    ;
wire 						            wr_en7 			    ;
wire 						            wr_en8 			    ;
wire 						            wr_en9 			    ;
wire 						            wr_en10			    ;
wire 						            wr_en11			    ;
wire 						            wr_en12			    ;
wire 						            wr_en13			    ;
wire                        rd_en1          ;
wire                        rd_en2          ;
wire						            rd_en3 			    ;
wire						            rd_en4 			    ;
wire						            rd_en5 			    ;
wire						            rd_en6 			    ;
wire						            rd_en7 			    ;
wire						            rd_en8 			    ;
wire						            rd_en9 			    ;
wire						            rd_en10			    ;
wire						            rd_en11			    ;
wire						            rd_en12			    ;
wire						            rd_en13			    ;
wire                [ 7:0]  fifo1_rd_data   ;
wire                [ 7:0]  fifo2_rd_data   ;
wire                [ 7:0]  fifo3_rd_data   ;
wire                [ 7:0]  fifo4_rd_data   ;
wire                [ 7:0]  fifo5_rd_data   ;
wire                [ 7:0]  fifo6_rd_data   ;
wire                [ 7:0]  fifo7_rd_data   ;
wire                [ 7:0]  fifo8_rd_data   ;
wire                [ 7:0]  fifo9_rd_data   ;
wire                [ 7:0]  fifo10_rd_data  ;
wire                [ 7:0]  fifo11_rd_data  ;
wire                [ 7:0]  fifo12_rd_data  ;
wire                [ 7:0]  fifo13_rd_data  ;



assign 		wr_en1 			= 		pi_flag;
assign      wr_en2          =       row_cnt >= 11'd1 ? pi_flag : 1'b0;
assign      wr_en3          =       row_cnt >= 11'd2 ? pi_flag : 1'b0;
assign      wr_en4          =       row_cnt >= 11'd3 ? pi_flag : 1'b0;
assign      wr_en5          =       row_cnt >= 11'd4 ? pi_flag : 1'b0;
assign      wr_en6          =       row_cnt >= 11'd5 ? pi_flag : 1'b0;
assign      wr_en7          =       row_cnt >= 11'd6 ? pi_flag : 1'b0;
assign      wr_en8          =       row_cnt >= 11'd7 ? pi_flag : 1'b0;
assign      wr_en9          =       row_cnt >= 11'd8 ? pi_flag : 1'b0;
assign      wr_en10         =       row_cnt >= 11'd9 ? pi_flag : 1'b0;
assign      wr_en11         =       row_cnt >= 11'd10 ? pi_flag : 1'b0;
assign      wr_en12         =       row_cnt >= 11'd11 ? pi_flag : 1'b0;
assign      wr_en13         =       row_cnt >= 11'd12 ? pi_flag : 1'b0;

assign      rd_en1          =       wr_en2;
assign      rd_en2          =       wr_en3;
assign      rd_en3          =       wr_en4;
assign      rd_en4          =       wr_en5;
assign      rd_en5          =       wr_en6;
assign      rd_en6          =       wr_en7;
assign      rd_en7          =       wr_en8;
assign      rd_en8          =       wr_en9;
assign      rd_en9          =       wr_en10;
assign      rd_en10         =       wr_en11;
assign      rd_en11         =       wr_en12;
assign      rd_en12         =       wr_en13;
assign      rd_en13         =       mat_flag;

assign      mat_flag        =       row_cnt >= 11'd13 ? pi_flag : 1'b0;
assign      mat_row1        =       fifo1_rd_data;
assign      mat_row2        =       fifo2_rd_data;
assign      mat_row3        =       fifo3_rd_data;
assign      mat_row4        =       fifo4_rd_data;
assign      mat_row5        =       fifo5_rd_data;
assign      mat_row6        =       fifo6_rd_data;
assign      mat_row7        =       fifo7_rd_data;
assign      mat_row8        =       fifo8_rd_data;
assign      mat_row9        =       fifo9_rd_data;
assign      mat_row10       =       fifo10_rd_data;
assign      mat_row11       =       fifo11_rd_data;
assign      mat_row12       =       fifo12_rd_data;
assign      mat_row13       =       fifo13_rd_data;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        col_cnt             <=          11'd0;
    else if(col_cnt == COL_NUM-1 && pi_flag == 1'b1)
        col_cnt             <=          11'd0;
    else if(pi_flag == 1'b1)
        col_cnt             <=          col_cnt + 1'b1;
    else
        col_cnt             <=          col_cnt;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        row_cnt             <=          11'd0;
    else if(row_cnt == ROW_NUM-1 && col_cnt == COL_NUM-1 && pi_flag == 1'b1)
        row_cnt             <=          11'd0;
    else if(col_cnt == COL_NUM-1 && pi_flag == 1'b1)
        row_cnt             <=          row_cnt + 1'b1;


fifo_generator_4 mat_fifo1 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (rx_data                    ),      // input wire [7 : 0] din
                     .wr_en            (wr_en1                     ),  // input wire wr_en
                     .rd_en            (rd_en1                     ),  // input wire rd_en
                     .dout             (fifo1_rd_data              ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo2 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo1_rd_data              ),      // input wire [7 : 0] din
                     .wr_en            (wr_en2                     ),  // input wire wr_en
                     .rd_en            (rd_en2                     ),  // input wire rd_en
                     .dout             (fifo2_rd_data              ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo3 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo2_rd_data              ),      // input wire [7 : 0] din
                     .wr_en            (wr_en3                     ),  // input wire wr_en
                     .rd_en            (rd_en3                     ),  // input wire rd_en
                     .dout             (fifo3_rd_data              ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo4 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo3_rd_data              ),      // input wire [7 : 0] din
                     .wr_en            (wr_en4                     ),  // input wire wr_en
                     .rd_en            (rd_en4                     ),  // input wire rd_en
                     .dout             (fifo4_rd_data              ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo5 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo4_rd_data              ),      // input wire [7 : 0] din
                     .wr_en            (wr_en5                     ),  // input wire wr_en
                     .rd_en            (rd_en5                     ),  // input wire rd_en
                     .dout             (fifo5_rd_data              ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo6 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo5_rd_data              ),      // input wire [7 : 0] din
                     .wr_en            (wr_en6                     ),  // input wire wr_en
                     .rd_en            (rd_en6                     ),  // input wire rd_en
                     .dout             (fifo6_rd_data              ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo7 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo6_rd_data              ),      // input wire [7 : 0] din
                     .wr_en            (wr_en7                     ),  // input wire wr_en
                     .rd_en            (rd_en7                     ),  // input wire rd_en
                     .dout             (fifo7_rd_data              ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo8 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo7_rd_data              ),      // input wire [7 : 0] din
                     .wr_en            (wr_en8                     ),  // input wire wr_en
                     .rd_en            (rd_en8                     ),  // input wire rd_en
                     .dout             (fifo8_rd_data              ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo9 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo8_rd_data              ),      // input wire [7 : 0] din
                     .wr_en            (wr_en9                     ),  // input wire wr_en
                     .rd_en            (rd_en9                     ),  // input wire rd_en
                     .dout             (fifo9_rd_data              ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo10 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo9_rd_data              ),      // input wire [7 : 0] din
                     .wr_en            (wr_en10                    ),  // input wire wr_en
                     .rd_en            (rd_en10                    ),  // input wire rd_en
                     .dout             (fifo10_rd_data             ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo11 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo10_rd_data             ),      // input wire [7 : 0] din
                     .wr_en            (wr_en11                    ),  // input wire wr_en
                     .rd_en            (rd_en11                    ),  // input wire rd_en
                     .dout             (fifo11_rd_data             ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo12 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo11_rd_data             ),      // input wire [7 : 0] din
                     .wr_en            (wr_en12                    ),  // input wire wr_en
                     .rd_en            (rd_en12                    ),  // input wire rd_en
                     .dout             (fifo12_rd_data             ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

fifo_generator_4 mat_fifo13 (
                     .clk              (sclk                       ),      // input wire clk
                     .srst             (~rst_n                     ),    // input wire srst
                     .din              (fifo12_rd_data             ),      // input wire [7 : 0] din
                     .wr_en            (wr_en13                    ),  // input wire wr_en
                     .rd_en            (rd_en13                    ),  // input wire rd_en
                     .dout             (fifo13_rd_data             ),    // output wire [7 : 0] dout
                     .full             (                           ),    // output wire full
                     .empty            (                           )  // output wire empty
                 );

endmodule
