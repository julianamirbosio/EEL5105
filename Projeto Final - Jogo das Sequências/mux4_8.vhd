library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux4_8 is
port (w, x, y, z: in std_logic_vector(7 downto 0);
      sel: in std_logic_vector(1 downto 0);
      saida: out std_logic_vector(7 downto 0)
      );
end mux4_8;

architecture circuito_logico of mux4_8 is

begin 
  saida <= w when sel = "00" else
	     x when sel = "01" else
	     y when sel = "10" else
	     z;
end circuito_logico;

