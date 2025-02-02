library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity datapath is port(

    SW: in std_logic_vector(7 downto 0);
    CLK: in std_logic;
	Enter: in std_logic;
    R1, E1, E2, E3, E4, E5, E6: in std_logic;
	end_game, end_sequence, end_round: out std_logic;
    HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0);
    LEDR: out std_logic_vector(17 downto 0));

end datapath;

architecture arc_data of datapath is

-- signals


signal clk1, sim_2hz, control, E4_and_clk1, E5_or_E4clk1, E1_or_E5, R1_or_E5, rst_divfreq: std_logic;
signal sel: std_logic_vector(1 downto 0);
signal X: std_logic_vector(2 downto 0);
signal Y, Alpha, Beta, mux_hx7, mux_hx6, d7_hx0_2SEL: std_logic_vector(3 downto 0);
signal dec7_hx7, dec7_hx6, dec7_hx1_1, dec7_hx1_2, dec7_hx1_3, dec7_hx0_1, dec7_hx0_2, dec7_hx0_3, dec7_hx0_4, mux_hx1_1, mux_hx1_2, mux_hx1_3, mux_hx0_1, mux_hx0_2, mux_hx0_3, L: std_logic_vector(6 downto 0);
signal reg8b_out, penalty, T_out, T_BCD, mux_control, mux_time, mux_soma1, mux_soma2, mux_soma3, mux_soma4, soma1, soma2, soma3, Seq, Seq_BCD: std_logic_vector(7 downto 0);
signal muxsomaX3, muxsomaX2, muxsomaX1, muxsomaX0, muxsomaBeta: std_logic_vector (7 downto 0);
signal termo, play, pisca, end_round_and_pisca, reg16b_in: std_logic_vector(15 downto 0);


----- components

component decoder_termometrico is port(
    
    X: in  std_logic_vector(3 downto 0);
    S: out std_Logic_vector(15 downto 0));
    
end component;

component somador is port (
A: in std_logic_vector(7 downto 0);
B: in std_logic_vector(7 downto 0);
S: out std_logic_vector(7 downto 0)
);
end component;

component Div_Freq is -- Usar esse componente para o emulador
	port (	clk: in std_logic;
			reset: in std_logic;
			CLK_1Hz, sim_2hz: out std_logic
			);
end component;

component Div_Freq_DE2 is -- Usar esse componente para a placa DE2
	port (	clk: in std_logic;
			reset: in std_logic;
			CLK_1Hz, sim_2hz: out std_logic
			);
end component;

component counter_seq is port(

    Reset, Enable, Clock: in  std_logic;
    end_sequence        : out std_logic;
    seq                 : out std_logic_vector(2 downto 0));
    
end component;

component counter_time is port(

    Set, Enable, Clock: in  std_logic;
	 Load                     : in  std_logic_vector(7 downto 0);
    end_time                 : out std_logic;
    t_out                    : out std_logic_vector(7 downto 0));
    
end component;

component counter_round is port(

    Set, Enable, Clock: in  std_logic;
    end_round           : out std_logic;
    X                   : out std_logic_vector(3 downto 0));
    
end component;

component DecBCD is port (

	input  : in  std_logic_vector(7 downto 0);
	output : out std_logic_vector(7 downto 0));

end component;

component Reg8b is port(

    D     : in  std_logic_vector(7 downto 0);
    Reset : in  std_Logic;
    Enable: in  std_logic;
    CLK   : in  std_logic;
    Q     : out std_logic_vector(7 downto 0));
	 
end component;

component Reg2b is port(

    D     : in  std_logic_vector(1 downto 0);
    Reset : in  std_Logic;
    Enable: in  std_logic;
    CLK   : in  std_logic;
    Q     : out std_logic_vector(1 downto 0));
    
end component;

component Reg16b is port(

    D     : in  std_logic_vector(15 downto 0);
    Reset : in  std_Logic;
    Enable: in  std_logic;
    CLK   : in  std_logic;
    Q     : out std_logic_vector(15 downto 0));
    
end component;

component Comparador is port(
    
    in0, in1: in  std_logic_vector(7 downto 0);
    S       : out std_logic);
    
end component;

component Mux2_1x4 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(3 downto 0);
    D     : out std_logic_vector(3 downto 0));
    
end component;

component Mux2_1x8 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(7 downto 0);
    D     : out std_logic_vector(7 downto 0));
    
end component;

component Mux4_1x8 is port(

    S             : in  std_logic_vector(1 downto 0);
    L0, L1, L2, L3: in  std_logic_vector(7 downto 0);
    D             : out std_logic_vector(7 downto 0));
    
end component;

component Mux2_1x16 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(15 downto 0);
    D     : out std_logic_vector(15 downto 0));
    
end component;

component Mux2_1x7 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(6 downto 0);
    D     : out std_logic_vector(6 downto 0));
    
end component;

component decod7seg is port (

	input  : in  std_logic_vector(3 downto 0);
	output : out std_logic_vector(6 downto 0));

end component;


begin

-- reg16b 
reg16b_in <= SW(7 downto 0)&Seq_BCD;

reg_16b: Reg16b port map(reg16b_in, R1, E4, CLK, play);

