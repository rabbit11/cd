LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY josoares IS
	PORT( numeric_button    : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		  card_pass	   		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  ok						: IN STD_LOGIC;
		  cancel					: IN STD_LOGIC;
		  reset					: IN STD_LOGIC;
		  fechar 				: IN STD_LOGIC; --mapear como push button
		  clock					: IN STD_LOGIC; --clock interno - perguntar numeracao do pino
		  bi						: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		  si 						: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		  set 					: OUT STD_LOGIC;
		  clear 					: OUT STD_LOGIC;

		  dig_led           : OUT STD_LOGIC_VECTOR (0 TO 6));
END josoares;

ARCHITECTURE entry_panel OF josoares IS

	SIGNAL bdecoded,b		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL limpa 		: STD_LOGIC;
	SIGNAL salvar_senha, senha_invalida : STD_LOGIC;
	
	COMPONENT verificar_senha_valida
		 PORT (
			senha			: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			resultado		: OUT STD_LOGIC
    );
    END COMPONENT;

	COMPONENT chinelode
		PORT ( D, Clk, clear : IN STD_LOGIC;
			   Q: OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT display
		PORT(	valor         : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			    dig0          : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;

	COMPONENT decodeEntry
		PORT(   button          : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        
        		buttonExtended  : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
	END COMPONENT;
	
	
	
	COMPONENT modulointegracao2
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
		END COMPONENT;
	
BEGIN
	nok <= NOT ok;
	decode: decodeEntry
	PORT MAP (	button => numeric_button,
				buttonExtended => bdecoded);

	digDisplay: display
	PORT MAP (	valor => numeric_button,
				dig0 => dig_led);
				
	verify: verificar_senha_valida
	PORT MAP (	
				senha => card_pass,
				resultado => senha_invalida);
	-- repetir esta merda 4 vezes e alterar apenas os indices do vetor
	integrator: modulointegracao2
	PORT MAP(cancela =>cancel,
				bi => b(0),
				resultado => senha_invalida,
				fechar => fechar,
				set => nok,
				clock => clock,
				reset => reset,
				s => si,
				spaux => bi(0));
				
				
				
	-- bdecoded 1precisa ser testado pra ver se ta funcionando certo, de resto acho que ta suave
	-- precisa ver como vai funfar o Si, mas por enqquanto acho que ta certo tb nesse modulo de entrada
	-- Lembra que a porta 1 é acionada com 00, só depois eu transformo pra 0001
	ffdB0: chinelode
	PORT MAP (	D => bdecoded(0),
				Clk => ok,
				clear => limpa,
				Q => b(0));

	ffdB1: chinelode
	PORT MAP (	D => bdecoded(1),
				Clk => ok,
				clear => limpa,
				Q => b(1));

	ffdB2: chinelode
	PORT MAP (	D => bdecoded(2),
				Clk => ok,
				clear => limpa,
				Q => b(2));

	ffdB3: chinelode
	PORT MAP (	D => bdecoded(3),
				Clk => ok,
				clear => limpa,
				Q => b(3));

	ffdS0: chinelode
	PORT MAP (	D => card_pass(0),
				Clk => salvar_senha,
				clear => limpa,
				Q => si(0));

	ffdS1: chinelode
	PORT MAP (	D => card_pass(1),
				Clk => salvar_senha,
				clear => limpa,
				Q => si(1));

	ffdS2: chinelode
	PORT MAP (	D => card_pass(2),
				Clk => salvar_senha,
				clear => limpa,
				Q => si(2));

	ffdS3: chinelode
	PORT MAP (	D => card_pass(3),
				Clk => salvar_senha,
				clear => limpa,
				Q => si(3));
				

	--observação
	limpa <= cancel or reset;
	clear <= cancel or reset;
	set <= ok;
	
	salvar_senha <= ok and senha_invalida;

END entry_panel;

