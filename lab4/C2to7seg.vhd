library IEEE;
use IEEE.Std_Logic_1164.all;

entity C2to7seg is
port (C2: in std_logic_vector(3 downto 0);
      sinal: out std_logic;
      s7seg: out std_logic_vector(6 downto 0)
      );
end C2to7seg;

architecture circuito_logico of C2to7seg is
  signal J,S: std_logic_vector(3 downto 0);
  
component Compl2 is
    port (X:  in std_logic_vector(3 downto 0);
          Y:  out std_logic_vector(3 downto 0));
end component;
  
component mux is
    port (x: in std_logic_vector(3 downto 0);
          y: in std_logic_vector(3 downto 0);
          sel: in std_logic;
          saida: out std_logic_vector(3 downto 0)
          );
end component;
  
component decodUFSC is
    port (C:  in std_logic_vector(3 downto 0);
          F:  out std_logic_vector(6 downto 0) );
end component;
  
begin 
    sinal <= not C2(3);
    
    Compl2A: Compl2 port map (c2, J);
    MuxA: mux port map (c2, J, c2(3), S);
    DecodA: decodUFSC port map (S, s7seg);
    
end circuito_logico;