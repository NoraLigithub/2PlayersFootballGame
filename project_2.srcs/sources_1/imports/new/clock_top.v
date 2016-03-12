`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/11/06 15:07:50
// Design Name: 
// Module Name: clock_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_top(
    input [3:0]sorceb,[3:0]sorceg,
    input wire clr,
    input wire init,
    input wire clk,
    output wire [6:0] a_to_g,
    output wire [7:0] an,
    output wire dp,
    output wire [31:0] p
    );
    wire en_1s;
    wire [4:0] h;
    wire [5:0] m;
    wire [5:0] s;
    modcnt u0(.clk(clk),
              .clr(init), 
              .en_1s(en_1s));
              
    count_time u1(.clk(en_1s),
                  .clr(clr),
                  .h(h),
                  .m(m),
                  .s(s));
    assign p[31:28] =0;
    assign p[27:24] = sorceb;
    assign p[23:20] = 0;
    assign p[19:16] = sorceg;
    assign p[15:12] = m / 10;
    assign p[11:8] = m % 10;
    assign p[7:4] = s / 10;
    assign p[3:0] = s % 10;
    
    x7seg u2(.x(p),
            .clk(clk),
            .clr(init),
            .a_to_g(a_to_g),
            .an(an),
            .dp(dp));
            
            
endmodule
