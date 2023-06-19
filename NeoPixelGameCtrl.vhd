-- SCOMP peripheral that gets button input

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NeoPixelGameCtrl is 

	port (
		resetn   		: in std_logic ;
		io_write 		: in std_logic ;
		cs       		: in std_logic ;
		upbutton			: in std_logic;
		downbutton		: in std_logic;
		data				: out std_logic_vector(15 downto 0);
		
		-- clock input
		clk_10MHz  : in    std_logic
	);

end entity;

architecture internals of NeoPixelGameCtrl is

	Type state_type is (
		idle,
		up,
		down
	);

	signal state				: state_type;
	signal btn_state			: std_logic_vector(1 DOWNTO 0);
	signal direction			: std_logic_vector(15 downto 0);
	
begin

	data <= "ZZZZZZZZZZZZZZZZ" when (cs='0' or io_write='1') else direction;
	
	process (resetn, io_write, cs, upbutton, downbutton)
	begin
	
		if (resetn = '0' OR (io_write and cs) = '1') then		-- if we hit reset or write to the peripheral
			state <= idle;
			direction <= x"0000";
			
		else
			case btn_state is
				when "10" =>
					state <= up;
					direction <= x"0001";
				when "01" =>
					state <= down;
					direction <= x"1111";
				when others =>
					state <= idle;
					direction <= x"0000";
			end case;
		end if;
	end process;

	btn_state <= upbutton & downbutton;
	
end internals;