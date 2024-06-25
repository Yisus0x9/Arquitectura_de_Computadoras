library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity programCounter is
    Generic (n: integer := 8);
    Port(
        clr : in STD_LOGIC;
        FOSC : in STD_LOGIC;
        WPC : in STD_LOGIC;
        D: in STD_LOGIC_VECTOR((N-1) downto 0);
        Q: inout STD_LOGIC_VECTOR(N-1 downto 0)
    );
end programCounter;

architecture PC of programCounter is
SIGNAL clk, OSC_CLK : std_logic;
SIGNAL cont : INTEGER RANGE 0 TO  199999999 :=0;
begin
   process(FOSC, clr)
    begin
        if(clr = '1') then
            Q <= (OTHERS => '0');
        elsif(rising_edge(FOSC)) then
            cont <= cont + 1;
            IF( cont = 199999999  )THEN
               clk <= NOT clk;
               cont<=0;
               if(WPC = '1') then
                   Q <= D;
               else
                   Q <= Q + 1;
               end if;
            end if;
        end if;
    end process;
end PC;
