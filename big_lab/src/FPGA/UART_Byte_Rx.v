module UART_Byte_Rx(
    input clk,//系统时钟50MHz
    input rst_n,//系统复位
    input rs232_tx,//串口串行数据发送数据口
    input [2: 0] baud_set,//波特率选择信号
    output reg [7: 0] data_byte,//并行数据输出
    output reg  rx_done//接收1字节数据完成标志，rx_done可以作为输出有效信号使用
);
reg [13:0] baud_c;//波特率
reg rs232_tx_ff0;
reg rs232_tx_ff1;
reg rs232_tx_ff2;
wire tx_neg_flag;
reg add_flag;
 
reg [13:0] cnt0;
reg [3:0] cnt1;
reg [9:0] cnt2;
reg [3:0] cnt3;
reg [2:0] cnt_0;
reg [2:0] cnt_1;
 
wire add_cnt0;
wire end_cnt0;
wire add_cnt1;
wire end_cnt1;
wire add_cnt2;
wire end_cnt2;
wire add_cnt3;
wire end_cnt3;
 
//查找表
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
 
//打两拍 防止亚稳态，同时scan negedge
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        rs232_tx_ff0 <= 1;
        rs232_tx_ff1 <= 1;
        rs232_tx_ff2 <= 1;
    end
    else begin
        rs232_tx_ff0 <= rs232_tx;
        rs232_tx_ff1 <= rs232_tx_ff0;
        rs232_tx_ff2 <= rs232_tx_ff1;
    end
end
//扫描下降沿
assign tx_neg_flag = rs232_tx_ff2 && !rs232_tx_ff1;
 
//计数标志信号
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        add_flag <= 0;
    end
    else if(tx_neg_flag) begin
        add_flag <= 1;
    end
    else if(rx_done)begin
    add_flag <= 0;
    end
end
 
//计数器，计数1bit数据长度
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
 
assign add_cnt0 = add_flag;
assign end_cnt0 = add_cnt0 && cnt0==baud_c-1;
 
//计数器，计数8位接收数据长度
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
assign end_cnt1 = add_cnt1 && cnt1== 8;
 
//比特内部采样点时钟计数
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt2 <= 0;
    end
    else if(add_cnt2)begin
        if(end_cnt2)
            cnt2 <= 0;
        else
            cnt2 <= cnt2 + 1'b1;
    end
end
 
assign add_cnt2 = add_flag;       
assign end_cnt2 = add_cnt2 && (cnt2== (baud_c/16)-1 || end_cnt0);   
 
//一个bit数据中16个采样点计数
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt3 <= 0;
    end
    else if(add_cnt3)begin
        if(end_cnt3)
            cnt3 <= 0;
        else
            cnt3 <= cnt3 + 1'b1;
    end
end
 
assign add_cnt3 = add_cnt2 && cnt2== (baud_c/16)-1;       
assign end_cnt3 = end_cnt0 || (end_cnt2 && cnt3==16-1);   
 
//比特内选取6个采样点是0或1计数
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        cnt_0 <= 0;
        cnt_1 <= 0;
    end
    else if(add_flag) begin
        if(cnt3>=6 && cnt3<=11)begin
            if(cnt2==baud_c/16/2 && rs232_tx_ff1==0)
                cnt_0 <= cnt_0 + 1'b1;
            else if(cnt2==baud_c/16/2 && rs232_tx_ff1==1)
                cnt_1 <= cnt_1 + 1'b1;
        end
        else if(end_cnt0)begin
            cnt_0 <= 0;
            cnt_1 <= 0;
        end
 
    end
    else begin
        cnt_0 <= 0;
        cnt_1 <= 0;
    end
end
 
//输出并行数据data_byte
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_byte <= 0;
    end
    else if(end_cnt0 && cnt1>0 && cnt1 <9) begin
        if(cnt_0 >= cnt_1)
            data_byte[cnt1-1] = 0;
        else if(cnt_0 < cnt_1)
            data_byte[cnt1-1] = 1;
    end
end
 
//输出接收完成标志信号
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        rx_done <= 0;
    end
    else if(end_cnt1) begin
        rx_done <= 1;
    end
    else begin
        rx_done <= 0;
    end
end
 
endmodule
