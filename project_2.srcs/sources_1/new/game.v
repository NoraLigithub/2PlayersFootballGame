`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/12/27 22:13:39
// Design Name: 
// Module Name: game
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


module game(sorce_clk,clk,clrn,ps2_clk,ps2_data,rst, hsync, vsync, vga_r, vga_g, vga_b,rst1,left1,right1,up1,down1,init_sorce,sorceb,sorceg);
input clk,clrn,ps2_clk,ps2_data;     
input           rst;
input           rst1;
input           init_sorce;
input           left1,right1,up1,down1;
output          hsync;
output          vsync;
output [3:0]    vga_r;
output [3:0]    vga_g;
output [3:0]    vga_b;
output          [3:0]sorceb;
output          [3:0]sorceg;
output          sorce_clk;
  
 wire [7:0]data;
 wire overflow;
 wire [3:0] count;
 //reg ready;
reg           left;
 reg           right;
 reg           up;
 reg           down;
/*reg          right1;
reg          up1;
reg           down1;
*/
wire ready;
 
 ps2_keyboard p0(.clk(clk),
                 .clrn(clrn),
                 .ps2_clk(ps2_clk),
                 .ps2_data(ps2_data),
                 .data(data),
                 .ready(ready),
                 .overflow(overflow),
                 .count(count));    

  always @(*)
  begin                       
  up <= (data == 8'h1d) ? 1 : 0;
  down <= (data == 8'h1a) ? 1 : 0;
  left <= (data == 8'h1c) ? 1 : 0;
  right <= (data == 8'h23) ? 1 : 0;  
  
  end 
  
top_flyinglogo u0(.sorce_clk(sorce_clk),
                  .clk(clk), 
                  .rst(rst),
                  .hsync(hsync), 
                  .vsync(vsync), 
                  .vga_r(vga_r), 
                  .vga_g(vga_g), 
                  .vga_b(vga_b),
                  .rst1(rst1),
                  .left(left),
                  .right(right),
                  .up(up),
                  .down(down),
                  .left1(left1),
                  .right1(right1),
                  .up1(up1),
                  .down1(down1),
                  .init_sorce(init_sorce),
                  .sorceg(sorceg),
                  .sorceb(sorceb));
endmodule
