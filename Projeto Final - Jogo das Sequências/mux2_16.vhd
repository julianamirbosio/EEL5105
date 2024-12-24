library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux2_16 is
port (x: in std_logic_vector(15 downto 0);
      y: in std_logic_vector(15 downto 0);
      sel: in std_logic;
      saida: out std_logic_vector(15 downto 0)
      );
end mux2_16;

architecture circuito_logico of mux2_16 is

begin 
  saida <= x when sel = '0' else
	     y;
end circuito_logico;

