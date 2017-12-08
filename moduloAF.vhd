Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY moduloAF IS
	PORT(	enF	: IN STD_LOGIC;
			fechar: IN STD_LOGIC;
			Sp		: OUT STD_lOGIC);
END moduloAF;

ARCHITECTURE af OF moduloAF IS
BEGIN
	PROCESS(enF,fechar)
	BEGIN
		IF enF = '0' THEN
			Sp <= '1';
		ELSIF fechar'EVENT AND fechar = '1' THEN
			Sp <= '0';
		END IF;
	END PROCESS;
END af;