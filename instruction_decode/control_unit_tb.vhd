library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity;

architecture a_control_unit_tb of control_unit_tb is
    component control_unit
        port(
            overflow: in std_logic;
            negative: in std_logic;
            zero: in std_logic;
            opcode: in unsigned(3 downto 0);
            jump_en: out std_logic;
            immediate_id: in std_logic;
            reg_write: out std_logic;
            alu_src: out std_logic;
            mem_write: out std_logic;
            mem_to_reg: out std_logic;
            alu_op: out std_logic
        );
    end component;

    

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal  jump_en, reg_write, alu_src, overflow, negative, immediate_id,mem_to_reg, zero,alu_op: std_logic := '0';
    signal opcode: unsigned(3 downto 0) := "0000";

    begin
        uut: control_unit port map(
            overflow => overflow,
            negative => negative,
            zero => zero,
            opcode => opcode,
            immediate_id => immediate_id,
            jump_en => jump_en,
            alu_src => alu_src,
            reg_write => reg_write,
            mem_to_reg => mem_to_reg,
            alu_op => alu_op
        );


    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process;

    process
    begin
        -- Testando jump
        immediate_id <= '0';
        negative <= '0';
        overflow <= '0';
        opcode <= "1111";
        wait for period_time/2;

        -- Testando alusrc para todos os estados
        immediate_id <= '0';
        opcode <= "0110";
        wait for period_time/2;
        immediate_id <= '1';
        opcode <= "0101";
        wait for period_time/2;

        -- Testando Branch
        negative <= '0';
        overflow <= '1';
        opcode <= "1110";
        wait for period_time/2;
        negative <= '0';
        overflow <= '0';
        opcode <= "1110";
        wait for period_time/2;
        negative <= '1';
        overflow <= '1';
        opcode <= "1110";
        wait for period_time/2;

        -- Testando Ram
        opcode <= "0111";
        wait for period_time;
        opcode <= "0110";
        wait for period_time;
        
        -- mem_to_reg
        opcode <= "0111";
        wait for period_time;
        opcode <= "0110";
        wait for period_time;
        opcode <= "0001";
        wait for period_time;
        wait;
    end process;
end architecture;