library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity counter_round is port (
    Set, Enable, Clock: in  std_logic;
    end_round           : out std_logic;
    X                   : out std_logic_vector(3 downto 0));
    
end counter_round;

architecture arc_counter of counter_round is
signal cont: std_logic_vector (3 downto 0);

begin

	process (Set, Enable, Clock) 
	begin
	
	if Set = '1' then
	    cont <= "0000";
		 
   elsif Clock'event and Clock = '1' then   
	    if enable = '1' then
	         cont <= cont + "0001";
				
	   end if;
	end if;
	end process;
	
	end_round <= '1' when cont = "1111" else '0';
	
	
	X <= cont;
end arc_counter;
