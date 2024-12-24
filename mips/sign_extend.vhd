library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extend is
    generic ( 
             larguraEntrada : integer;  
             larguraExtendido : integer
    );
	port (
		entrada : in std_logic_vector(larguraEntrada-1 downto 0);
        saida : out std_logic_vector(larguraExtendido-1 downto 0)
	);
end sign_extend;

architecture beh of sign_extend is
	begin
	    -- os ultimos (largura entrada) bits da saida vao receber os bits da entrada
	    saida(larguraEntrada-1 downto 0) <= entrada;
	    -- o resto dos bits da saida vai receber o bit mais significativo da entrada
        saida(larguraExtendido-1 downto larguraEntrada) <= (others => entrada(larguraEntrada-1));
end beh;