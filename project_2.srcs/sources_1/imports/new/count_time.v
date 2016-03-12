`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/11/06 15:01:49
// Design Name: 
// Module Name: count_time
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


module count_time(
    input wire clk,
    input wire clr,
    output reg [4:0] h,
    output reg [5:0] m,
    output reg [5:0] s
    );
    reg clr1;
    always @ (posedge clk or posedge clr)
    begin
        if (clr == 1  )
         begin
            h <= 0;
            m <= 0;
            s <= 0;
         end
        else 
             begin
                if (s == 6'b111011)
                begin
                    s <= 0;
                    if (m == 6'b111011)
                    begin 
                        m <= 0;
                        if (h == 5'b10111)
                            h <= 0;
                        else h <= h + 1'b1;
                    end
                    else begin  m <= m + 1'b1;  end
                 end
                 else s <= s + 1'b1;
              end
   end  
endmodule
