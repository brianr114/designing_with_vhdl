----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2020 11:12:46 AM
-- Design Name: 
-- Module Name: LED_manager_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LED_manager_tb is
--  Port ( );
end LED_manager_tb;

architecture Behavioral of LED_manager_tb is

    COMPONENT LED_manager
        PORT(
            ch_1_data   : IN    std_logic_vector(7 downto 0);
            ch_2_data   : IN    std_logic_vector(7 downto 0);
            ch_1_en     : IN    std_logic;
            ch_2_en     : IN    std_logic;
            selector    : IN    std_logic;
            clk         : IN    std_logic;
            reset       : IN    std_logic;
            data_out    : OUT   std_logic_vector(7 downto 0)
            );
          END COMPONENT;
          
    -- Inputs
    signal ch_1_data    : std_logic_vector(7 downto 0) := (others => '0');
    signal ch_2_data    : std_logic_vector(7 downto 0) := (others => '0');
    signal ch_1_en      : std_logic := '0';
    signal ch_2_en      : std_logic := '0';
    signal selector     : std_logic := '0';
    signal clk          : std_logic := '0';
    signal reset        : std_logic := '0';

    -- Outputs
    signal data_out     : std_logic_vector(7 downto 0);  
    
    -- Clock source
    constant clk_period : time := 10 ns;
    
begin

    uut: LED_manager PORT MAP (
                ch_1_data   => ch_1_data,
                ch_2_data   => ch_2_data,
                ch_1_en     => ch_1_en,
                ch_2_en     => ch_2_en,
                selector    => selector,
                clk         => clk,
                reset       => reset,
                data_out    => data_out
            );

    -- Reset
    reset <= '1', '0' after clk_period * 10;
    
    -- Clock generation
    clk <= not clk after 5 ns;
    
    -- Selector
    selector <= '0', '1' after clk_period * 20, '0' after clk_period * 50, '1' after clk_period * 100;
    
    -- Data generation
    ch_1_data <= ch_1_data + X"03" after clk_period * 2;
    ch_2_data <= ch_2_data + X"04" after clk_period * 3;
    ch_1_en <= '1';
    ch_2_en <= '1';
    
end Behavioral;
