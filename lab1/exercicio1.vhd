library IEEE;
use IEEE.Std_Logic_1164.all;

entity sofieju is
port (A: in std_logic;
      B: in std_logic;
      C: in std_logic;
      D: in std_logic;
      W: out std_logic;
      X: out std_logic;
      Y: out std_logic;
      Z: out std_logic
      );
end sofieju;

architecture circuito_logico of sofieju is
begin 
  W <= ((not A and not B and C) or (not A and not B) or (A and C and not D) or (A and not B and not C));
  X <= ((not A and not B and D) or (not B and C and not D) or (not A and B) or (A and not B and not C));
  Y <= ((not C) and (not D));
  Z <= ((not A and not B) or (not A and B and not C and not D));
end circuito_logico;
