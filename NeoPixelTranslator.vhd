-- SCOMP peripheral that converts 2D coordinate to 1D representation.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NeoPixelTranslator is
	
	port(
		-- peripheral inputs
		resetn   : in std_logic;
		io_write : in std_logic;
		
		-- register inputs
		cs_x		: in std_logic;
		cs_y		: in std_logic;
		cs_xy		: in std_logic;
		cs_rows 	: in std_logic;
		cs_cols	: in std_logic;
		cs_num	: in std_logic;
		cs_clear : in std_logic;
		
		-- clock input
		clk_10M  : in    std_logic;
		
		-- data input/output
		data     : inout std_logic_vector(15 downto 0)
	); 

end entity;

architecture internals of NeoPixelTranslator is

	-- Internal registers to calculate the 0-255 coordinate,
	-- SCOMP will read the result from neopixel_coordinate with IN.
	
	signal x_coordinate						: std_logic_vector(7 downto 0);
	signal y_coordinate						: std_logic_vector(7 downto 0);
	signal internalregister					: std_logic_vector(15 downto 0);
	signal neopixel_coordinate				: std_logic_vector(15 downto 0);
	
	-- Variables for the rows and columns input (our example is 6x32 which is default)
	signal num_rows							: std_logic_Vector(7 downto 0) := x"06";
	signal num_cols							: std_logic_vector(7 downto 0) := x"20";
	
	-- define the states for the peripheral
	type state_type is (idle, storeX, storeY, storeCols, storeRows, calculate);
	signal state : state_type;
	
	
begin

	-- Create read functionality.
	-- ONLY drive the bus when SCOMP is reading.
	
	process (io_write, cs_x, cs_y, cs_rows, cs_cols, cs_num)
	begin
		if io_write = '0' then
			if 	cs_x = '1' then data <= x"0000" OR x_coordinate;
			elsif cs_y = '1' then data <= x"0000" OR y_coordinate;
			elsif cs_rows = '1' then data <= x"0000" OR num_rows;
			elsif cs_cols = '1' then data <= x"0000" OR num_cols;
			elsif cs_num  = '1' then data <= neopixel_coordinate;
			end if;
		else
			data <= "ZZZZZZZZZZZZZZZZ";
		end if;
	end process;
		
	process (clk_10M, resetn, cs_clear, io_write)
	begin
		if (resetn = '0' OR (cs_clear and io_write) = '1') then	-- reset registers
		
			x_coordinate			<= x"00";
			x_coordinate			<= x"00";
			neopixel_coordinate	<= x"0000";
			num_rows 				<= x"06";
			num_cols 				<= x"20";
			state 					<= idle;
		
		elsif (rising_edge(clk_10M)) then
		
				case state is
					when idle => -- what to do when SCOMP sends a value
						if (io_write = '1') and (cs_x = '1') then
							internalregister <= data(15 downto 0);
							state <= storeX;
							
						elsif (io_write = '1') and (cs_y = '1') then
							internalregister <= data(15 downto 0);
							state <= storeY;
							
						elsif (io_write = '1') and (cs_xy = '1') then
							x_coordinate <= x"00" OR data(7 downto 3);
							y_coordinate <= x"00" OR data(2 downto 0);
							state <= calculate;
							
						elsif (io_write = '1') and (cs_rows = '1') then
							internalregister <= data(15 downto 0);
							state <= storeRows;
							
						elsif (io_write = '1') and (cs_cols = '1') then
							internalregister <= data(15 downto 0);
							state <= storeCols;
						end if;

					when storeX =>
						x_coordinate <= internalregister(7 downto 0);
						state <= calculate;
					
					when storeY =>
						y_coordinate <= internalregister(7 downto 0);
						state <= calculate;
						
					when storeRows =>
						num_rows <= internalregister(7 downto 0);
						state <= calculate;
						
					when storeCols =>
						num_cols <= internalregister(7 downto 0);
						state <= calculate;
					
					when calculate => -- calculate the NEOPIXEL 1D coordinate
						if (unsigned(y_coordinate) mod 2) = 0 then
						-- even row
							neopixel_coordinate <=
								std_logic_vector((unsigned(num_cols) * unsigned(y_coordinate)) + unsigned(num_cols) - unsigned(x_coordinate) - 1);
						else 
						-- odd row
							neopixel_coordinate <=
								std_logic_vector((unsigned(num_cols) * unsigned(y_coordinate)) + unsigned(x_coordinate));
						end if;
						state <= idle;
						
					when others =>
						state <= idle;		
				end case;
		end if;
	end process;
	
end internals;