-- reg8b
Alpha <= reg8b_out(7 downto 4);
Beta <= reg8b_out(3 downto 0);

reg_8b: Reg8b port map(SW(7 downto 0), R1, E2, CLK, reg8b_out);

-- lógica da soma da sequência

muxsomaX0 <= "00000"&X;
muxsomaX1 <= "0000"&X&"0";
muxsomaX2 <= "000"&X&"00";
muxsomaX3 <= "00"&X&"000";
muxsomaBeta <= "0000"&Beta;

mx_soma1: mux2_1x8 port map(Alpha(3), "00000000", muxsomaX3, mux_soma1);
mx_soma2: mux2_1x8 port map(Alpha(2), "00000000", muxsomaX2, mux_soma2);
mx_soma3: mux2_1x8 port map(Alpha(1), "00000000", muxsomaX1, mux_soma3);
mx_soma4: mux2_1x8 port map(Alpha(0), "00000000", muxsomaX0, mux_soma4);

somador1: somador port map(mux_soma1, mux_soma2, soma1);
somador2: somador port map(mux_soma3, mux_soma4, soma2);
somador3: somador port map(soma1, soma2, soma3);
somador4: somador port map(soma3, muxsomaBeta, Seq);

decBCDsoma: decBCD port map(Seq, Seq_BCD);

-- comparador 

comp: Comparador port map(play(7 downto 0), play(15 downto 8), control);

------ HEX ----------------------------

--usando o decod7seg fornecido, "1111" apaga os displays

--HEX7

d7_hx7: decod7seg port map(T_BCD(7 downto 4), HEX7);

--HEX6

d6_hx6: decod7seg port map(T_BCD(3 downto 0), HEX6);

--HEX5
HEX5 <= "1111111";

--HEX4
HEX4 <= "1111111";

--HEX3
HEX3 <= "1111111";

--HEX2
HEX2 <= "1111111";

--HEX1

L <= "1000111";

d7_hx1_1: decod7seg port map("1111", dec7_hx1_1);
d7_hx1_2: decod7seg port map(Seq_BCD(7 downto 4), dec7_hx1_2);
d7_hx1_3: decod7seg port map(SW(3 downto 0), dec7_hx1_3);

mx1hx1: mux2_1x7 port map(E1, dec7_hx1_1, L, mux_hx1_1);
mx2hx1: mux2_1x7 port map(E4, dec7_hx1_2, dec7_hx1_3, mux_hx1_2);
mx3hx1: mux2_1x7 port map(E3, mux_hx1_1, mux_hx1_2, HEX1);

--HEX0

d7_hx0_2SEL <= "00"&SEL(1 downto 0);

d7_hx0_1: decod7seg port map("1111", dec7_hx0_1);
d7_hx0_2: decod7seg port map(d7_hx0_2SEL, dec7_hx0_2);
d7_hx0_3: decod7seg port map(Seq_BCD(3 downto 0), dec7_hx0_3);
d7_hx0_4: decod7seg port map(SW(3 downto 0), dec7_hx0_4);

mx1hx0: mux2_1x7 port map(E1, dec7_hx0_1, dec7_hx0_2, mux_hx0_1);
mx2hx0: mux2_1x7 port map(E4, dec7_hx0_3, dec7_hx0_4, mux_hx0_2);
mx3hx0: mux2_1x7 port map(E3, mux_hx0_1, mux_hx0_2, HEX0);

---- Reg2b & Penalty

mx4_1x8_1: mux4_1x8 port map(SEL, "11111110", "11111100", "11111010", "11111000", Penalty);
reg2bits: reg2b port map(SW(1 downto 0), R1, E1, CLK, SEL);

-- counter_seq

R1_or_E5 <= R1 or E5;

cnt_seq: counter_seq port map(R1_or_E5, E3, CLK1, end_sequence, X);

---- counter_time

E4_and_clk1 <= E4 and clk1;
E5_or_E4clk1 <= E5 or E4_and_clk1;

mx_control: mux2_1x8 port map(control, penalty, "00000000", mux_control);
mx_time: mux2_1x8 port map(E5, "11111111", mux_control, mux_time);

cnt_time: counter_time port map(R1, E5_or_E4clk1, clk, mux_time, end_game, T_out);

dec7bcd: decBCD port map(T_out, T_bcd);

--- Counter Round

cntround: counter_round port map(R1, E5, CLK, end_round, Y);

dectermo: decoder_termometrico port map(Y, termo);


---- DIV FREQ

rst_divfreq <= E1 or E2;
--divfreq: div_freq_DE2 port map(CLK, rst_divfreq, CLK1, sim_2hz); -- usar este para a placa DE2
divfreq: div_freq port map(clk, rst_divfreq, clk1, sim_2hz); -- usar este para o emulador

---- SAIDA LEDR

mx_led: mux2_1x16 port map(E6, Termo, pisca, LEDR(15 downto 0));

-- Sinais/Entradas logicas

pisca <= "1111111111111111" and clk1&clk1&clk1&clk1&clk1&clk1&clk1&clk1&clk1&clk1&clk1&clk1&clk1&clk1&clk1&clk1;

end arc_Data;