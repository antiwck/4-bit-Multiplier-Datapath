-------------------------------------------------------
-- Half adder

library ieee;
use ieee.std_logic_1164.all;
 
entity HalfAdder is
  port (
    A  : in std_logic;
    B  : in std_logic;
    Cout   : out std_logic;
    S : out std_logic
    );
end HalfAdder;
 
architecture Behavioral of HalfAdder is
begin
  S   <= A xor B;
  Cout <= A and B;
end Behavioral;

-------------------------------------------------------
-- Full adder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity FullAdder is
 Port ( 
 A : in STD_LOGIC;
 B : in STD_LOGIC;
 Cin : in STD_LOGIC;
 Cout : out STD_LOGIC;
 S : out STD_LOGIC
 );
end FullAdder;
 
architecture Behavioral of FullAdder is
 
begin
 
 S <= A XOR B XOR Cin ;
 Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B) ;
 
end Behavioral;

------------------------------------------------------------------------------------
-- 4-bit register
LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY FourBitRegister IS 
	Port (
        load     : in  std_logic;		  
        data_in  : in STD_LOGIC_VECTOR(3 downto 0);
        data_out : out STD_LOGIC_VECTOR(3 downto 0)
    ); 
END FourBitRegister;

architecture Behavioral of FourBitRegister is

signal reg_data : STD_LOGIC_VECTOR(3 downto 0);

begin
	process(load)
	begin
		if load = '1' then
			reg_data <= data_in;

		end if;
    end process;
	 
	 data_out  <= reg_data;
end Behavioral;

------------------------------------------------------------------------------------
-- 8-bit register
LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY EightBitRegister IS 
	Port (
        load     : in  std_logic;		  
        data_in  : in STD_LOGIC_VECTOR(7 downto 0);
        data_out : out STD_LOGIC_VECTOR(7 downto 0)
    ); 
END EightBitRegister;

architecture Behavioral of EightBitRegister is

signal reg_data : STD_LOGIC_VECTOR(7 downto 0);

begin
	process(load)
	begin
		if load = '1' then
			reg_data <= data_in;

		end if;
    end process;
	 
	 data_out  <= reg_data;
end Behavioral;

-------------------------------------------------------
-- 4-bit multiplier

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MultiplierDatapath is
 port (  
	A: in STD_LOGIC_VECTOR (3 downto 0);
	B: in STD_LOGIC_VECTOR (3 downto 0);
	S: out STD_LOGIC_VECTOR (7 downto 0);
	A_register: out STD_LOGIC_VECTOR (3 downto 0);
	B_register: out STD_LOGIC_VECTOR (3 downto 0);
	S_register: out STD_LOGIC_VECTOR (7 downto 0);
	loadInput: in STD_LOGIC;
	loadOutput: in STD_LOGIC;
	clk: in STD_LOGIC
);
end MultiplierDatapath;
 
architecture Behavioral of MultiplierDatapath is
 
-- Full Adder 1bit Component Decalaration
component FullAdder
 port ( 
	A,B: in STD_LOGIC;
	Cin: in STD_LOGIC;
	Cout: out STD_LOGIC;
	S: out STD_LOGIC
);
end component;

-- Half Adder 1bit Component Declaration
component HalfAdder
 port (
	A,B: in STD_LOGIC;
	Cout: out STD_LOGIC;
	S: out STD_LOGIC
);
end component;

-- Register 4bit Component Declaration
component FourBitRegister IS 
	Port (
        load     : in  std_logic;		  
        data_in  : in STD_LOGIC_VECTOR(3 downto 0);
        data_out : out STD_LOGIC_VECTOR(3 downto 0)
    ); 
END component;

-- Register 8bit Component Declaration
component EightBitRegister IS 
	Port (
        load     : in  std_logic;		  
        data_in  : in STD_LOGIC_VECTOR(7 downto 0);
        data_out : out STD_LOGIC_VECTOR(7 downto 0)
    ); 
END component;

-- Intermediate declaration
signal AB0, AB1, AB2, AB3: STD_LOGIC_VECTOR (3 downto 0);
signal C1, C2, C3: STD_LOGIC_VECTOR (3 downto 0);
signal P1, P2, P3: STD_LOGIC_VECTOR (3 downto 0);

-- Register intermediate declaration
signal A_reg: STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal B_reg: STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal S_reg: STD_LOGIC_VECTOR (7 downto 0) := "00000000";

begin
	-- Assign intermediates with appropriate control signals
	process(clk)
	begin
		if rising_edge(clk) then
			if loadInput = '1' then
				A_register <= A_reg;
				B_register <= B_reg;
			end if;
			if loadOutput ='1' then
				S <= S_reg;
			end if;
		end if;
	end process;
	
	-- Port Mapping Register 
	RegB : FourBitRegister port map(loadInput, B, B_reg);
	RegA : FourBitRegister port map(loadInput, A, A_reg);
	RegS : EightBitRegister port map(loadOutput, S_reg, S_register);
	
	-- Multiplier input
	AB0(0) <= A_reg(0) and B_reg(0);
	AB0(1) <= A_reg(1) and B_reg(0);
	AB0(2) <= A_reg(2) and B_reg(0);
	AB0(3) <= A_reg(3) and B_reg(0);

	AB1(0) <= A_reg(0) and B_reg(1);
	AB1(1) <= A_reg(1) and B_reg(1);
	AB1(2) <= A_reg(2) and B_reg(1);
	AB1(3) <= A_reg(3) and B_reg(1);

	AB2(0) <= A_reg(0) and B_reg(2);
	AB2(1) <= A_reg(1) and B_reg(2);
	AB2(2) <= A_reg(2) and B_reg(2);
	AB2(3) <= A_reg(3) and B_reg(2);

	AB3(0) <= A_reg(0) and B_reg(3);
	AB3(1) <= A_reg(1) and B_reg(3);
	AB3(2) <= A_reg(2) and B_reg(3);
	AB3(3) <= A_reg(3) and B_reg(3);

	-- Port Mapping Full Adder 8 times and Half Adder 4 times
	FA1: FullAdder port map( AB0(2), AB1(1), C1(0), C1(1), P1(1));
	FA2: FullAdder port map( AB0(3), AB1(2), C1(1), C1(2), P1(2));
	FA3: FullAdder port map( P1(2), AB2(1), C2(0), C2(1), P2(1));
	FA4: FullAdder port map( P1(3), AB2(2), C2(1), C2(2), P2(2));
	FA5: FullAdder port map( C1(3), AB2(3), C2(2), C2(3), P2(3));
	FA6: FullAdder port map( P2(2), AB3(1), C3(0), C3(1), P3(1));
	FA7: FullAdder port map( P2(3), AB3(2), C3(1), C3(2), P3(2));
	FA8: FullAdder port map( C2(3), AB3(3), C3(2), C3(3), P3(3));
	HA1: HalfAdder port map( AB0(1), AB1(0), C1(0), P1(0));
	HA2: HalfAdder port map( AB1(3), C1(2), C1(3), P1(3));
	HA3: HalfAdder port map( P1(1), AB2(0), C2(0), P2(0));
	HA4: HalfAdder port map( P2(1), AB3(0), C3(0), P3(0));

	-- Mulitplier output
	S_reg(0)<= AB0(0);
	S_reg(1)<= P1(0);
	S_reg(2)<= P2(0);
	S_reg(3)<= P3(0);
	S_reg(4)<= P3(1);
	S_reg(5)<= P3(2);
	S_reg(6)<= P3(3);
	S_reg(7)<= C3(3);
	
end Behavioral;
