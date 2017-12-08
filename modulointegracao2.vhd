LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY modulointegracao IS
	PORT (	cancela: IN STD_LOGIC;
				bi: IN STD_LOGIC; 
				resultado: IN STD_LOGIC;
				fechar: IN STD_LOGIC;
				set: IN STD_LOGIC;
				clock: IN STD_LOGIC;
				reset: IN STD_LOGIC;
				s: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				spaux: OUT STD_LOGIC); 
				--scaux: OUT STD_LOGIC);
END modulointegracao;

ARCHITECTURE maquina OF modulointegracao IS

COMPONENT Porta
	PORT(s							: IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
		 ss, clr, enM, enF, fechar	: IN  STD_LOGIC;
		 Sp, Sc						: OUT STD_LOGIC);
	END COMPONENT;

TYPE mef IS (estadoA, estadoB, estadoC, estadoD);
SIGNAL estado : mef;
SIGNAL Sp, Sc, EnM, EnF, cancela, ss: STD_LOGIC;
--SIGNAL menor, clear: STD_LOGIC;
BEGIN
	-- MAQUINA DE ESTADOS
	PROCESS (clock, reset)
	BEGIN
		IF reset = '0' THEN
			estado <= estadoA;
		ELSIF clock'EVENT AND clock = '0' THEN 
			CASE estado IS
				WHEN estadoA =>
					estado <= estadoB;
				WHEN estadoB => 
					IF bi = '1' AND set = '1' AND resultado = '1' THEN 
						estado <= estadoC; 
					END IF;
				WHEN estadoC =>
					IF fechar = '1' AND bi ='1' AND resultado ='1' THEN 
						estado <= estadoD;
					ELSIF cancela='1' OR bi='0' THEN
						estado <= estadoB;
					END IF;
				WHEN estadoD =>
					IF set = '1' AND bi = '1' AND Sc = '1' THEN
						estado <= estadoE;
					END IF;
				WHEN estadoE => 
						estado <= estadoB;
			END CASE;
		END IF;
	END PROCESS;
	-- SAIDAS
	enM <= bi;
	enF <= '0' WHEN estado = estadoE OR estado = estadoA ELSE '1';
	--cancela <= '1' WHEN estado = estadoD ELSE '0';
	ss <= '1' WHEN estado = estadoD ELSE '0';
	clr <= '0' WHEN estado = estadoA OR estado = estadoE ELSE '1'
	spaux <= Sp;
--	scaux <= Sc;
	
	porta: moduloporta
	PORT MAP(s	=> s,	
				ss => ss
				clr => clr,
				enM => enM, 
				enF => enF, 
				fechar=>fechar,
				Sp => Sp,
				Sc => Sc);
				
END maquina;