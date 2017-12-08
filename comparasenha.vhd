LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY comparasenha IS
    PORT (
			senhaCorreta	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			senhaRecebida	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			sinalComparador	: OUT STD_LOGIC
    );
    END comparasenha;

ARCHITECTURE lock of comparasenha is

	SIGNAL compare : STD_LOGIC;
	BEGIN
	PROCESS (senhaCorreta, senhaRecebida)
	BEGIN
		
		IF (senhaCorreta = senhaRecebida) THEN
			compare <= '1';
		ELSE
			compare <= '0';
			
		END IF;
		
	END PROCESS;
	
	sinalComparador <= compare;

END lock;