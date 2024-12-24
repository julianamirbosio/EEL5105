library IEEE;
use IEEE.Std_Logic_1164.all;

entity exercicio2 is
port (B: in std_logic_vector(7 downto 0);
      A1: out std_logic_vector(6 downto 0);
      A2: out std_logic_vector(6 downto 0);
      A3: out std_logic_vector(6 downto 0);
      sel: in std_logic
      );
end exercicio2;

architecture circuito_logico of exercicio2 is
  signal J,S,A,H: std_logic_vector(7 downto 0);
  signal X: std_logic_vector(11 downto 0);
  
component soma8 is
    port (A:  in std_logic_vector(7 downto 0);
          B:  in std_logic_vector(7 downto 0);
          S:  out std_logic_vector(7 downto 0)
         );
end component;
  
component div4 is
    port (A:  in std_logic_vector(7 downto 0);
          S:  out std_logic_vector(7 downto 0)
         );
end component;
  
component binbcd is
    port (
        bin_in: in std_logic_vector (7 downto 0);
        bcd_out: out std_logic_vector (11 downto 0)
    );
end component;

component bcd7seg is
    port (bcd_in:  in std_logic_vector(3 downto 0);
          out_7seg:  out std_logic_vector(6 downto 0)
         );
end component;

component mux is
port (x: in std_logic_vector(7 downto 0);
      y: in std_logic_vector(7 downto 0);
      sel: in std_logic;
      saida: out std_logic_vector(7 downto 0)
      );
end component;
  
begin
    soma8A: soma8 port map (B, B, J);
    div4A: div4 port map (B, S);
    soma8B: soma8 port map (S, J, A);
    binbcdA: binbcd port map (H, X);
    bcd7segA: bcd7seg port map (X(11 downto 8), A1);
    bcd7segB: bcd7seg port map (X(7 downto 4), A2);
    bcd7segC: bcd7seg port map (X(3 downto 0), A3);
    muxA: mux port map (B, A, sel, H);
    
end circuito_logico;
  