-- megafunction wizard: %LPM_DECODE%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: LPM_DECODE 

-- ============================================================
-- File Name: da.vhd
-- Megafunction Name(s):
-- 			LPM_DECODE
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 19.1.0 Build 670 09/22/2019 SJ Lite Edition
-- ************************************************************


--Copyright (C) 2019  Intel Corporation. All rights reserved.
--Your use of Intel Corporation's design tools, logic functions 
--and other software and tools, and any partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Intel Program License 
--Subscription Agreement, the Intel Quartus Prime License Agreement,
--the Intel FPGA IP License Agreement, or other applicable license
--agreement, including, without limitation, that your use is for
--the sole purpose of programming logic devices manufactured by
--Intel and sold by Intel or its authorized distributors.  Please
--refer to the applicable agreement for further details, at
--https://fpgasoftware.intel.com/eula.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

ENTITY da IS
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		eq11		: OUT STD_LOGIC ;
		eq4		: OUT STD_LOGIC 
	);
END da;


ARCHITECTURE SYN OF da IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC ;
	SIGNAL sub_wire2	: STD_LOGIC ;



	COMPONENT lpm_decode
	GENERIC (
		lpm_decodes		: NATURAL;
		lpm_type		: STRING;
		lpm_width		: NATURAL
	);
	PORT (
			data	: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			eq	: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	sub_wire2    <= sub_wire0(4);
	sub_wire1    <= sub_wire0(11);
	eq11    <= sub_wire1;
	eq4    <= sub_wire2;

	LPM_DECODE_component : LPM_DECODE
	GENERIC MAP (
		lpm_decodes => 2,
		lpm_type => "LPM_DECODE",
		lpm_width => 4
	)
	PORT MAP (
		data => data,
		eq => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: BaseDec NUMERIC "1"
-- Retrieval info: PRIVATE: EnableInput NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
-- Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
-- Retrieval info: PRIVATE: Latency NUMERIC "0"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: aclr NUMERIC "0"
-- Retrieval info: PRIVATE: clken NUMERIC "0"
-- Retrieval info: PRIVATE: eq0 NUMERIC "0"
-- Retrieval info: PRIVATE: eq1 NUMERIC "0"
-- Retrieval info: PRIVATE: eq10 NUMERIC "0"
-- Retrieval info: PRIVATE: eq11 NUMERIC "1"
-- Retrieval info: PRIVATE: eq12 NUMERIC "0"
-- Retrieval info: PRIVATE: eq13 NUMERIC "0"
-- Retrieval info: PRIVATE: eq14 NUMERIC "0"
-- Retrieval info: PRIVATE: eq15 NUMERIC "0"
-- Retrieval info: PRIVATE: eq2 NUMERIC "0"
-- Retrieval info: PRIVATE: eq3 NUMERIC "0"
-- Retrieval info: PRIVATE: eq4 NUMERIC "1"
-- Retrieval info: PRIVATE: eq5 NUMERIC "0"
-- Retrieval info: PRIVATE: eq6 NUMERIC "0"
-- Retrieval info: PRIVATE: eq7 NUMERIC "0"
-- Retrieval info: PRIVATE: eq8 NUMERIC "0"
-- Retrieval info: PRIVATE: eq9 NUMERIC "0"
-- Retrieval info: PRIVATE: nBit NUMERIC "4"
-- Retrieval info: PRIVATE: new_diagram STRING "1"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_DECODES NUMERIC "16"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_DECODE"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "4"
-- Retrieval info: USED_PORT: @eq 0 0 16 0 OUTPUT NODEFVAL "@eq[15..0]"
-- Retrieval info: USED_PORT: data 0 0 4 0 INPUT NODEFVAL "data[3..0]"
-- Retrieval info: USED_PORT: eq11 0 0 0 0 OUTPUT NODEFVAL "eq11"
-- Retrieval info: USED_PORT: eq4 0 0 0 0 OUTPUT NODEFVAL "eq4"
-- Retrieval info: CONNECT: @data 0 0 4 0 data 0 0 4 0
-- Retrieval info: CONNECT: eq11 0 0 0 0 @eq 0 0 1 11
-- Retrieval info: CONNECT: eq4 0 0 0 0 @eq 0 0 1 4
-- Retrieval info: GEN_FILE: TYPE_NORMAL da.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL da.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL da.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL da.bsf TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL da_inst.vhd FALSE
-- Retrieval info: LIB_FILE: lpm
