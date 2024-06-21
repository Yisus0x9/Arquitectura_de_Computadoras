library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity memoria is
    generic (
        bits_bus_datos : integer := 14;  -- Ancho del bus de datos
        bits_bus_dif : integer := 8   -- Ancho del bus de dirección
    );
    Port (
        Bus_Dir : in STD_LOGIC_VECTOR (bits_bus_dif downto 0);  -- Bus de dirección
        Bus_Datos : out STD_LOGIC_VECTOR (bits_bus_datos downto 0)  -- Bus de datos
    );
end memoria;

architecture smemoria of memoria is
    --CONSTANTES DE INSTRUCCIONES

    --Identificadores para los formatos R
constant tipo_r : std_logic_Vector(4 downto 0) := "00000";  --OPCODE TIPO R, siempre es 0
        --Funciones tipo R
constant fun_add :  std_logic_vector (3 downto 0) := "0000";
constant fun_sub :  std_logic_vector (3 downto 0) := "0001";
constant fun_and :  std_logic_vector (3 downto 0) := "0010";
constant fun_or :   std_logic_vector (3 downto 0) := "0011";
constant fun_xor :  std_logic_vector (3 downto 0) := "0100";
constant fun_nand : std_logic_vector (3 downto 0) := "0101";
constant fun_nor :  std_logic_vector (3 downto 0) := "0110";
constant fun_xnor : std_logic_vector (3 downto 0) := "0111";
constant fun_cp :   std_logic_vector (3 downto 0) := "1000";

        --Identificadores para los formatos I
constant li :    std_logic_vector (4 downto 0) := "00001";
constant lwi :   std_logic_vector (4 downto 0) := "00010";
constant swi :   std_logic_vector (4 downto 0) := "00011";
constant addi :  std_logic_vector (4 downto 0) := "00100";
constant subi :  std_logic_vector (4 downto 0) := "00101";
constant b :   std_logic_vector (4 downto 0) := "00110";

         --Identificadores para los formatos J
constant cpi :  std_logic_vector    (4 downto 0) := "00111";
constant beq :   std_logic_vector (4 downto 0) := "01000";
constant bneq :  std_logic_vector (4 downto 0) := "01001";
constant blt : std_logic_vector   (4 downto 0) := "01010";
constant blet :  std_logic_vector (4 downto 0) := "01011";
constant bgt : std_logic_vector   (4 downto 0) := "01100";
constant bget :  std_logic_vector (4 downto 0) := "01101";

        --Identificadores para los formatos R
constant r0 :   std_logic_vector (1 downto 0) := "00";
constant r1 :   std_logic_vector (1 downto 0) := "01";
constant r2 :   std_logic_vector (1 downto 0) := "10";
constant r3 :   std_logic_vector (1 downto 0) := "11";


constant su :   std_logic_vector (1 downto 0) := "00";	--S/U: Sin usar

 type smemoria is array (0 to 32767) of std_logic_vector (14 downto 0);

constant memoria : smemoria := (

    li&r0&x"01",   --LI R0, #1 (0)
    li&r1&x"07",    --LI R1, #7 (1)
    tipo_r&r1&r1&r0&fun_add,    --CICLO: ADD R1, R1, R0 (2)
    swi&r1&x"05",    --SWI R1, 5 (3)
    b&su&x"02",    --B CICLO (4)

    others=>(others=> '0')
);
begin
    Bus_Datos <= memoria (conv_integer(Bus_Dir));
end smemoria; 
