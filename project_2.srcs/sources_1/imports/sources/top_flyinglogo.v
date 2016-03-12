`timescale 1 ns / 1 ns


module top_flyinglogo(sorce_clk,clk, rst, hsync, vsync, vga_r, vga_g, vga_b,rst1,left,right,up,down,left1,right1,up1,down1,init_sorce,sorceb,sorceg);
   input           clk;
   input           rst;
   input           rst1;
   input           init_sorce;
   input           left;
   input           right;
   input           up;
   input           down;
   input           left1;
   input           right1;
   input           up1;
   input           down1;
   output          hsync;
   output          vsync;
   output [3:0]    vga_r;
   output [3:0]    vga_g;
   output [3:0]    vga_b;
   output          reg sorce_clk;
   output          reg [3:0]sorceb;
   output          reg [3:0]sorceg;
   
 //  reg           sorce_clk;
   wire            pclk;
   wire            valid;
   wire [9:0]      h_cnt;
   wire [9:0]      v_cnt;
   reg [11:0]       vga_data;
   
   reg [13:0]      rom_addr;
   wire [11:0]      douta;
   
   wire            logo_area;
    wire            logo1_area;
    wire            logo2_area;
    wire            logo3_area;
    wire            logo4_area;
    wire            logo11_area;
    wire            logo22_area;
    wire            logo33_area;
    wire            logo44_area;
    reg [9:0]       logo_x ;
    reg [9:0]       logo_y ;
    reg [9:0]       logo1_x = 10'd1;
    reg [9:0]       logo1_y = 10'd150;
    reg [9:0]       logo2_x = 10'd1;
    reg [9:0]       logo2_y = 10'd150;
    reg [9:0]       logo3_x = 10'd1;
    reg [9:0]       logo3_y = 10'd300;
    reg [9:0]       logo4_x = 10'd250;
    reg [9:0]       logo4_y = 10'd350;  
    reg [9:0]       logo11_x = 10'd640;
    reg [9:0]       logo11_y = 10'd150;
    reg [9:0]       logo22_x = 10'd640;
    reg [9:0]       logo22_y = 10'd150;
    reg [9:0]       logo33_x = 10'd640;
    reg [9:0]       logo33_y = 10'd300;
    reg [9:0]       logo44_x = 10'd450;
    reg [9:0]       logo44_y = 10'd350;   
    parameter [9:0] logo_length = 10'd20;
    parameter [9:0] logo_hight  = 10'd20;
    parameter [9:0] logo1_length = 10'd10;
    parameter [9:0] logo1_hight  = 10'd150;
    parameter [9:0] logo2_length = 10'd75;
    parameter [9:0] logo2_hight  = 10'd10;
    parameter [9:0] logo3_length = 10'd75;
    parameter [9:0] logo3_hight  = 10'd10;
    parameter [9:0] logo4_length = 10'd10;
    parameter [9:0] logo4_hight  = 10'd75;
    parameter [9:0] logo11_length = 10'd10;
    parameter [9:0] logo11_hight  = 10'd150;
    parameter [9:0] logo22_length = 10'd75;
    parameter [9:0] logo22_hight  = 10'd10;
    parameter [9:0] logo33_length = 10'd75;
    parameter [9:0] logo33_hight  = 10'd10;
    parameter [9:0] logo44_length = 10'd10;
    parameter [9:0] logo44_hight  = 10'd75;
            
    reg [7:0]       speed_cnt;
    wire            speed_ctrl;
    
    reg [3:0]       flag_edge;
    
       dcm_25m u0
          (
          // Clock in ports
           .clk_in1(clk),      // input clk_in1
           // Clock out ports
           .clk_out1(pclk),     // output clk_out1
           // Status and control signals
           .reset(rst));   
           
     vga_640x480 u2 (
         .pclk(pclk), 
         .reset(rst), 
         .hsync(hsync), 
         .vsync(vsync), 
         .valid(valid), 
         .h_cnt(h_cnt), 
         .v_cnt(v_cnt)
         );
  
    assign logo_area = ((v_cnt >= logo_y) & (v_cnt <= logo_y + logo_hight - 1) & (h_cnt >= logo_x) & (h_cnt <= logo_x + logo_length - 1)) ? 1'b1 : 
                       1'b0;
    assign logo1_area = ((v_cnt >= logo1_y) & (v_cnt <= logo1_y + logo1_hight - 1) & (h_cnt >= logo1_x) & (h_cnt <= logo1_x + logo1_length - 1)) ? 1'b1 : 
                       1'b0;
    assign logo2_area = ((v_cnt >= logo2_y) & (v_cnt <= logo2_y + logo2_hight - 1) & (h_cnt >= logo2_x) & (h_cnt <= logo2_x + logo2_length - 1)) ? 1'b1 : 
                       1'b0;
    assign logo3_area = ((v_cnt >= logo3_y) & (v_cnt <= logo3_y + logo3_hight - 1) & (h_cnt >= logo3_x) & (h_cnt <= logo3_x + logo3_length - 1)) ? 1'b1 : 
                       1'b0;
    assign logo4_area = ((v_cnt >= logo4_y) & (v_cnt <= logo4_y + logo4_hight - 1) & (h_cnt >= logo4_x) & (h_cnt <= logo4_x + logo4_length - 1)) ? 1'b1 : 
                       1'b0;
    assign logo11_area = ((v_cnt >= logo11_y) & (v_cnt <= logo11_y + logo11_hight - 1) & (h_cnt <= logo11_x) & (h_cnt >= logo11_x - logo11_length + 1)) ? 1'b1 : 
                                          1'b0;
    assign logo22_area = ((v_cnt >= logo22_y) & (v_cnt <= logo22_y + logo22_hight - 1) & (h_cnt <= logo22_x) & (h_cnt >= logo22_x - logo22_length + 1)) ? 1'b1 : 
                                                                                1'b0;
     assign logo33_area = ((v_cnt >= logo33_y) & (v_cnt <= logo33_y + logo33_hight - 1) & (h_cnt <= logo33_x) & (h_cnt >= logo33_x - logo33_length + 1)) ? 1'b1 : 
                                                                                                                      1'b0;
     assign logo44_area = ((v_cnt >= logo44_y) & (v_cnt <= logo44_y + logo44_hight - 1) & (h_cnt >= logo44_x) & (h_cnt <= logo44_x + logo44_length - 1)) ? 1'b1 : 
                                                                                                                                             1'b0;                                                                                                                                                                                            
    always @(posedge pclk)
    begin: logo_display
       if (rst == 1'b1)
          vga_data <= 12'b00000000;
       else 
       begin
          if (valid == 1'b1)
          begin
             if (logo_area == 1'b1)
             begin
              if((logo_x >= logo1_x + logo1_length)  && (logo_x <= logo2_x + logo2_length )  && (logo_y >= logo2_y + logo2_hight) &&(logo_y <= logo3_y - logo_hight))
                begin   vga_data <= 12'b111100000000; sorce_clk <= 1;   end 
              else if((logo_x <= logo11_x - logo11_length - logo_length)  && (logo_x >= logo22_x - logo22_length -logo_length  )  && (logo_y >= logo22_y + logo22_hight) &&(logo_y <= logo33_y - logo_hight))
                 begin      vga_data <= 12'b111100000000; sorce_clk <= 1;   end
               else   begin vga_data <= 12'b111111111111; sorce_clk <= 0; end
             end
             else if(logo1_area == 1 || logo2_area == 1 || logo3_area == 1)
                 vga_data <= 12'b000000001111; 
             else if(logo4_area == 1)
                 vga_data <= 12'b000000001111;
             else if(logo11_area == 1 || logo22_area == 1 || logo33_area == 1)
                     vga_data <= 12'b000011110000; 
             else if(logo44_area == 1)
                         vga_data <= 12'b000011110000;
             else begin
                rom_addr <= rom_addr;
                vga_data <= 12'b000000000000;
             end
          end
          else
          begin
             vga_data <= 12'b111111111111;
             if (v_cnt == 0)
                rom_addr <= 14'b00000000000000;
          end
       end
    end
    
    assign vga_r = vga_data[11:8];
    assign vga_g = vga_data[7:4];
    assign vga_b = vga_data[3:0];
    
   
   always @(posedge pclk)
   begin: speed_control
      if (rst == 1'b1)
         speed_cnt <= 8'h00;
      else 
      begin
         if ((v_cnt[5] == 1'b1) & (h_cnt == 1))
            speed_cnt <= speed_cnt + 8'h01;
      end
   end
   
   
   debounce u3(.sig_in(speed_cnt[5]), .clk(pclk), .sig_out(speed_ctrl));
   
   
   always @(posedge pclk)
   begin: logo_move
      
      reg [1:0]       flag_add_sub;
         
      if (rst1 == 1'b1)
      begin
         flag_add_sub = 2'b01;
         
         logo_x <= 10'd315;
         logo_y <= 10'd230;
         logo4_x = 10'd150;
         logo4_y = 10'd187;
         logo44_x = 10'd480;
         logo44_y = 10'd187;
      end
      else 
      begin
         
         if (speed_ctrl == 1'b1)
         begin
            if(left == 1) logo4_x <= (640+logo4_x - 1)%640;
            if(right == 1) logo4_x <= (logo4_x + 1)%640;
            if(down == 1) logo4_y <= (logo4_y +1)%480;
            if(up == 1) logo4_y <= (480+logo4_y - 1)%480;  
             if(left1 == 1) logo44_x <= (640+logo44_x - 1)%640;
            if(right1 == 1) logo44_x <= (logo44_x + 1)%640;
            if(down1 == 1) logo44_y <= (logo44_y +1)%480;
            if(up1 == 1) logo44_y <= (480+logo44_y - 1)%480;
            if (logo_x == 1)
             begin
                if (logo_y == 1)
                begin
                   flag_edge <= 4'h1;
                   flag_add_sub = 2'b00;
                end
                else if (logo_y == 480 - logo_hight)
                begin
                   flag_edge <= 4'h2;
                   flag_add_sub = 2'b01;
                end
                else
                begin
                   flag_edge <= 4'h3;
                   flag_add_sub[1] = (~flag_add_sub[1]);
                end
             end
             else if (logo_x == 640 - logo_length)
                        begin
                           if (logo_y == 1)
                           begin
                              flag_edge <= 4'h4;
                              flag_add_sub = 2'b10;
                           end
                           else if (logo_y == 480 - logo_hight)
                           begin
                              flag_edge <= 4'h5;
                              flag_add_sub = 2'b11;
                           end
                           else
                           begin
                              flag_edge <= 4'h6;
                              flag_add_sub[1] = (~flag_add_sub[1]);
                           end
                        end
                        
              else if (logo_y == 1 )
                        begin
                           flag_edge <= 4'h7;
                           flag_add_sub[0] = (~flag_add_sub[0]);
                        end
             else if (logo_y == 480 - logo_hight)
                        begin
                           flag_edge <= 4'h8;
                           flag_add_sub[0] = (~flag_add_sub[0]);
                        end
                                               //kuang
            else if (( logo_y == logo3_y + logo3_hight || logo_y == logo2_y - logo_hight ) && logo_x < logo2_x + logo2_length && logo_x >=logo2_x)
                                                         begin
                                                            if (logo_x == logo2_x)
                                                            begin
                                                            if(logo_y==logo2_y-logo_hight)
                                                            begin
                                                               flag_edge <= 4'h4;
                                                               flag_add_sub = 2'b01;
                                                            end
                                                            else
                                                            begin
                                                               flag_edge <= 4'h4;
                                                               flag_add_sub = 2'b00;
                                                            end
                                                            end
                                                            else
                                                            begin
                                                               flag_edge <= 4'h6;
                                                               flag_add_sub[0] = (~flag_add_sub[0]);
                                                            end
                                                         end
                                                         
                                                         else if ((logo_y == logo2_y + logo2_hight || logo_y == logo3_y - logo_hight ) && logo_x < logo2_x + logo2_length && logo_x >=logo1_x + logo1_length  )
                                                                     begin
                                                                        if (logo_x == logo1_length + logo1_x)
                                                                        begin
                                                                        if(logo_y==logo2_y+logo2_hight)
                                                                        begin
                                                                           flag_edge <= 4'h4;
                                                                           flag_add_sub = 2'b00;
                                                                        end
                                                                        else
                                                                        begin
                                                                           flag_edge <= 4'h4;
                                                                           flag_add_sub = 2'b01;
                                                                        end
                                                                        end
                                                                        else
                                                                        begin
                                                                           flag_edge <= 4'h6;
                                                                           flag_add_sub[0] = (~flag_add_sub[0]);
                                                                        end
                                                                     end
                                                                     
                                                                     //kuang top
                                                                     else if(logo_x == logo1_x + logo1_length && logo_y >= logo2_y + logo2_hight && logo_y <= logo3_y - logo_hight)
                                                                        flag_add_sub[1] = ~flag_add_sub[1];
                                                                       //kuang dibian 
                                                                     else if(logo_x==logo2_length+logo2_x&&((logo_y>=logo2_y-logo_hight&&logo_y<=logo2_y+logo2_hight)||(logo_y>=logo3_y-logo_hight&&logo_y<=logo3_y+logo3_hight)))  
                                                                     begin
                                                                     flag_add_sub[1]=(~flag_add_sub[1]);
                                                                     end
                //board top & botom
                  else if(logo_x >= logo4_x  - logo_length && logo_x <= logo4_x + logo4_length && (logo_y == logo4_y - logo_hight||logo_y==logo4_y-logo_hight - 1))
                    begin
                        flag_edge <= 4'h3;
                        flag_add_sub[0] = 1;
                     end
                   else if(logo_x >= logo4_x  - logo_length  && logo_x <= logo4_x + logo4_length && (logo_y == logo4_y + logo4_hight||logo_y==logo4_y+logo4_hight +1))
                     begin
                               flag_edge <= 4'h3;
                               flag_add_sub[0] = 0;
                       end
                  else if(logo_y >= logo4_y  - logo_hight && logo_y <= logo4_y + logo4_hight && (logo_x == logo4_x - logo_length||logo_x==logo4_x-logo_length - 1))
                         begin
                             flag_edge <= 4'h3;
                             flag_add_sub[1] = 1;
                          end
                  else if(logo_y >= logo4_y  - logo_hight && logo_y <= logo4_y + logo4_hight && (logo_x == logo4_x + logo4_length||logo_x==logo4_x+logo4_length + 1))
                                  begin
                                      flag_edge <= 4'h3;
                                      flag_add_sub[1] = 0;
                                   end
                                               //kuang
                 else if (( logo_y == logo33_y + logo33_hight || logo_y == logo22_y - logo_hight ) && logo_x >  logo22_x - logo22_length-logo_length && logo_x <=logo22_x - logo_length)
                                             begin
                                                if (logo_x == logo22_x - logo_length)
                                                begin
                                                if(logo_y==logo22_y-logo_hight)
                                                begin
                                                   flag_edge <= 4'h4;
                                                   flag_add_sub = 2'b11;
                                                end
                                                else
                                                begin
                                                   flag_edge <= 4'h4;
                                                   flag_add_sub = 2'b10;
                                                end
                                                end
                                                else
                                                begin
                                                   flag_edge <= 4'h6;
                                                   flag_add_sub[0] = (~flag_add_sub[0]);
                                                end
                                             end
                                             
                                             else if ((logo_y == logo22_y + logo22_hight || logo_y == logo33_y - logo_hight ) && logo_x > logo22_x - logo22_length - logo_length && logo_x <=logo11_x - logo11_length - logo_length  )
                                                         begin
                                                            if (logo_x ==  logo11_x - logo11_length - logo_length)
                                                            begin
                                                            if(logo_y==logo22_y+logo22_hight)
                                                            begin
                                                               flag_edge <= 4'h4;
                                                               flag_add_sub = 2'b10;
                                                            end
                                                            else
                                                            begin
                                                               flag_edge <= 4'h4;
                                                               flag_add_sub = 2'b11;
                                                            end
                                                            end
                                                            else
                                                            begin
                                                               flag_edge <= 4'h6;
                                                               flag_add_sub[0] = (~flag_add_sub[0]);
                                                            end
                                                         end
                                                         
                                                         //kuang top
                                                         else if(logo_x == logo11_x - logo11_length - logo_length && logo_y >= logo22_y + logo22_hight && logo_y <= logo33_y - logo_hight)
                                                            flag_add_sub[1] = ~flag_add_sub[1];
                                                           //kuang dibian 
                                                         else if(logo_x==logo22_x-logo22_length-logo_length&&((logo_y>=logo22_y-logo_hight&&logo_y<=logo22_y+logo22_hight)||(logo_y>=logo33_y-logo_hight&&logo_y<=logo33_y+logo33_hight)))  
                                                         begin
                                                         flag_add_sub[1]=(~flag_add_sub[1]);
                                                         end
    //board top & botom
      else if(logo_x >= logo44_x  - logo_length && logo_x <= logo44_x + logo4_length && (logo_y == logo44_y - logo_hight||logo_y==logo44_y-logo_hight - 1))
        begin
            flag_edge <= 4'h3;
            flag_add_sub[0] = 1;
         end
       else if(logo_x >= logo44_x  - logo_length  && logo_x <= logo44_x + logo44_length && (logo_y == logo44_y + logo44_hight||logo_y==logo44_y+logo44_hight +1))
         begin
                   flag_edge <= 4'h3;
                   flag_add_sub[0] = 0;
           end
      else if(logo_y >= logo44_y  - logo_hight && logo_y <= logo44_y + logo44_hight && (logo_x == logo44_x - logo_length||logo_x==logo44_x-logo_length - 1))
             begin
                 flag_edge <= 4'h3;
                 flag_add_sub[1] = 1;
              end
      else if(logo_y >= logo44_y  - logo_hight && logo_y <= logo44_y + logo44_hight && (logo_x == logo44_x + logo44_length||logo_x==logo44_x+logo44_length + 1))
                      begin
                          flag_edge <= 4'h3;
                          flag_add_sub[1] = 0;
                       end
                              
           else 
           begin
                 flag_edge <= 4'h9;
                flag_add_sub = flag_add_sub;   
          end         
            
            case (flag_add_sub)
               2'b00 :
                  begin
                     logo_x <= logo_x + 10'b0000000001;
                     logo_y <= logo_y + 10'b0000000001;
                  end
               2'b01 :
                  begin
                     logo_x <= logo_x + 10'b0000000001;
                     logo_y <= logo_y - 10'b0000000001;
                  end
               2'b10 :
                  begin
                     logo_x <= logo_x - 10'b0000000001;
                     logo_y <= logo_y + 10'b0000000001;
                  end
               2'b11 :
                  begin
                     logo_x <= logo_x - 10'b0000000001;
                     logo_y <= logo_y - 10'b0000000001;
                  end
               default :
                  begin
                     logo_x <= logo_x + 10'b0000000001;
                     logo_y <= logo_y + 10'b0000000001;
                  end
            endcase
         end
         
      end
   end
   
   always @(posedge sorce_clk or negedge init_sorce)
   begin
   if(init_sorce == 1)
   begin
   sorceg <= 0;
   sorceb <= 0;
   end
   else if((logo_x<=logo2_x+logo2_length)&&(logo_y<=logo3_y-logo_hight)&&(logo_y>=logo2_y+logo2_hight))
   sorceg <= sorceg + 1;
   else if((logo_x>=logo22_x-logo22_length-logo_length)&&(logo_y<=logo33_y-logo_hight)&&(logo_y>=logo22_y+logo22_hight))
   sorceb <= sorceb + 1;
   end
 endmodule