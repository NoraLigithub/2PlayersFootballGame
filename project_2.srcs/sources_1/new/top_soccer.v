`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/12/28 20:33:09
// Design Name: 
// Module Name: top_soccer
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


module top_soccer(
    input           clk,     
    input clrn, //keyboard enable 
    input ps2_clk, 
    input ps2_data,
    input           rst,rst1, //flyinglogo enable
    input           init_sorce, //sorce enable
    input           left1,right1,up1,down1,
    output          hsync,
    output          vsync,
    output [3:0]    vga_r,
    output [3:0]    vga_b,
    output [3:0]    vga_g,
    output          [3:0]sorceb,[3:0]sorceg,
    input clr, //clock enable
    input init,//1s enable
    output reg time_flag,
    output   sorce_clk,
    output [6:0] a_to_g,
    output [7:0] an,
    output dp
    );
    
   wire [31:0] p;
   wire rst11;
   wire clr1;
   
   clock_top c1(.clr(clr1),.init(init), .clk(clk), .a_to_g(a_to_g), .an(an), .dp(dp), .p(p),.sorceb(sorceb),.sorceg(sorceg));
   always @(posedge p[8] or negedge clr)
   if(clr==1)
   time_flag <= 0;
   else
   time_flag <= 1;
   assign rst11 =  rst1 | time_flag;
   assign clr1 = clr | time_flag;
   game  g1 (.sorce_clk(sorce_clk),.init_sorce(init_sorce),.sorceb(sorceb),.sorceg(sorceg),.clk(clk),.clrn(clrn),.ps2_clk(ps2_clk),.ps2_data(ps2_data),.rst(rst), .hsync(hsync), .vsync(vsync), .vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b),.rst1(rst11),.left1(left1),.right1(right1),.up1(up1),.down1(down1));

   
endmodule
