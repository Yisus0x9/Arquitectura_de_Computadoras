library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity unidadControl is
    generic (bitsBusDatosMemFun : integer := 4;
             bitsBusDatosMemOp :integer := 5);
    Port ( cod_fun : in STD_LOGIC_VECTOR (bitsBusDatosMemFun-1 downto 0);
           cod_op : in STD_LOGIC_VECTOR (bitsBusDatosMemOp-1 downto 0);
           Z,N,OV,C : in STD_LOGIC;
           CLR, CLK : in STD_LOGIC;
           WPC,SR1,SWD,WR,SOP1,SOP2,WD,SR : out STD_LOGIC;
           ALUOP : out STD_LOGIC_VECTOR (3 downto 0));
end unidadControl;

architecture aUnidadControl of unidadControl is
signal LF, RZ, RN, ROV, RC : std_logic;
signal EQ, NEQ, LT, LET, GT, GET : std_logic;
signal tipoR, BEQ, BNEQ, BLT, BLET, BGT, BGET : std_logic;
signal SDOPC, SM : std_logic;
signal A : std_logic_vector(4 downto 0);
signal M : std_logic_vector(12 downto 0);
type estados is (edo_A);
signal edo_actual,edo_sgte : estados; 
type memROMFun is array (0 to 8) of std_logic_vector(12 downto 0);
type memROMOp is array (0 to 14) of std_logic_vector(12 downto 0);

  -- Definición de microinstrucciones para operaciones de la ALU (tipo R)
    constant memMicroFun : memROMFun := (
        "0011000011101", -- ADD: 
        "0011000111101", -- SUB: 
        "0011000000101", -- AND: 
        "0011000001101", -- OR:  
        "0011000010101", -- XOR: 
        "0011001101101", -- NAND: 
        "0011001100101", -- NOR:  
        "0011001010101", -- XNOR: 
        "0000000111101"  -- CP:  
    );

    -- Definición de microinstrucciones para operaciones de memoria y saltos (tipo I y J)
    constant memMicroOp : memROMOp := (
        "0000000000000", -- Bcond:
        "0001000000000", -- LI: 
        "0011000000000", -- LWI: 
        "0100000000010", -- SWI: 
        "0011010011101", -- ADDI: 
        "0011010111101", -- SUBI: 
        "1000000000000", -- B: 
        "0100110111100", -- CPI: 
        "1000000000000", -- BEQ: 
        "1000000000000", -- BNEQ: 
        "1000000000000", -- BLT: 
        "1000000000000", -- BLET:
        "1000000000000", -- BGT: 
        "1000000000000", -- BGET: 
        "0000000000000"  -- NOP:
    );
begin

    automataP : process (tipoR, BEQ, BNEQ, BLT, BLET, BGT, BGET, EQ, NEQ, LT, LET, GT, GET)
    begin
        SDOPC <= '0';
        SM    <= '0';
        case edo_actual is
            when edo_A =>
                if ( tipoR = '0') then
                    if ( BEQ = '1')then
                        if(EQ = '1') then
                            SM <= '1';
                            SDOPC <= '1';
                            edo_sgte <= edo_A;
                        else
                            SM <= '1';
                            edo_sgte <= edo_A;
                        end if;
                    elsif ( BNEQ = '1') then
                        if(NEQ = '1') then
                            SM <= '1';
                            SDOPC <= '1';
                            edo_sgte <= edo_A;
                        else
                            SM <= '1';
                            edo_sgte <= edo_A;
                        end if;
                    elsif ( BLT = '1') then
                        if(LT = '1') then
                            SM <= '1';
                            SDOPC <= '1';
                            edo_sgte <= edo_A;
                        else
                            SM <= '1';
                            edo_sgte <= edo_A;
                        end if;
                    elsif (BLET ='1') then
                        if(LET = '1') then
                            SM <= '1';
                            SDOPC <= '1';
                            edo_sgte <= edo_A;
                        else
                            SM <= '1';
                            edo_sgte <= edo_A;
                        end if;
                    elsif ( BGT = '1' ) then
                        if(EQ = '1') then
                            SM <= '1';
                            SDOPC <= '1';
                            edo_sgte <= edo_A;
                        else
                            SM <= '1';
                            edo_sgte <= edo_A;
                        end if;
                   elsif ( BGET ='1') then
                        if(EQ = '1') then
                            SM <= '1';
                            SDOPC <= '1';
                            edo_sgte <= edo_A;
                        else
                            SM <= '1';
                            edo_sgte <= edo_A;
                        end if;
                   end if;
               end if;
            
        end case;               
    end process automataP;

    transicionP : process (CLR, CLK)
    begin
        if ( CLR ='1' ) then
            edo_actual <= edo_A;
        elsif ( rising_edge (CLK)) then
            edo_actual <= edo_sgte;
        end if;
    end process transicionP;

    RegStatusP : process (CLK, CLR)
        begin
            if (CLR = '1') Then
                RZ <= '0';
                RN <= '0';
                ROV <= '0';
                RC <= '0';
            elsif( CLK'event and CLK ='1')then
                if (LF ='1')then
                    RZ <= Z;
                    RN <= N;
                    ROV <= OV;
                    RC <= C;
                end if;
            end if;
        end process RegStatusP;

    -- CONDICION
    EQ <= RZ;
    NEQ <= not RZ;
    LT <= not RZ and (RN xor ROV);
    LET <= RZ or (RN xor ROV);
    GT <= not RZ and not(RN xor ROV);
    GET <= RZ or not(RN xor ROV);
    
    --DECODIFICADOR
    tipoR <= '1' when (cod_op ="00000") else '0';
    BEQ <= '1' when (cod_op ="01000") else '0';
    BNEQ <= '1' when (cod_op ="01001") else '0';
    BLT <= '1'when (cod_op ="01010") else '0';
    BLET <= '1' when (cod_op ="01011") else '0';
    BGT <= '1' when (cod_op ="01100") else '0';
    BGET <= '1' when (cod_op ="01101") else '0';
            

     -- Multiplexor para SDOP
    A <= "00000" when ( SDOPC = '0') else cod_op;
    
     -- Multiplexor para seleccionar la memoria de microinstrucciones
    M <= memMicroFun( conv_integer(cod_fun)) when (SM = '0') else memMicroOp (conv_integer (A));
    
-- Asignación de señales de control a partir de la microinstrucción seleccionada
    SR <= M(0);
    WD <= M(1);
    LF <= M(2);
    ALUOP <= M(6 downto 3);
    SOP2 <= M(7);
    SOP1 <= M(8);
    WR <= M(9);
    SWD <= M(10);
    SR1 <= M(11);
    WPC <= M(12);
    
    
    


    
end aUnidadControl;