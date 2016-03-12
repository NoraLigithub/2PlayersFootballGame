`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/11/06 14:48:25
// Design Name: 
// Module Name: modcnt
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


module modcnt(
    input wire clr,
    input wire clk,
    output wire en_1s
    );
    reg [31:0] q;
    always @ (posedge clk or posedge clr)
    begin
    if (clr == 1)
        q <= 0;
    else if (q == 99999999)
        q <= 0;
    else q <= q + 1;
    end
    assign en_1s = (q == 99999999) ? 1'b1 : 1'b0;
endmodule
