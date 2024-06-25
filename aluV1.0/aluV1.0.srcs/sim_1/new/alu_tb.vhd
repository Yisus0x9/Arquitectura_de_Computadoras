-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity alu_tb is
end;

architecture bench of alu_tb is

  component alu
      Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
             B : in STD_LOGIC_VECTOR (7 downto 0);
             AInv : in STD_LOGIC;
             BInv : in STD_LOGIC;
             Co : in STD_LOGIC;
             aluOP : in STD_LOGIC_VECTOR (3 downto 0);
             flags : out STD_LOGIC_VECTOR (3 downto 0);
             Res : out std_logic_vector(7 downto 0));
  end component;

  signal A: STD_LOGIC_VECTOR (7 downto 0);
  signal B: STD_LOGIC_VECTOR (7 downto 0);
  signal AInv: STD_LOGIC;
  signal BInv: STD_LOGIC;
  signal Co: STD_LOGIC;
  signal aluOP: STD_LOGIC_VECTOR (3 downto 0);
  signal flags: STD_LOGIC_VECTOR (3 downto 0);
  signal Res: std_logic_vector(7 downto 0);

begin

  uut: alu port map ( A     => A,
                      B     => B,
                      AInv  => AInv,
                      BInv  => BInv,
                      Co    => Co,
                      aluOP => aluOP,
                      flags => flags,
                      Res   => Res );

  stimulus: process
  begin
  
      
         A <= "10101010"; 
        B <= "11110001";
        Co <= '0';
        BInv <= '0';
        AInv <= '0';
        aluOp<="1001";
        wait for 10ns;
        -- 9-7
        A <= "01001001";
        B <= "00000111";
        Co <= '1';
        BInv <= '1';
        AInv <= '0';
        aluOp<="1001";
        wait for 10ns;
        
    wait;
    end process;

end;
