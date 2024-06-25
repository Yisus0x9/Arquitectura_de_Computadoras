
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           AInv : in STD_LOGIC;
           BInv : in STD_LOGIC;
           Co : in STD_LOGIC;
           aluOP : in STD_LOGIC_VECTOR (3 downto 0);
           flags : out STD_LOGIC_VECTOR (3 downto 0);
           Res : out std_logic_vector(7 downto 0));
end entity;

architecture alu8B of alu is
   signal auxZero: std_logic;
begin

    process(aluOP)
         variable resTemp : std_logic_vector(7 downto 0);
         variable EB,EA: std_logic_vector(0 to 7);
         variable P,G:std_logic_vector(0 to 7);
         variable Cc:std_logic_vector(0 to 8);
    begin
            case (aluOP) is
                         
                --AND
                  when "0001"=>
                        resTemp:=A and B;
                --OR
                  when "0010"=>
                        resTemp:=A or B;
                --XOR
                  when "0011"=>
                        resTemp:=A xor B;
                --NAND
                  when "0100"=>
                        resTemp:=A nand B;
                --NOR
                  when "0101"=>
                        resTemp:=A nor B;
                --XNOR
                  when "0110"=>
                        resTemp:=A xnor B; 
		--Not A
		  when "0111"=>
			resTemp:= not A;   
		--Not B
		  when "1000"=>
			resTemp:= not B;  
         --Sumador restador
                  when "1001"=>
                   Cc(0):=Co;
                   for i in 0 to 7 loop
                     EA(i):=A(i) xor AInv;
                     EB(i):=B(i) xor BInv;
                     P(i):=EA(i) xor EB(i);
                     G(i):=EA(i) and EB(i);
                     Cc(i+1):=(Cc(i) and P(i)) or G(i);
                     resTemp(i):=EA(i) xor EB(i) xor Cc(i);    
                 end loop;    
                 when others=>        
            end case;
            
        --Actualizando Banderas
       
        --Z
        
        flags(3)<= NOT(resTemp(7) OR resTemp(6) OR resTemp(5) OR resTemp(4) OR resTemp(3) OR resTemp(2) OR resTemp(1) OR resTemp(0));
        
        --C
        flags(2) <= Cc(8);
        
        --OV
        flags(1) <=Cc(7) xor Cc(8);
        
        --N
        flags(0) <=resTemp(7);
        Res<=resTemp;
    end process;     
end alu8B;
