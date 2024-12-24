library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux is
port (x: in std_logic_vector(7 downto 0);
      y: in std_logic_vector(7 downto 0);
      sel: in std_logic;
      saida: out std_logic_vector(7 downto 0)
      );
end mux;

architecture circuito_logico of mux is

begin 
  saida <= x when sel = '0' else
	     y;
end circuito_logico;