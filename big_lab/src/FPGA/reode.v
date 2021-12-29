`timescale 1ns / 1ps
module erode(
           //System Interfaces
           input                   sclk            ,
           input                   rst_n           ,
           //Communication Interfaces
           input           [ 7:0]  rx_data         ,
           input                   pi_flag         ,
           output  reg     [ 7:0]  tx_data         ,
           output  wire            po_flag
       );

wire                [ 7:0]  mat_row1                ;
wire                [ 7:0]  mat_row2                ;
wire                [ 7:0]  mat_row3                ;
wire                [ 7:0]  mat_row4                ;
wire                [ 7:0]  mat_row5                ;
wire                [ 7:0]  mat_row6                ;
wire                [ 7:0]  mat_row7                ;
wire                [ 7:0]  mat_row8                ;
wire                [ 7:0]  mat_row9                ;
wire                [ 7:0]  mat_row10               ;
wire                [ 7:0]  mat_row11               ;
wire                [ 7:0]  mat_row12               ;
wire                [ 7:0]  mat_row13               ;

reg                 [ 7:0]  mat_row1_r[12:0]        ;
reg                 [ 7:0]  mat_row2_r[12:0]        ;
reg                 [ 7:0]  mat_row3_r[12:0]        ;
reg                 [ 7:0]  mat_row4_r[12:0]        ;
reg                 [ 7:0]  mat_row5_r[12:0]        ;
reg                 [ 7:0]  mat_row6_r[12:0]        ;
reg                 [ 7:0]  mat_row7_r[12:0]        ;
reg                 [ 7:0]  mat_row8_r[12:0]        ;
reg                 [ 7:0]  mat_row9_r[12:0]        ;
reg                 [ 7:0]  mat_row10_r[12:0]       ;
reg                 [ 7:0]  mat_row11_r[12:0]       ;
reg                 [ 7:0]  mat_row12_r[12:0]       ;
reg                 [ 7:0]  mat_row13_r[12:0]       ;
wire                        mat_flag                ;
reg                         mat_flag_r1             ;
reg                         mat_flag_r2             ;
reg                         mat_flag_r3             ;
reg                         mat_flag_r4             ;
reg                         mat_flag_r5             ;
reg                         mat_flag_r6             ;
reg                         mat_flag_r7             ;
reg                         mat_flag_r8             ;
reg                         mat_flag_r9             ;
reg                         mat_flag_r10            ;
reg                         mat_flag_r11            ;
reg                         mat_flag_r12            ;
reg                         mat_flag_r13            ;
reg                         mat_flag_r14            ;
reg                         mat_flag_r15            ;
reg                         mat_flag_r16            ;
reg                         erode_flag1             ;
reg                         erode_flag2             ;
reg                         erode_flag3             ;
reg                         erode_flag4             ;
reg                         erode_flag5             ;
reg                         erode_flag6             ;
reg                         erode_flag7             ;
reg                         erode_flag8             ;
reg                         erode_flag9             ;
reg                         erode_flag10            ;
reg                         erode_flag11            ;
reg                         erode_flag12            ;
reg                         erode_flag13            ;


assign      po_flag             =           mat_flag_r16 && mat_flag_r3;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
    begin
        mat_row1_r[0]           <=          8'd0;
        mat_row2_r[0]           <=          8'd0;
        mat_row3_r[0]           <=          8'd0;
        mat_row4_r[0]           <=          8'd0;
        mat_row5_r[0]           <=          8'd0;
        mat_row6_r[0]           <=          8'd0;
        mat_row7_r[0]           <=          8'd0;
        mat_row8_r[0]           <=          8'd0;
        mat_row9_r[0]           <=          8'd0;
        mat_row10_r[0]          <=          8'd0;
        mat_row11_r[0]          <=          8'd0;
        mat_row12_r[0]          <=          8'd0;
        mat_row13_r[0]          <=          8'd0;
    end
    else
    begin
        mat_row1_r[0]           <=          mat_row1;
        mat_row2_r[0]           <=          mat_row2;
        mat_row3_r[0]           <=          mat_row3;
        mat_row4_r[0]           <=          mat_row4;
        mat_row5_r[0]           <=          mat_row5;
        mat_row6_r[0]           <=          mat_row6;
        mat_row7_r[0]           <=          mat_row7;
        mat_row8_r[0]           <=          mat_row8;
        mat_row9_r[0]           <=          mat_row9;
        mat_row10_r[0]          <=          mat_row10;
        mat_row11_r[0]          <=          mat_row11;
        mat_row12_r[0]          <=          mat_row12;
        mat_row13_r[0]          <=          mat_row13;
    end

genvar i;
generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row1_r[i]       <=      8'd0;
            else
                mat_row1_r[i]       <=      mat_row1_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row2_r[i]       <=      8'd0;
            else
                mat_row2_r[i]       <=      mat_row2_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row3_r[i]       <=      8'd0;
            else
                mat_row3_r[i]       <=      mat_row3_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row4_r[i]       <=      8'd0;
            else
                mat_row4_r[i]       <=      mat_row4_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row5_r[i]       <=      8'd0;
            else
                mat_row5_r[i]       <=      mat_row5_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row6_r[i]       <=      8'd0;
            else
                mat_row6_r[i]       <=      mat_row6_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row7_r[i]       <=      8'd0;
            else
                mat_row7_r[i]       <=      mat_row7_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row8_r[i]       <=      8'd0;
            else
                mat_row8_r[i]       <=      mat_row8_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row9_r[i]       <=      8'd0;
            else
                mat_row9_r[i]       <=      mat_row9_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row10_r[i]      <=      8'd0;
            else
                mat_row10_r[i]      <=      mat_row10_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row11_r[i]      <=      8'd0;
            else
                mat_row11_r[i]      <=      mat_row11_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row12_r[i]      <=      8'd0;
            else
                mat_row12_r[i]      <=      mat_row12_r[i-1];
endgenerate

generate
    for (i=1; i < 13; i=i+1)
        always @(posedge sclk or negedge rst_n)
            if(rst_n == 1'b0)
                mat_row13_r[i]      <=      8'd0;
            else
                mat_row13_r[i]      <=      mat_row13_r[i-1];
endgenerate

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag1             <=          1'b0;
    else if(mat_row1_r[12] == 255 && mat_row1_r[11] == 255 && mat_row1_r[10] == 255 && mat_row1_r[9] == 255 && mat_row1_r[8] == 255 && mat_row1_r[7] == 255 &&
            mat_row1_r[6] == 255 && mat_row1_r[5] == 255 && mat_row1_r[4] == 255 && mat_row1_r[3] == 255 && mat_row1_r[2] == 255 && mat_row1_r[1] == 255 && mat_row1_r[0] == 255)
        erode_flag1             <=          1'b1;
    else
        erode_flag1             <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag2             <=          1'b0;
    else if(mat_row2_r[12] == 255 && mat_row2_r[11] == 255 && mat_row2_r[10] == 255 && mat_row2_r[9] == 255 && mat_row2_r[8] == 255 && mat_row2_r[7] == 255 &&
            mat_row2_r[6] == 255 && mat_row2_r[5] == 255 && mat_row2_r[4] == 255 && mat_row2_r[3] == 255 && mat_row2_r[2] == 255 && mat_row2_r[1] == 255 && mat_row2_r[0] == 255)
        erode_flag2             <=          1'b1;
    else
        erode_flag2             <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag3             <=          1'b0;
    else if(mat_row3_r[12] == 255 && mat_row3_r[11] == 255 && mat_row3_r[10] == 255 && mat_row3_r[9] == 255 && mat_row3_r[8] == 255 && mat_row3_r[7] == 255 &&
            mat_row3_r[6] == 255 && mat_row3_r[5] == 255 && mat_row3_r[4] == 255 && mat_row3_r[3] == 255 && mat_row3_r[2] == 255 && mat_row3_r[1] == 255 && mat_row3_r[0] == 255)
        erode_flag3             <=          1'b1;
    else
        erode_flag3             <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag4             <=          1'b0;
    else if(mat_row4_r[12] == 255 && mat_row4_r[11] == 255 && mat_row4_r[10] == 255 && mat_row4_r[9] == 255 && mat_row4_r[8] == 255 && mat_row4_r[7] == 255 &&
            mat_row4_r[6] == 255 && mat_row4_r[5] == 255 && mat_row4_r[4] == 255 && mat_row4_r[3] == 255 && mat_row4_r[2] == 255 && mat_row4_r[1] == 255 && mat_row4_r[0] == 255)
        erode_flag4             <=          1'b1;
    else
        erode_flag4             <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag5             <=          1'b0;
    else if(mat_row5_r[12] == 255 && mat_row5_r[11] == 255 && mat_row5_r[10] == 255 && mat_row5_r[9] == 255 && mat_row5_r[8] == 255 && mat_row5_r[7] == 255 &&
            mat_row5_r[6] == 255 && mat_row5_r[5] == 255 && mat_row5_r[4] == 255 && mat_row5_r[3] == 255 && mat_row5_r[2] == 255 && mat_row5_r[1] == 255 && mat_row5_r[0] == 255)
        erode_flag5             <=          1'b1;
    else
        erode_flag5             <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag6             <=          1'b0;
    else if(mat_row6_r[12] == 255 && mat_row6_r[11] == 255 && mat_row6_r[10] == 255 && mat_row6_r[9] == 255 && mat_row6_r[8] == 255 && mat_row6_r[7] == 255 &&
            mat_row6_r[6] == 255 && mat_row6_r[5] == 255 && mat_row6_r[4] == 255 && mat_row6_r[3] == 255 && mat_row6_r[2] == 255 && mat_row6_r[1] == 255 && mat_row6_r[0] == 255)
        erode_flag6             <=          1'b1;
    else
        erode_flag6             <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag7             <=          1'b0;
    else if(mat_row7_r[12] == 255 && mat_row7_r[11] == 255 && mat_row7_r[10] == 255 && mat_row7_r[9] == 255 && mat_row7_r[8] == 255 && mat_row7_r[7] == 255 &&
            mat_row7_r[6] == 255 && mat_row7_r[5] == 255 && mat_row7_r[4] == 255 && mat_row7_r[3] == 255 && mat_row7_r[2] == 255 && mat_row7_r[1] == 255 && mat_row7_r[0] == 255)
        erode_flag7             <=          1'b1;
    else
        erode_flag7             <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag8             <=          1'b0;
    else if(mat_row8_r[12] == 255 && mat_row8_r[11] == 255 && mat_row8_r[10] == 255 && mat_row8_r[9] == 255 && mat_row8_r[8] == 255 && mat_row8_r[7] == 255 &&
            mat_row8_r[6] == 255 && mat_row8_r[5] == 255 && mat_row8_r[4] == 255 && mat_row8_r[3] == 255 && mat_row8_r[2] == 255 && mat_row8_r[1] == 255 && mat_row8_r[0] == 255)
        erode_flag8             <=          1'b1;
    else
        erode_flag8             <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag9             <=          1'b0;
    else if(mat_row9_r[12] == 255 && mat_row9_r[11] == 255 && mat_row9_r[10] == 255 && mat_row9_r[9] == 255 && mat_row9_r[8] == 255 && mat_row9_r[7] == 255 &&
            mat_row9_r[6] == 255 && mat_row9_r[5] == 255 && mat_row9_r[4] == 255 && mat_row9_r[3] == 255 && mat_row9_r[2] == 255 && mat_row9_r[1] == 255 && mat_row9_r[0] == 255)
        erode_flag9             <=          1'b1;
    else
        erode_flag9             <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag10            <=          1'b0;
    else if(mat_row10_r[12] == 255 && mat_row10_r[11] == 255 && mat_row10_r[10] == 255 && mat_row10_r[9] == 255 && mat_row10_r[8] == 255 && mat_row10_r[7] == 255 &&
            mat_row10_r[6] == 255 && mat_row10_r[5] == 255 && mat_row10_r[4] == 255 && mat_row10_r[3] == 255 && mat_row10_r[2] == 255 && mat_row10_r[1] == 255 && mat_row10_r[0] == 255)
        erode_flag10            <=          1'b1;
    else
        erode_flag10            <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag11            <=          1'b0;
    else if(mat_row11_r[12] == 255 && mat_row11_r[11] == 255 && mat_row11_r[10] == 255 && mat_row11_r[9] == 255 && mat_row11_r[8] == 255 && mat_row11_r[7] == 255 &&
            mat_row11_r[6] == 255 && mat_row11_r[5] == 255 && mat_row11_r[4] == 255 && mat_row11_r[3] == 255 && mat_row11_r[2] == 255 && mat_row11_r[1] == 255 && mat_row11_r[0] == 255)
        erode_flag11            <=          1'b1;
    else
        erode_flag11            <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag12            <=          1'b0;
    else if(mat_row12_r[12] == 255 && mat_row12_r[11] == 255 && mat_row12_r[10] == 255 && mat_row12_r[9] == 255 && mat_row12_r[8] == 255 && mat_row12_r[7] == 255 &&
            mat_row12_r[6] == 255 && mat_row12_r[5] == 255 && mat_row12_r[4] == 255 && mat_row12_r[3] == 255 && mat_row12_r[2] == 255 && mat_row12_r[1] == 255 && mat_row12_r[0] == 255)
        erode_flag12            <=          1'b1;
    else
        erode_flag12            <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        erode_flag13            <=          1'b0;
    else if(mat_row13_r[12] == 255 && mat_row13_r[11] == 255 && mat_row13_r[10] == 255 && mat_row13_r[9] == 255 && mat_row13_r[8] == 255 && mat_row13_r[7] == 255 &&
            mat_row13_r[6] == 255 && mat_row13_r[5] == 255 && mat_row13_r[4] == 255 && mat_row13_r[3] == 255 && mat_row13_r[2] == 255 && mat_row13_r[1] == 255 && mat_row13_r[0] == 255)
        erode_flag13            <=          1'b1;
    else
        erode_flag13            <=          1'b0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        tx_data                 <=          8'd0;
    else if(erode_flag12 == 1'b1 && erode_flag11 == 1'b1 && erode_flag10 == 1'b1 && erode_flag9 == 1'b1 && erode_flag8 == 1'b1 && erode_flag7 == 1'b1 && erode_flag6 == 1'b1 &&
            erode_flag5 == 1'b1  && erode_flag4 == 1'b1 && erode_flag3 == 1'b1 && erode_flag2 == 1'b1 && erode_flag1 == 1'b1 && erode_flag13 == 1'b1)
        tx_data                 <=          8'd255;
    else
        tx_data                 <=          8'd0;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
    begin
        mat_flag_r1             <=          1'b0;
        mat_flag_r2             <=          1'b0;
        mat_flag_r3             <=          1'b0;
        mat_flag_r4             <=          1'b0;
        mat_flag_r5             <=          1'b0;
        mat_flag_r6             <=          1'b0;
        mat_flag_r7             <=          1'b0;
        mat_flag_r8             <=          1'b0;
        mat_flag_r9             <=          1'b0;
        mat_flag_r10            <=          1'b0;
        mat_flag_r11            <=          1'b0;
        mat_flag_r12            <=          1'b0;
        mat_flag_r13            <=          1'b0;
        mat_flag_r14            <=          1'b0;
        mat_flag_r15            <=          1'b0;
        mat_flag_r16            <=          1'b0;
    end
    else
    begin
        mat_flag_r1             <=          mat_flag;
        mat_flag_r2             <=          mat_flag_r1;
        mat_flag_r3             <=          mat_flag_r2;
        mat_flag_r4             <=          mat_flag_r3;
        mat_flag_r5             <=          mat_flag_r4;
        mat_flag_r6             <=          mat_flag_r5;
        mat_flag_r7             <=          mat_flag_r6;
        mat_flag_r8             <=          mat_flag_r7;
        mat_flag_r9             <=          mat_flag_r8;
        mat_flag_r10            <=          mat_flag_r9;
        mat_flag_r11            <=          mat_flag_r10;
        mat_flag_r12            <=          mat_flag_r11;
        mat_flag_r13            <=          mat_flag_r12;
        mat_flag_r14            <=          mat_flag_r13;
        mat_flag_r15            <=          mat_flag_r14;
        mat_flag_r16            <=          mat_flag_r15;
    end


mat_13x13 mat_13x13_inst(
              //System Interfaces
              .sclk                   (sclk                   ),
              .rst_n                  (rst_n                  ),
              //Communication Interfaces
              .rx_data                (rx_data                ),
              .pi_flag                (pi_flag                ),
              .mat_row1               (mat_row1               ),
              .mat_row2               (mat_row2               ),
              .mat_row3               (mat_row3               ),
              .mat_row4               (mat_row4               ),
              .mat_row5               (mat_row5               ),
              .mat_row6               (mat_row6               ),
              .mat_row7               (mat_row7               ),
              .mat_row8               (mat_row8               ),
              .mat_row9               (mat_row9               ),
              .mat_row10              (mat_row10              ),
              .mat_row11              (mat_row11              ),
              .mat_row12              (mat_row12              ),
              .mat_row13              (mat_row13              ),
              .mat_flag               (mat_flag               )

          );
endmodule
