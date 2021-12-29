`timescale 1ns / 1ps
module RGB
       #(parameter Width = 8)(
           input clk, rst_n,
           input [Width -1: 0] RGB_data,//RGB565
           output reg [Width -1: 0] Y2,Cb2,Cr2
       );


//RGB565 转 RGB888
wire [Width -1: 0] R0;
wire [Width -1: 0] G0;
wire [Width -1: 0] B0;
assign R0 = {RGB_data[15:11],RGB_data[13:11]}; //R8
assign G0 = {RGB_data[10: 5],RGB_data[ 6: 5]}; //G8
assign B0 = {RGB_data[ 4: 0],RGB_data[ 2: 0]}; //B8

//RGB888 转 YCbCr
reg [Width -1: 0] R1,G1,B1;
reg [Width -1: 0] R2,G2,B2;
reg [Width -1: 0] R3,G3,B3;
reg [Width -1: 0] Y1,Cb1,Cr1;

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        {R1,G1,B1} <= {16'd0, 16'd0, 16'd0};
        {R2,G2,B2} <= {16'd0, 16'd0, 16'd0};
        {R3,G3,B3} <= {16'd0, 16'd0, 16'd0};
    end
    else
    begin
        {R1,G1,B1} <= { {R0 * 16'd77},  {G0 * 16'd150}, {B0 * 16'd29 } };
        {R2,G2,B2} <= { {R0 * 16'd43},  {G0 * 16'd85},  {B0 * 16'd128} };
        {R3,G3,B3} <= { {R0 * 16'd128}, {G0 * 16'd107}, {B0 * 16'd21 } };
    end
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        Y1  <= 16'd0;
        Cb1 <= 16'd0;
        Cr1 <= 16'd0;
    end
    else
    begin
        Y1  <= R1 + G1 + B1;
        Cb1 <= B2 - R2 - G2 + 16'd32768; //128扩大256倍
        Cr1 <= R3 - G3 - B3 + 16'd32768; //128扩大256倍
    end
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        Y2  <= 8'd0;
        Cb2 <= 8'd0;
        Cr2 <= 8'd0;
    end
    else
    begin
        Y2  <= Y1[15:8];
        Cb2 <= Cb1[15:8];
        Cr2 <= Cr1[15:8];
    end
end
endmodule