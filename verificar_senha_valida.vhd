LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY verificar_senha_valida IS
    PORT (
			senha			: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			resultado		: OUT STD_LOGIC
    );
    END verificar_senha_valida;

ARCHITECTURE lock of verificar_senha_valida is

	SIGNAL result : STD_LOGIC;
 
	BEGIN	
	PROCESS (senha)
	BEGIN
		
		IF (senha = "0000" OR senha = "1111") THEN
			result <= '0';
		ELSE
			result <= '1';
			
		END IF;
		
	END PROCESS;
	
	resultado <= result;

END lock;