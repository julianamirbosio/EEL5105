library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ctrl_ula is
	port (
        ULAOp : in std_logic_vector(1 downto 0);
        Funct : in std_logic_vector(5 downto 0);
        Saida : out std_logic_vector(2 downto 0)
        	);
end ctrl_ula;

architecture beh of ctrl_ula is
    begin
    
-- add 010
-- sub 110
-- and 000
-- or  001
-- stl 111

--    with ULAOp select
--    Saida <= "010" when "00",
--             "110" when "01",
--             "010" when "10" and Funct = "100000",
--             "110" when "10" and Funct = "100010",
--             "000" when "10" and Funct = "100100",
--             "001" when "10" and Funct = "100101",
--             "111" when "10" and Funct = "101010",
--             "000" when others; -- Default case for safety

    Saida <= "010" when ULAOp = "00" or (ULAOp = "10" and Funct = "100000") 
        else "110" when ULAOp = "01" or (ULAOp = "10" and Funct = "100010") 
        else "000" when ULAOp = "10" and Funct = "100100" 
        else "001" when  ULAOp = "10" and Funct = "100101"  
        else "111" when  ULAOp = "10" and Funct = "101010";             
end beh;       



        


                 
                 
                 
    
 


