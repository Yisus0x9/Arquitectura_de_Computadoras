
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Registros is

    Generic(   
        busDatos: integer:=8;
        busReg:integer:=4
    );
    Port (
           WR : in STD_LOGIC;
           WR_REG : in STD_LOGIC_VECTOR (busReg-1 downto 0);
           RD_DATA1 : out STD_LOGIC_VECTOR (busDatos-1 downto 0);
           RD_DATA2 : out STD_LOGIC_VECTOR (busDatos-1 downto 0);
           WR_DATA : in STD_LOGIC_VECTOR (busDatos-1 downto 0);
           RD_REG1 : in STD_LOGIC_VECTOR (busReg downto 0);
           RD_REG2 : in STD_LOGIC_VECTOR (busReg downto 0));
end Registros;

architecture archReg of Registros is

type memoria is array (busReg-1 downto 0) of std_logic_vector(busDatos-1 downto 0);

signal mem_reg: memoria;
begin
     process(WR) begin
        if(WR ='1') then
                mem_reg (conv_integer (WR_REG))<= WR_DATA;
        end if;
     end process;
     
    RD_DATA1 <=mem_reg (conv_integer(RD_REG1));
    RD_DATA2<=mem_reg (conv_integer(RD_REG2));

end archReg;
