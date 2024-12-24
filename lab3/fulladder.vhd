library IEEE;
use IEEE.Std_Logic_1164.all;
entity fulladder is
port (A: in std_logic;
      B: in std_logic;
      Cin: in std_logic;
      S: out std_logic;
      Cout: out std_logic
      );
end fulladder;

architecture circuito_logico of fulladder is
begin 
    S <= ((A xor B) xor Cin);
    Cout <= ((A xor B) and Cin) or (A and B);
end circuito_logico;