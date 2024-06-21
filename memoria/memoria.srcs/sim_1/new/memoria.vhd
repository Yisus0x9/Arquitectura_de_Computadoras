library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity memoria_tb is
end;

architecture bench of memoria_tb is

  constant bits_bus_datos : integer := 14;  -- Ancho del bus de datos localmente definido
  constant bits_bus_dif : integer := 8;  -- Ancho del bus de dirección localmente definido

  signal Bus_Dir: STD_LOGIC_VECTOR (bits_bus_dif downto 0);
  signal Bus_Datos: STD_LOGIC_VECTOR (bits_bus_datos downto 0);

  component memoria
      generic (
          bits_bus_datos : integer := 14;
          bits_bus_dif : integer := 8
      );
      Port (
          Bus_Dir : in STD_LOGIC_VECTOR (bits_bus_dif downto 0);
          Bus_Datos : out STD_LOGIC_VECTOR (bits_bus_datos downto 0)
      );
  end component;

begin

  -- Instantiate the unit under test (UUT)
  uut: memoria
       generic map (
           bits_bus_datos => bits_bus_datos,
           bits_bus_dif   => bits_bus_dif
       )
       port map (
           Bus_Dir    => Bus_Dir,
           Bus_Datos  => Bus_Datos
       );

process
    begin
        -- Asigna un valor inicial a Bus_Dir
        Bus_Dir <= (others => '0'); -- Establece todas las posiciones a '0'
        wait for 100 ns; -- Espera 100 nanosegundos

        -- Cambia a la siguiente dirección
        Bus_Dir <= "000000001"; -- Establece todas las posiciones a '1'
        wait for 100 ns; -- Espera otros 100 nanosegundos

    -- Cambia a la siguiente dirección
        Bus_Dir <= "000000010"; -- Establece todas las posiciones a '1'
        wait for 100 ns; -- Espera otros 100 nanosegundos
           -- Cambia a la siguiente dirección
        Bus_Dir <= "000000011"; -- Establece todas las posiciones a '1'
        wait for 100 ns; -- Espera otros 100 nanosegundos
        -- Termina el proceso de prueba
        wait;
    end process;
        
end bench;
