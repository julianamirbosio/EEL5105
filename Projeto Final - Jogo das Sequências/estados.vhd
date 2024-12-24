library ieee;
use ieee.std_logic_1164.all;

entity estados is port (
  clock, reset: in std_logic;
  S: out std_logic_vector(1 downto 0) );
end fsm;

architecture abrir of fsm is
  type STATES is (init, setup,);
  signal EAtual, PEstado: STATES;
begin
  process(clock, reset)
  begin
    if (reset = '1') then
	  EAtual <= init;
	elsif (clock'event AND clock = '1') then 
  	  EAtual <= PEstado;
	end if;
  end process;
process(EAtual, B)
  begin
    case EAtual is
    
      when init =>
         S <= "10";
         if B = '0' then
            PEstado <= init;
        elsif B = '1' then
            PEstado <= on1;
        end if;
        
	  when on1 => 	Pestado <= off1; S <= "01";
		 
	  when off1 => 	Pestado <= on2; S <= "00";
	   
	  when on2 => 	Pestado <= off2; S <= "01";
	    
      when off2 =>
        S <= "10";
         if B = '0' then
            PEstado <= off2;
        elsif B = '1' then
            PEstado <= on1;
        end if;

    end case;
  end process;
end abrir;