VHDL CSV File Reader
====================

VHDL package for reading formatted data from comma-separated-values (CSV) files.

Usage example:

1. Create a csv_file_reader:
    variable csv: csv_file_reader_type;
2. Open a csv file:
    csv.initialize("c:\file.csv");
3. Read one line at a time:
    csv.readline;
4. Start reading values:
    my_integer := csv.read_integer;
5. To read more values in the same line, call any of the read_* functions
6. To move to the next line, call csv.readline() again
