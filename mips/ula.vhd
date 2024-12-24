library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ula is 
    generic ( width: positive );
	port (
		A, B : in std_logic_vector(width-1 downto 0);
        op : in std_logic_vector(2 downto 0);
        zero : out std_logic;
        res : out std_logic_vector(width-1 downto 0)
	);
end ula;

architecture beh of ula is 
    signal soma, subtracao : signed(width-1 downto 0);
    signal resultado, valorZero, menor : std_logic_vector(width-1 downto 0);
    
    begin
        valorZero <= (others => '0');
        
        soma <= signed(A) + signed(B);
        subtracao <= signed(A) - signed(B);
        
        menor <= (others => '0');
        -- Determina se subtracao é negativa e atribui '1' para menor
        menor(0) <= '1' when subtracao(width-1) = '1';
             
        resultado <= A and B                        when op = "000"   -- Realiza a operação AND se op for "000"
                 else A or B                        when op = "001"   -- Realiza a operação OR se op for "001"
                 else std_logic_vector(soma)        when op = "010"   -- Retorna a soma se op for "010"
                 else std_logic_vector(subtracao)   when op = "110"   -- Retorna a subtração se op for "110"
                 else menor                         when op = "111";   -- Retorna menor se op for "111"
             
             
        zero <= '1' when resultado = valorZero else '0';
        res <= resultado;
end beh;

