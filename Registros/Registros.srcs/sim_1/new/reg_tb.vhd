
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Registros_tb is
end;

architecture bench of Registros_tb is

  component Registros
      Port ( clr : in STD_LOGIC;
             WR : in STD_LOGIC;
             WR_REG : in STD_LOGIC_VECTOR (1 downto 0);
             RD_DATA1 : out STD_LOGIC_VECTOR (7 downto 0);
             RD_DATA2 : out STD_LOGIC_VECTOR (7 downto 0);
             WR_DATA : in STD_LOGIC_VECTOR (7 downto 0);
             RD_REG1 : in STD_LOGIC_VECTOR (1 downto 0);
             RD_REG2 : in STD_LOGIC_VECTOR (1 downto 0));
  end component;

  signal clr: STD_LOGIC;
  signal WR: STD_LOGIC;
  signal WR_REG: STD_LOGIC_VECTOR (1 downto 0);
  signal RD_DATA1: STD_LOGIC_VECTOR (7 downto 0);
  signal RD_DATA2: STD_LOGIC_VECTOR (7 downto 0);
  signal WR_DATA: STD_LOGIC_VECTOR (7 downto 0);
  signal RD_REG1: STD_LOGIC_VECTOR (1 downto 0);
  signal RD_REG2: STD_LOGIC_VECTOR (1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Registros port map ( clr      => clr,
                            WR       => WR,
                            WR_REG   => WR_REG,
                            RD_DATA1 => RD_DATA1,
                            RD_DATA2 => RD_DATA2,
                            WR_DATA  => WR_DATA,
                            RD_REG1  => RD_REG1,
                            RD_REG2  => RD_REG2 );

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
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  