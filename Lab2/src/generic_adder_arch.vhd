-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder [arch]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_adder_arch is
  generic (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
  );
end entity generic_adder_arch;

architecture arch of generic_adder_arch is
	
component full_adder
	port(
	signal a 	: in std_logic;
	signal b 	: in std_logic;
	signal cin	: in std_logic;
	signal sum	: out std_logic;
	signal cout	: out std_logic
	);
end component;

signal c : std_logic_vector(bits downto 0);

begin

	-- First adder (LSB)
    FA0: full_adder
        port map (
            a    => a(0),
            b    => b(0),
            cin  => cin,
            sum  => sum(0),
            cout => c(0)
        );

    -- Second adder
    FA1: full_adder
        port map (
            a    => a(1),
            b    => b(1),
            cin  => c(0),
            sum  => sum(1),
            cout => c(1)
        );

    -- Third adder
    FA2: full_adder
        port map (
            a    => a(2),
            b    => b(2),
            cin  => c(1),
            sum  => sum(2),
            cout => c(2)
        );

    -- Fourth adder (MSB)
    FA3: full_adder
        port map (
            a    => a(3),
            b    => b(3),
            cin  => c(2),
            sum  => sum(3),
            cout => cout
        );
	--c(0) <= cin;
	
	--FA0 : full_adder port map(a(0), b(0), cin(0), sum(0), c(1)); 
	--FA1 : full_adder port map(a(1), b(1), cin(1), sum(1), c(2));
	--FA2 : full_adder port map(a(2), b(2), cin(2), sum(2), c(3));
	--FA3 : full_adder port map(a(3), b(3), cin(3), sum(3), c(4));
	
	--cout <= c(4)
end arch;