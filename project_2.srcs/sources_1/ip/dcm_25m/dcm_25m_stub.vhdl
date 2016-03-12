-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.2 (win64) Build 932637 Wed Jun 11 13:33:10 MDT 2014
-- Date        : Wed Dec 24 16:17:20 2014
-- Host        : stu49c825 running 64-bit major release  (build 7600)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/linan_game/project_2/project_2.srcs/sources_1/ip/dcm_25m/dcm_25m_stub.vhdl
-- Design      : dcm_25m
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dcm_25m is
  Port ( 
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );

end dcm_25m;

architecture stub of dcm_25m is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in1,clk_out1,reset,locked";
begin
end;
