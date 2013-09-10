VHDL CSV File Reader
====================

VHDL package for reading formatted data from comma-separated-values (CSV) files.

This code is in public domain. It comes with absolutely no warranty. On the
other hand, you can do with it whathever you like.

Usage example:

1. Create a csv_file_reader: `variable csv: csv_file_reader_type;`
2. Open a csv file: `csv.initialize("c:\file.csv");`
3. Read one line at a time: `csv.readline;`
4. Start reading values: `my_integer := csv.read_integer;`
5. To read more values in the same line, call any of the read_* functions
6. To move to the next line, call csv.readline() again

See a more complete example below or in the included testbench:

    procedure read_test_files is
        variable csv_file_1: csv_file_reader_type;
        variable csv_file_2: csv_file_reader_type;
        variable read_string: string(1 to 256);
        variable read_integer: integer;
        variable read_boolean: boolean;
        variable read_real: real;
    begin
        puts("opening CSV files");
        csv_file_1.initialize("c:\intel\projects\fpga\decision_tree_nsl_kdd\vhdl\testbench\data\test_file_1.csv");
        csv_file_2.initialize("c:\intel\projects\fpga\decision_tree_nsl_kdd\vhdl\testbench\data\test_file_2.csv");

        puts("testing 1st line of the csv file: 1,abc,true,0.5,0110");
        csv_file_1.readline;
        read_integer := csv_file_1.read_integer;
        read_string := csv_file_1.read_string;
        read_boolean := csv_file_1.read_boolean;
        read_real := csv_file_1.read_real;
        assert_that("integer value read is 1", read_integer = 1);
        assert_that("string value read is 'abc'", read_string(1 to 3) = "abc");
        assert_that("boolean value read is 'true'", read_boolean = true);
        assert_that("real value read is 0.5", read_real = 0.5);
        assert_that("end of file was not reached", csv_file_1.end_of_file = false);

        puts("testing 1st line of the 2nd csv file: 3,def,false,-0.5,0110");
        csv_file_2.readline;
        read_integer := csv_file_2.read_integer;
        read_string := csv_file_2.read_string;
        read_boolean := csv_file_2.read_boolean;
        read_real := csv_file_2.read_real;
        assert_that("integer value read is 3", read_integer = 3);
        assert_that("string value read is 'def'", read_string(1 to 3) = "def");
        assert_that("boolean value read is 'false'", read_boolean = false);
        assert_that("real value read is -0.5", read_real = -0.5);
        assert_that("end of file was not reached", csv_file_1.end_of_file = false);

        puts("testing 2nd line of the csv file: 2,xyz,false,-1.0,0000");
        csv_file_1.readline;
        read_integer := csv_file_1.read_integer;
        read_string := csv_file_1.read_string;
        read_boolean := csv_file_1.read_boolean;
        read_real := csv_file_1.read_real;
        assert_that("integer value read is 2", read_integer = 2);
        assert_that("string value read is 'xyz'", read_string(1 to 3) = "xyz");
        assert_that("boolean value read is 'false'", read_boolean = false);
        assert_that("real value read is -1.0", read_real = -1.0);
        assert_that("end of file was reached", csv_file_1.end_of_file = true);
    end;