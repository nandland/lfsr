-- Description: Simple Testbench for LFSR. Set NUM_BITS to different
-- values to verify operation of LFSR

library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity LFSR_TB is
end entity LFSR_TB;

architecture behave of LFSR_TB is

  constant NUM_BITS : integer := 3;
  constant CLK_PERIOD : time := 40 ns;  -- 25 MHz
  
  signal r_Clk : std_logic := '0';
  signal w_LFSR_Data : std_logic_vector(NUM_BITS-1 downto 0);
  signal w_LFSR_Done : std_logic;
  signal r_Seed_DV   : std_logic;
  
begin

  r_Clk <= not r_Clk after CLK_PERIOD/2;
  
  LFSR_1 : entity work.LFSR
    generic map (
      NUM_BITS => NUM_BITS)
    port map (
      i_Clk       => r_Clk,
      i_Enable    => '1',
      i_Seed_DV   => r_Seed_DV,
      i_Seed_Data => (others => '0'),
      o_LFSR_Data => w_LFSR_Data,
      o_LFSR_Done => w_LFSR_Done);


  process is 
  begin
    wait until rising_edge(r_Clk);
    r_Seed_DV <= '1';
    wait until rising_edge(r_Clk);
    r_Seed_DV <= '0';
    wait for CLK_PERIOD * 10;
  
    finish; -- need VHDL-2008
  end process;
  
end architecture behave;
