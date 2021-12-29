`timescale 1ns / 1ps
module face_test(
           //System Interfaces
           input                   sclk            ,
           input                   rst_n           ,
           //Communication Interfaces
           input           [23:0]  ycbcr_data      ,
           input                   ycbcr_flag      ,
           output  reg     [ 7:0]  face_data       ,
           output  reg             face_flag
       );

parameter       CB_LOWER        =           77;
parameter       CB_UPPER        =           127;
parameter       CR_LOWER        =           133;
parameter       CR_UPPER        =           173;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        face_data               <=          8'd0;
    else if(ycbcr_data[15:8] > CB_LOWER && ycbcr_data[15:8] < CB_UPPER && ycbcr_data[7:0] > CR_LOWER && ycbcr_data[7:0] < CR_UPPER)
        face_data               <=          8'd255;
    else
        face_data               <=          8'd0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        face_flag               <=          1'b0;
    else
        face_flag               <=          ycbcr_flag;

endmodule
