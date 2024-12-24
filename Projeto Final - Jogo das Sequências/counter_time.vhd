library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity counter_time is port (
    Set, Enable, Clock: in  std_logic;
	Load              : in  std_logic_vector(7 downto 0);
    end_time          : out std_logic;
    t_out             : out std_logic_vector(7 downto 0));
    
end counter_time;

architecture arc_counter of counter_time is

signal cont: std_logic_vector(7 downto 0);

begin

	process (Set, Enable, Clock, Load) 
	begin
		 
	if set = '1' then
		cont <= "01100011";
		
		 
   elsif Clock'event and Clock = '1' then   
	    if Enable = '1' then
	        	cont <= cont + Load;
	        	
	    end if;
	end if;
	end process;
	
	end_time <= '1' when (cont < "00000001") else '0';
	
	t_out <= cont;
	
end arc_counter;