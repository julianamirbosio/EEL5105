library ieee;
use ieee.std_logic_1164.all;
entity circuito_digital is port (
   clock: in std_logic;
   reset: in std_logic;
   LEDR2, LEDR1, LEDR0: out std_logic );
end circuito_digital;
architecture fsm1arq of circuito_digital is
   type STATES is (A, B, C, D);
   signal EAtual, PEstado: STATES;
begin
	process(clock,reset)
	begin
	    if (reset = '1') then
			EAtual <= A;
        elsif (clock'event AND clock = '1') then 
         	EAtual <= PEstado;
	    end if;
	end process;
    process(EAtual)
	begin
		case EAtual is
			when A => 	Pestado <= B;
                     		LEDR2 <= '1';
                     		LEDR1 <= '1';
                     		LEDR0 <= '1'; 
			when B => 	Pestado <= C;
						    LEDR2 <= '0';
                     		LEDR1 <= '1';
                     		LEDR0 <= '1';
            when C => 	Pestado <= D;
						    LEDR2 <= '0';
                     		LEDR1 <= '0';
                     		LEDR0 <= '1';
            when D => 	Pestado <= A;
						    LEDR2 <= '0';
                     		LEDR1 <= '0';
                     		LEDR0 <= '0';
		end case;
	end process;
end fsm1arq;
