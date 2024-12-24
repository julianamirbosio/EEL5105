library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity counter_seq is port (
    Reset, Enable, Clock: in  std_logic;
    end_sequence: out std_logic;
    seq: out std_logic_vector(2 downto 0));
end counter_seq;

architecture arc_counter of counter_seq is
signal cont: std_logic_vector (2 downto 0);
begin
	process (Reset, Enable, Clock, cont) 
	begin
	if reset = '1' then
	    cont <= "000";
		 end_sequence <= '0';
		 
   elsif Clock'event and Clock = '1' then   
	    if enable = '1' then
	        	cont <= cont + "001";
	    end if;
		 
		 if cont = "011" then
		    end_sequence <= '1';
		 else
		    end_sequence <= '0';
		 end if;
	end if;
	end process;
	
	seq <= cont;
end arc_counter;