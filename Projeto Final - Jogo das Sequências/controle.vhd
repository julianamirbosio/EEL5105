library ieee;
use ieee.std_logic_1164.all; 

entity controle is port(
    
    clock, enter, reset: in std_logic;
    end_game, end_sequence, end_round: in std_logic;
    R1, E1, E2, E3, E4, E5, E6: out std_logic);

end controle;

architecture arc_controle of controle is

    type STATES is (init, setup, select0, sequence, play, check, result);
    signal EAtual, PEstado: STATES;
    
begin
    process(clock, reset)
    begin
        if (reset = '1') then
            EAtual <= init;
        elsif(clock'event and clock = '1') then
            EAtual <= PEstado;
        end if;
    end process;
    
    process(end_sequence, end_game, end_round, EAtual, enter)
    begin
        case EAtual is
        
            when init =>
                R1 <= '1';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                E6 <= '0';
                
                PEstado <= setup;
                    
            when setup =>
                R1 <= '0';
                E1 <= '1';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                E6 <= '0';
					 
                if (enter = '1') then
                    PEstado <= select0;
                else
                    PEstado <= setup;
                end if;
                
            when select0 =>
                R1 <= '0';
                E1 <= '0';
                E2 <= '1';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                E6 <= '0';
					 
                if (enter = '1') and (end_round = '0') and (end_game = '0') then
                    PEstado <= sequence;
                elsif (end_round = '1') or (end_game = '1') then
							PEstado <= result;
				else
                    PEstado <= select0;
                end if;
				
				when sequence =>
                R1 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '1';
                E4 <= '0';
                E5 <= '0';
                E6 <= '0';
					 
                if (end_sequence = '1') then
                    PEstado <= play;
                else
                    PEstado <= sequence;
                end if;
                
            when play =>
                R1 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '1';
                E5 <= '0';
                E6 <= '0';
					 
                if end_game = '1' or end_round = '1' then
						  PEstado <= result;
				elsif (enter = '1') then
                    PEstado <= check;
                else
                    PEstado <= play;
                end if;
                
            when check =>
                R1 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '1';
                E6 <= '0';
					 
                PEstado <= select0;
                
            when result =>
                R1 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                E6 <= '1';
					 
                if (enter = '1') then
                    PEstado <= init;
                else
                    PEstado <= result;
                end if;
                
        end case;
    end process;
end arc_controle;        