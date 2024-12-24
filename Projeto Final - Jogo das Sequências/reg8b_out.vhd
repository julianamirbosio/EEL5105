library ieee;
use ieee.std_logic_1164.all;
entity reg8b_out is port (
	CLK, Enable, Reset: in std_logic;	
	D: in std_logic_vector(7 downto 0);
	Q: out std_logic_vector(7 downto 0));
end reg8b_out;
architecture behv of reg8b_out is
begin
	process(CLK, Enable, Reset)
	begin
		if (CLK'event and CLK = '1') and (Enable = '1') and (Reset = '0') then
             Q <= D;
        elsif (Reset = '1') then
		    Q <= "00000000";
		end if;
	end process;
end behv;