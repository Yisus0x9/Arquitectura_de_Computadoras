

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity ram is
    Generic(
        busDatos:integer:= 8;
        busDir:integer:=8
    );
    
    Port ( FOSC : in STD_LOGIC;
           WE : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (busDir-1 downto 0);
           di : in STD_LOGIC_VECTOR (busDatos-1 downto 0);
           do : out STD_LOGIC_VECTOR (busDatos-1 downto 0));
end ram;

architecture Behavioral of ram is

type ram_type is array((2**busDir)-1 downto 0) of std_logic_vector(busDatos-1 downto 0);
signal RAM : ram_type;
signal clk, OSC_CLK: std_logic;
signal cont : integer range 0 to 199999:=0;
begin

        process(FOSC)
        begin
            if(rising_edge(FOSC))then
                cont<=cont+1;
                if(cont =  199999) then
                    clk<=not clk;
                    cont<=0;
                    if(WE='1')then
                        RAM(conv_integer(addr))<=di;
                    end if;
                end if;
                
             end if;
        end process;
        
        do<=RAM(conv_integer(addr));
        
end Behavioral;
