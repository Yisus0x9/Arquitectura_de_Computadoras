-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity pc_tb is
end;

architecture bench of pc_tb is

  component pc
      Port ( FOSC : in STD_LOGIC;
             clr : in STD_LOGIC;
             led : out STD_LOGIC);
  end component;

  signal FOSC: STD_LOGIC;
  signal clr: STD_LOGIC;
  signal led: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: pc port map ( FOSC => FOSC,
                     clr  => clr,
                     led  => led );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      FOSC <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  