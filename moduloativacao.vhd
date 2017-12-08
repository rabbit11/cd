Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY moduloativacao IS
    PORT(   enM: IN STD_LOGIC;
            s: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Sp: IN STD_LOGIC;
            ss: IN STD_LOGIC;
            clr: IN STD_LOGIC;
            Sc: OUT STD_LOGIC);
END moduloativacao;

ARCHITECTURE modulo of moduloativacao IS
    
SIGNAL ssout:	STD_LOGIC_VECTOR(3 DOWNTO 0);

COMPONENT chinelode
	
    PORT ( D, Clk, clear : IN STD_LOGIC;
		   Q: OUT STD_LOGIC);
END COMPONENT;

BEGIN

ffdB0: chinelode
PORT MAP (	D => s(0),
			Clk => ss,
			clear => clr,
			Q => ssout(0));

ffdB1: chinelode
PORT MAP (	D => s(1),
			Clk => ss,
			clear => clr,
			Q => ssout(1));

ffdB2: chinelode
PORT MAP (	D => s(2),
			Clk => ss,
			clear => clr,
			Q => ssout(2));

ffdB3: chinelode
PORT MAP (	D => s(3),
			Clk => ss,
			clear => clr,
			Q => ssout(3));
        
END modulo;