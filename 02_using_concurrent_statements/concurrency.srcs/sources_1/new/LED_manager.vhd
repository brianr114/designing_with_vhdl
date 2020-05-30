----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2020 10:31:03 AM
-- Design Name: 
-- Module Name: LED_manager - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LED_manager is
    Port ( ch_1_data    : in    STD_LOGIC_VECTOR (7 downto 0);
           ch_2_data    : in    STD_LOGIC_VECTOR (7 downto 0);
           ch_1_en      : in    STD_LOGIC;
           ch_2_en      : in    STD_LOGIC;
           selector     : in    STD_LOGIC;
           clk          : in    STD_LOGIC;
           reset        : in    STD_LOGIC;
           data_out     : out   STD_LOGIC_VECTOR (7 downto 0)
           );
end LED_manager;

architecture Behavioral of LED_manager is

    COMPONENT register8 is
        Port ( clock    : in STD_LOGIC;
               reset    : in STD_LOGIC;
               enable   : in STD_LOGIC;
               data_in  : in STD_LOGIC_VECTOR (7 downto 0);
               data_out : out STD_LOGIC_VECTOR (7 downto 0));
    end COMPONENT;
    
    signal ch_1_registered_data : std_logic_vector(7 downto 0);
    signal ch_2_registered_data : std_logic_vector(7 downto 0);
    signal mux_data_selected    : std_logic_vector(7 downto 0);
    
begin

    reg_ch_1 : register8 port map (clock => clk,
                                   reset => reset,
                                   enable => ch_1_en,
                                   data_in => ch_1_data,
                                   data_out => ch_1_registered_data); 

    reg_ch_2 : register8 port map (clock => clk,
                               reset => reset,
                               enable => ch_2_en,
                               data_in => ch_2_data,
                               data_out => ch_2_registered_data); 
    
    -- mux implementation
    with selector select
        mux_data_selected <= ch_1_registered_data when '0',
                             ch_2_registered_data when '1',
                             (others => '-') when others;  
                             
    -- register output
    data_out <= mux_data_selected when rising_edge (clk);
    
end Behavioral;
