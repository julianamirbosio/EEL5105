library IEEE;
use IEEE.Std_Logic_1164.all;

entity majority is
port (A1: in std_logic;
      A0: in std_logic;
      B1: in std_logic;
      B0: in std_logic;
      S0: out std_logic;
      S1: out std_logic;
      S2: out std_logic
      );
end majority;

architecture circuito_logico of majority is
begin 
  S <= ((A xor B) xor C);
  X <= ((A xor B) and C) or (A and B);
end circuito_logico;
