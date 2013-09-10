use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Package with a series of routines useful when writing testbenches. Includes
-- formatted print output and assertions.
package testbench_utils is
  procedure puts(text: string);
  procedure puts(value: integer);
  procedure puts(value: real);
  procedure puts(value: boolean);
  procedure puts(str: string; val: integer);
  procedure puts(str1: string; val1: integer; str2: string; val2: integer);
  procedure puts(str: string; val: real);
  procedure puts(str: string; val: bit);
  procedure puts(str: string; val: boolean);
  procedure puts(str: string; val: string);
  procedure print_unsigned(value: unsigned; tag: string := "");
  procedure print_std_logic_vector(vector: std_logic_vector; tag: string := "");
  procedure print_bit_vector(vector: bit_vector; tag: string := "");
  procedure describe(function_name: string);
  procedure should(msg: string; expr: boolean);
  procedure assert_that(msg: string; expr: boolean);
  procedure assert_that(msg: string; sig: bit);
  procedure assert_that(expr: boolean);
  procedure done;
  procedure delta_cycle;
  procedure wait_tests_finished;
end package testbench_utils;

package body testbench_utils is

  procedure puts(text: string) is
    variable s: line;
  begin
    write(s, text);
    writeline(output,s);
  end procedure;

  procedure puts(value: integer) is
    variable text: line;
  begin
    write(text, value);
    writeline(output, text);
  end procedure;

  procedure puts(value: real) is
    variable text: line;
  begin
    write(text, value);
    writeline(output, text);
  end procedure;

  procedure puts(value: boolean) is
    variable text: line;
  begin
    write(text, value);
    writeline(output, text);
  end procedure;

  procedure puts(str: string; val: integer) is
    variable l: line;
  begin
    write(l, str);
    write(l, val);
    writeline(output, l);
  end procedure;

  procedure puts(str1: string; val1: integer; str2: string; val2: integer) is begin
    puts(str1 & integer'image(val1) & str2 & integer'image(val2));
  end;

  procedure puts(str: string; val: real) is
    variable l: line;
  begin
    write(l, str);
    write(l, val);
    writeline(output, l);
  end procedure;

  procedure puts(str: string; val: bit) is
    variable l: line;
  begin
    write(l, str);
    write(l, val);
    writeline(output, l);
  end procedure;

  procedure puts(str: string; val: boolean) is
    variable l: line;
  begin
    write(l, str);
    write(l, val);
    writeline(output, l);
  end procedure;

  procedure puts(str: string; val: string) is
    variable l: line;
  begin
    write(l, str);
    write(l, val);
    writeline(output, l);
  end procedure;

  procedure prepend_tag(tag: string; variable text: inout line) is begin
    if tag /= "" then
      write(text, tag & " ");
    end if;
  end procedure;

  procedure print_std_logic_vector(vector: std_logic_vector; tag: string := "") is
    variable text: line;
    variable char: character;
  begin
    prepend_tag(tag, text);
    for i in vector'range loop
      if vector(i) = '0' then
        char := '0';
      elsif vector(i) = '1' then
        char := '1';
      else
        char := '?';
      end if;
      write(text, char);
    end loop;
    writeline(output, text);
  end procedure;

  procedure print_bit_vector(vector: bit_vector; tag: string := "") is
    variable text: line;
  begin
    prepend_tag(tag, text);
    for i in vector'range loop
      write(text, vector(i));
    end loop;
    writeline(output, text);
  end procedure;

  procedure print_unsigned(value: unsigned; tag: string := "") is begin
    print_std_logic_vector(std_logic_vector(value), tag);
  end procedure;

  procedure describe(function_name: string) is begin
    puts("Function " & function_name & " should:");
  end procedure;

  procedure should(msg: string; expr: boolean) is begin
    assert expr report "error in test case '" & msg & "'" severity failure;
    puts("- " & msg);
  end procedure;

  procedure assert_that(msg: string; sig: bit) is begin
    should(msg, sig = '1');
  end procedure;

  procedure assert_that(msg: string; expr: boolean) is begin
    should(msg, expr);
  end procedure;

  procedure assert_that(expr: boolean) is begin
    assert expr severity failure;
  end procedure;

  procedure delta_cycle is begin
    wait for 0 ns;
  end procedure;

  procedure done is begin
    wait;
  end procedure;

  procedure wait_tests_finished is begin
    wait for 10 ns;
    puts("All tests ran ok.");
    wait;
  end procedure;

end package body testbench_utils;
