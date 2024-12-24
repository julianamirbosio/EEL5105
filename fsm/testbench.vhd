library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end testbench;

architecture tb of testbench is
    signal reset, B: std_logic;
    signal S: std_logic_vector(1 downto 0);
    signal meuclock: std_logic := '0';
   
    
    component fsm is 
        port (  clock, reset, B: in std_logic;
                S: out std_logic_vector(1 downto 0)
             );
    end component;
begin
    DUT : fsm port map (clock => meuclock,
                        reset => reset, 
                        B => B,
                        S => S);
    meuclock <= not meuclock after 5 ns;
    
process
        constant period: time := 10 ns;
        begin
            reset <= '1'; B <= '0';
            wait for period;
            reset <= '0'; B <= '0';
            wait for period;
            reset <= '0'; B <= '1';
            wait for period;
            reset <= '0'; B <= '0';
            wait for period;
            reset <= '0'; B <= '0';
            wait for period;
            reset <= '0'; B <= '1';
            wait for period;
            reset <= '1'; B <= '0';
            wait for period;
            wait;
    end process;

end tb;