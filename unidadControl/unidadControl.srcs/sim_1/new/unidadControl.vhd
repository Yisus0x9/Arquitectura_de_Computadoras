library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity unidadControl_tb is
end;

architecture bench of unidadControl_tb is

  -- Definición de constantes para los bits del bus de datos de función y operación
  constant bitsBusDatosMemFun : integer := 4;
  constant bitsBusDatosMemOp  : integer := 5;

  component unidadControl
      generic (bitsBusDatosMemFun : integer := 4;
               bitsBusDatosMemOp : integer := 5);
      Port ( cod_fun : in STD_LOGIC_VECTOR (bitsBusDatosMemFun-1 downto 0);
             cod_op : in STD_LOGIC_VECTOR (bitsBusDatosMemOp-1 downto 0);
             Z, N, OV, C : in STD_LOGIC;
             CLR, CLK : in STD_LOGIC;
             WPC, SR1, SWD, WR, SOP1, SOP2, WD, SR : out STD_LOGIC;
             ALUOP : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  -- Declaración de señales con las constantes definidas anteriormente
  signal cod_fun: STD_LOGIC_VECTOR (bitsBusDatosMemFun-1 downto 0); -- 3
  signal cod_op: STD_LOGIC_VECTOR (bitsBusDatosMemOp-1 downto 0); --4
  signal Z, N, OV, C: STD_LOGIC;
  signal CLR, CLK: STD_LOGIC;
  signal WPC, SR1, SWD, WR, SOP1, SOP2, WD, SR: STD_LOGIC;
  signal ALUOP: STD_LOGIC_VECTOR (3 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean := false;

begin

  -- Instancia del componente bajo prueba
  uut: unidadControl 
    generic map ( bitsBusDatosMemFun => bitsBusDatosMemFun,
                  bitsBusDatosMemOp  => bitsBusDatosMemOp )
    port map ( cod_fun => cod_fun,
               cod_op  => cod_op,
               Z       => Z,
               N       => N,
               OV      => OV,
               C       => C,
               CLR     => CLR,
               CLK     => CLK,
               WPC     => WPC,
               SR1     => SR1,
               SWD     => SWD,
               WR      => WR,
               SOP1    => SOP1,
               SOP2    => SOP2,
               WD      => WD,
               SR      => SR,
               ALUOP   => ALUOP );

  -- Proceso de estímulo
  stimulus: process
  begin
   

    -- Instruccion reset 
    cod_op <= "00000";
    cod_fun <= "0000";
    Z <= '0';
    C <= '0';
    N <= '0';
    OV <= '0';
    CLR <= '1';
    wait for 10 * clock_period;
    
    -- Instruccion ADD 
    cod_op <= "00000";
    cod_fun <= "0000";
    Z <= '1';
    C <= '0';
    N <= '0';
    OV <= '0';
    CLR <= '0';
    wait for 10 * clock_period;

    --Instruccin SUB
    cod_op <= "00000";
    cod_fun <= "0001";
    Z <= '0';
    C <= '1';
    N <= '0';
    OV <= '1';
    CLR <= '0';
    wait for 10 * clock_period;
    
    --Instruccin AND
    cod_op <= "00000";
    cod_fun <= "0010";
    Z <= '0';
    C <= '0';
    N <= '1';
    OV <= '0';
    CLR <= '0';
    wait for 10 * clock_period;

    --Instruccin OR
    cod_op <= "00000";
    cod_fun <= "0011";
    Z <= '1';
    C <= '0';
    N <= '0';
    OV <= '0';
    CLR <= '0';
    wait for 10 * clock_period;

    stop_the_clock <= true;
    wait;
  end process;

  -- Proceso de generación de reloj
  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0';
      wait for clock_period / 2;
      CLK <= '1';
      wait for clock_period / 2;
    end loop;
    wait;
  end process;

end bench;