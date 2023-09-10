LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Datapath IS
END Datapath;
 
ARCHITECTURE behavior OF Datapath IS
 
-- Component Declaration for the Unit Under Test (UUT)
 
COMPONENT MultiplierDatapath
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
END COMPONENT;
 
--Inputs
signal A : std_logic_vector(3 downto 0) := (others => '0');
signal B : std_logic_vector(3 downto 0) := (others => '0');
--Outputs
signal S: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal RegA: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal RegB: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal RegS: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
--Controls
signal loadInput: STD_LOGIC;
signal loadOutput: STD_LOGIC;
signal clk: STD_LOGIC;

BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: MultiplierDatapath PORT MAP (
A => A,
B => B,
S => S,
A_register => RegA,
B_register => RegB,
S_register => RegS,
loadInput => loadInput,
loadOutput => loadOutput,
clk => clk
);
 
clk_proc: process
begin
clk <= '0';
wait for 5ns;
clk <= '1';
wait for 5ns;
end process;

load_proc: process
begin
loadInput <= '1';
wait for 10ns;
loadInput <= '0';
wait for 10ns;
end process;

out_proc: process
begin
loadOutput <= '0';
wait for 10ns;
loadOutput <= '1';
wait for 10ns;
end process;

sim_proc: process
begin

A <= "0110";
B <= "1100";

wait for 20 ns;

A <= "0010";
B <= "0001";

wait for 20 ns;

A <= "0111";
B <= "0101";
 
wait for 20 ns;

A <= "0100";
B <= "1101";
 
wait for 20 ns;

A <= "1010";
B <= "1110";
 
wait for 20 ns;
A <= "1011";
B <= "1011";
 
wait for 20 ns;

wait;
 
end process;
 
END;
