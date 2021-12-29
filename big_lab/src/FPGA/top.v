module top
#(parameter Width = 8)
(
    input clk,              //系统时钟50MHz
    input rst_n,            //系统复位
    input rs232_rx,         //串口串行数据发送数据口
    input [2: 0] baud_set,  //波特率选择信号
    output reg rs232_tx,    //FPGA将数据转换成串行数据发出
    output reg tx_done,     //发送数据完毕标志
    output reg uart_state   //串口发送状态，1为忙，0为空闲
);
    wire send_en =1;
    reg [Width-1: 0] data;
    reg rx_done;
    reg [Width -1: 0] Y2,Cb2,Cr2;
    reg [Width -1: 0] face_data;
    wire face_flag;
    wire [3*Width-1 : 0] ycbcr_data;
    assign ycbcr_data = {Y2,Cb2,Cr2};
    UART_Byte_Rx(clk,rst_n,rs232_rx,baud_set,data,rx_done);
    RGB(clk, rst_n,RGB_data,Y2,Cb2,Cr2);
    face_test(clk, rst_n,, ycbcr_data,face_flag,face_data,face_flag);
    mat_13x13(clk, rst_n,Y2,Cb2,Cr2,face_flag);
    erode(clk,rst_n,rx_data,pi_flag,tx_data,po_flag);
    face_seek(clk,rst_n,rx_data,pi_flag,x_min,x_max,y_min,y_max,po_flag);
    UART_Byte_Tx(clk,rst_n,send_en,data_byte,data,rx_done);
    
endmodule