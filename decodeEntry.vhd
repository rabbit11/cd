LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY decodeEntry is

PORT(   button          : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        
        buttonExtended  : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));

END decodeEntry;

ARCHITECTURE decoding OF decodeEntry IS
BEGIN
    WITH button SELECT
    buttonExtended <=       "0001" WHEN "00",
                            "0010" WHEN "01",
                            "0100" WHEN "10",
                            "1000" WHEN "11",
                            "0000" WHEN OTHERS;

END decoding;