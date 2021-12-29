
module Uart_Byte_Tx(
    input clk, //系统时钟
    input rst_n, //系统复位
    input send_en, //发送使能
    input [7:0] data_byte, //发送的数据
    input [2:0] baud_set, //波特率设置
    output reg rs232_tx, //FPGA将数据转换成串行数据发出
    output reg tx_done, //发送数据完毕标志
    output reg uart_state    //串口发送状态，1为忙，0为空闲
);
 
 
reg   [13: 0] baud_c;
wire  [9: 0] data_out;
reg   [15: 0] cnt0; //1bit数据长度计数
reg   [3: 0] cnt1; //发送一字节数据对每个字节计数
wire  add_cnt0; //计数器cnt0加一条件
wire  add_cnt1; //计数器cnt1加一条件
wire  end_cnt0; //计数器cnt0结束条件
wire  end_cnt1; //计数器cnt1结束条件
reg   [7: 0] data_byte_ff; //发送使能时将发送的数据寄存下来
 
//波特率查找表
always  @(posedge clk or negedge rst_n)begin
     if(rst_n==1'b0)begin
        baud_c <= 5208;
    end
    else begin
        case(baud_set)
            0:      baud_c = 14'd10416;
            1:      baud_c = 14'd5208 ;
            2:      baud_c = 14'd2604 ;
            3:      baud_c = 14'd1302 ;
            4:      baud_c = 14'd868  ;
            5:      baud_c = 14'd434  ;
            default:baud_c = 14'd5208 ;//默认9600bps
        endcase
    end
    
end
 
//串口状态标志，0为空闲，1为忙
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        uart_state <= 0;
    end
    else if(send_en) begin
        uart_state <= 1;
    end
    else if(end_cnt1)begin
        uart_state <= 0;
    end
    else begin
        uart_state <= uart_state;
    end
end
 
//1bit数据长度计数
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0 <= 0;
    end
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0 <= 0;
        else
            cnt0 <= cnt0 + 1'b1;
    end
end
 
assign add_cnt0 = uart_state==1;
assign end_cnt0 = add_cnt0 && cnt0== baud_c-1;
 
//发送一字节数据对每个字节计数
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt1 <= 0;
    end
    else if(add_cnt1)begin
        if(end_cnt1)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 1'b1;
    end
end
 
assign add_cnt1 = end_cnt0;
assign end_cnt1 = add_cnt1 && cnt1== 10-1;
 
//串口发送结束标志
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        tx_done <= 0;
    end
    else if(end_cnt1) begin
        tx_done <= 1;
    end
    else begin
        tx_done <= 0;
    end
end
 
//发送使能时将发送的数据寄存下来
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_byte_ff <= 0;
    end
    else if(send_en) begin
        data_byte_ff <= data_byte;
    end
end
 
//发送串行数据到串口
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        rs232_tx <= 1;
    end
    else if(uart_state && cnt0==0) begin
        rs232_tx <= data_out[cnt1];
    end
end
assign data_out = {1'b1,data_byte_ff,1'b0};
 
endmodule
