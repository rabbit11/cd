Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY chinelode IS
	PORT ( D, Clk, clear : IN STD_LOGIC;
		   Q: OUT STD_LOGIC);
END chinelode;
	
ARCHITECTURE NUMVAIDA OF chinelode IS

SIGNAL qstate: STD_LOGIC;

BEGIN
	PROCESS (Clk, clear)
	BEGIN
		IF clear = '1' THEN
			qstate <= '0';
		ELSIF Clk'EVENT AND Clk='1' THEN
			qstate <= D;
		END IF;
	END PROCESS;
	
	Q <= qstate;
	
END NUMVAIDA;