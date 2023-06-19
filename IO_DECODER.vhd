-- IO DECODER for SCOMP
-- This eliminates the need for a lot of AND decoders or Comparators 
--    that would otherwise be spread around the top-level BDF

LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY IO_DECODER IS

  PORT
  (
    IO_ADDR       : IN STD_LOGIC_VECTOR(10 downto 0);
    IO_CYCLE      : IN STD_LOGIC;
    SWITCH_EN     : OUT STD_LOGIC;
    LED_EN        : OUT STD_LOGIC;
    TIMER_EN      : OUT STD_LOGIC;
    HEX0_EN       : OUT STD_LOGIC;
    HEX1_EN       : OUT STD_LOGIC;
    PXL_A_EN      : OUT STD_LOGIC;
    PXL_RGB_EN    : OUT STD_LOGIC;
    PXL_ALL_EN    : OUT STD_LOGIC;
    PXL_R_EN      : OUT STD_LOGIC;
    PXL_G_EN      : OUT STD_LOGIC;
    PXL_B_EN      : OUT STD_LOGIC;
	 
	 NEOP_X_EN		: OUT STD_LOGIC;
	 NEOP_Y_EN		: OUT STD_LOGIC;
	 NEOP_XY_EN		: OUT STD_LOGIC;
	 NEOP_ROW_EN	: OUT STD_LOGIC;
	 NEOP_COL_EN	: OUT STD_LOGIC;
	 NEOP_NUM_EN	: OUT STD_LOGIC;
	 NEOP_CLEAR_EN	: OUT STD_LOGIC;
	 
	 NEOP_CTRL_EN	: OUT STD_LOGIC
  );

END ENTITY;

ARCHITECTURE a OF IO_DECODER IS

  SIGNAL  ADDR_INT  : INTEGER RANGE 0 TO 2047;
  
begin

  ADDR_INT <= TO_INTEGER(UNSIGNED(IO_ADDR));
        
  SWITCH_EN    <= '1' WHEN (ADDR_INT = 16#000#) and (IO_CYCLE = '1') ELSE '0';
  LED_EN       <= '1' WHEN (ADDR_INT = 16#001#) and (IO_CYCLE = '1') ELSE '0';
  TIMER_EN     <= '1' WHEN (ADDR_INT = 16#002#) and (IO_CYCLE = '1') ELSE '0';
  HEX0_EN      <= '1' WHEN (ADDR_INT = 16#004#) and (IO_CYCLE = '1') ELSE '0';
  HEX1_EN      <= '1' WHEN (ADDR_INT = 16#005#) and (IO_CYCLE = '1') ELSE '0';
  PXL_A_EN     <= '1' WHEN (ADDR_INT = 16#0B0#) and (IO_CYCLE = '1') ELSE '0';
  PXL_RGB_EN   <= '1' WHEN (ADDR_INT = 16#0B1#) and (IO_CYCLE = '1') ELSE '0';
  PXL_ALL_EN   <= '1' WHEN (ADDR_INT = 16#0B2#) and (IO_CYCLE = '1') ELSE '0';
  PXL_R_EN     <= '1' WHEN (ADDR_INT = 16#0B3#) and (IO_CYCLE = '1') ELSE '0';
  PXL_G_EN     <= '1' WHEN (ADDR_INT = 16#0B4#) and (IO_CYCLE = '1') ELSE '0';
  PXL_B_EN     <= '1' WHEN (ADDR_INT = 16#0B5#) and (IO_CYCLE = '1') ELSE '0';
  
  NEOP_X_EN 	<= '1' WHEN (ADDR_INT = 16#0F1#) and (IO_CYCLE = '1') ELSE '0';
  NEOP_Y_EN 	<= '1' WHEN (ADDR_INT = 16#0F2#) and (IO_CYCLE = '1') ELSE '0';
  NEOP_XY_EN	<= '1' WHEN (ADDR_INT = 16#0F3#) and (IO_CYCLE = '1') ELSE '0';
  NEOP_ROW_EN 	<= '1' WHEN (ADDR_INT = 16#0F4#) and (IO_CYCLE = '1') ELSE '0';
  NEOP_COL_EN 	<= '1' WHEN (ADDR_INT = 16#0F5#) and (IO_CYCLE = '1') ELSE '0';
  NEOP_NUM_EN	<= '1' WHEN (ADDR_INT = 16#0F0#) and (IO_CYCLE = '1') ELSE '0';
  NEOP_CLEAR_EN <= '1' WHEN (ADDR_INT = 16#0F6#) and (IO_CYCLE = '1') ELSE '0';
  
  NEOP_CTRL_EN	<= '1' WHEN (ADDR_INT = 16#0F7#) and (IO_CYCLE = '1') ELSE '0';
      
END a;
