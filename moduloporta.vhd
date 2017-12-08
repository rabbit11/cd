Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY moduloporta IS
    PORT(   s: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            ss: IN STD_LOGIC;
            clr: IN STD_LOGIC;
            fechar: IN STD_LOGIC;
            enM: IN STD_LOGIC;
            enf: IN STD_LOGIC;
            Sp: OUT STD_LOGIC;
            sc: OUT STD_LOGIC);

END moduloporta;

ARCHITECTURE porta OF moduloporta IS
	
	SIGNAL sout : STD_LOGIC_VECTOR(3 DOWNTO 0);

	COMPONENT comparesenha
		PORT(	senhaCorreta	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				senhaRecebida	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);

				sinalComparador	: OUT STD_LOGIC);
	END COMPONENT;
    
    COMPONENT moduloAF
        PORT(   enf :IN STD_LOGIC;
                fechar: IN STD_LOGIC;
                Sp: OUT STD_LOGIC);
        END COMPONENT;

    COMPONENT chinelode
        PORT ( D, Clk, clear : IN STD_LOGIC;
            Q: OUT STD_LOGIC);
    END COMPONENT;
BEGIN

ffdB0: chinelode
PORT MAP (	D => s(0),
            Clk => ss,
            clear => clr,
            Q => sout(0));

ffdB1: chinelode
PORT MAP (	D => s(1),
            Clk => ss,
            clear => clr,
            Q => sout(1));

ffdB2: chinelode
PORT MAP (	D => s(2),
            Clk => ss,
            clear => clr,
            Q => sout(2));

ffdB3: chinelode
PORT MAP (	D => s(3),
            Clk => ss,
            clear => clr,
            Q => sout(3));
            
comapare: comparesenha
PORT MAP (	senhaCorreta => sout,
			senhaRecebida => s,
			sinalComparador => sc);
			
af: moduloAF
PORT MAP (	enf => enf,
			fechar => fechar,
			Sp => sp);

END porta;
