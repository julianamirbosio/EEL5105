library ieee;
use ieee.std_logic_1164.all;

entity cofre is port (
  clock: in std_logic;
  key: in std_logic_vector (3 downto 0);
  led: out std_logic );
end cofre;

architecture abrir of cofre is
  type STATES is (INIT, WAIT1, WAIT2, CORRETO1, CORRETO2, FIM1, FIM2);
  signal EAtual, PEstado: STATES;
begin
  process(clock, KEY(3))
  begin
    if (key(3) = '0') then
	  EAtual <= INIT;
	elsif (clock'event AND clock = '1') then 
  	  EAtual <= PEstado;
	end if;
  end process;
process(EAtual, key(2 downto 0))
  begin
    case EAtual is
    
      when INIT =>
         led <= '1';
         if (key(2 downto 0) = "111") then
            PEstado <= INIT;
        elsif (key(2 downto 0) = "011") then
            PEstado <= WAIT1;
        elsif (key(2 downto 0) /= "111") then
            PEstado <= FIM1;
        end if;
        
	  when WAIT1 =>
	    led <= '0';
	    if (key(2) = '1') then
	        PEstado <= CORRETO1;
		 end if;
		 
	  when CORRETO1 =>
	    led <= '0';
	    if (key(2 downto 0) = "110") then
	        PEstado <= WAIT2;
	    elsif (key(2 downto 0) = "111") then
	        PEstado <= CORRETO1;
	    elsif (key(2 downto 0) /= "111" and key(2 downto 0) /= "110") then
	        PEstado <= FIM1;
	   end if;
	   
	  when WAIT2 =>
	    led <= '0';
	    if (key(0) = '1') then
	        PEstado <= CORRETO2;
	    end if;
	    
      when CORRETO2 =>
        led <= '0';
        if (key(2 downto 0) = "101") then
            PEstado <= FIM2;
        elsif (key(2 downto 0) /= "111" and key(2 downto 0) /= "101") then
            PEstado <= FIM1;
        end if;
        
      when FIM1 =>
        led <= '0';
        PEstado <= FIM1;
        
      when FIM2 =>
        led <= '1';
        PEstado <= FIM2;
        
    end case;
  end process;
end abrir;