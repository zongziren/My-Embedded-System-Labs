`timescale 1ns / 1ps
module face_seek(
           //System Interfaces
           input                   sclk            ,
           input                   rst_n           ,
           //Communication Interfaces
           input           [ 7:0]  rx_data         ,
           input                   pi_flag         ,
           output  reg     [10:0]  x_min           ,
           output  reg     [10:0]  x_max           ,
           output  reg     [10:0]  y_min           ,
           output  reg     [10:0]  y_max           ,
           output  reg             po_flag
       );

parameter           ROW_NUM     =   768-13  ;
parameter           COL_NUM     =   1024    ;

reg                 [10:0]  row_cnt         ;
reg                 [10:0]  col_cnt         ;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        col_cnt             <=              11'd0;
    else if(col_cnt == COL_NUM-1 && pi_flag == 1'b1)
        col_cnt             <=              11'd0;
    else if(pi_flag == 1'b1)
        col_cnt             <=              col_cnt + 1'b1;
    else
        col_cnt             <=              col_cnt;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        row_cnt             <=              11'd0;
    else if(row_cnt == ROW_NUM-1 && col_cnt == COL_NUM-1 && pi_flag == 1'b1)
        row_cnt             <=              11'd0;
    else if(col_cnt == COL_NUM-1 && pi_flag == 1'b1)
        row_cnt             <=              row_cnt + 1'b1;
    else
        row_cnt             <=              row_cnt;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        po_flag             <=              1'b0;
    else if(row_cnt == ROW_NUM-1 && col_cnt == COL_NUM-1 && pi_flag == 1'b1)
        po_flag             <=              1'b1;
    else
        po_flag             <=              1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        x_min               <=              11'd1023;
    else if(po_flag == 1'b1)
        x_min               <=              11'd1023;
    else if(rx_data > 0 && pi_flag == 1'b1 && x_min > col_cnt)
        x_min               <=              col_cnt;
    else
        x_min               <=              x_min;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        x_max               <=              11'd0;
    else if(po_flag == 1'b1)
        x_max               <=              11'd0;
    else if(rx_data > 0 && pi_flag == 1'b1 && x_max < col_cnt)
        x_max               <=              col_cnt;
    else
        x_max               <=              x_max;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        y_min               <=              11'd755;
    else if(po_flag == 1'b1)
        y_min               <=              11'd755;
    else if(rx_data > 0 && pi_flag == 1'b1 && y_min > row_cnt)
        y_min               <=              row_cnt;
    else
        y_min               <=              y_min;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        y_max               <=              11'd0;
    else if(po_flag == 1'b1)
        y_max               <=              11'd0;
    else if(rx_data > 0 && pi_flag == 1'b1 && y_max < row_cnt)
        y_max               <=              row_cnt;
    else
        y_max               <=              y_max;


endmodule
