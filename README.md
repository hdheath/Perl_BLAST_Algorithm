# Perl BLAST-like Sequence Alignment Tool

## Overview
This Perl script is a rudimentary implementation of a BLAST-like algorithm for sequence alignment. It searches for significant sequences within a DNA sequence file that match a query sequence. It utilizes a hash table to store substrings of the query sequence and then scans a DNA sequence file for matching substrings. Matches are extended in both directions to find significant alignments.

## Prerequisites
- Perl 5
- Access to a Unix-like terminal or command prompt

No external Perl modules are required to run this script.

## Installation
No installation is necessary. Simply place the Perl script in a directory of your choice.

## Input Files
- A text file containing DNA sequences separated by blank lines.
- A query string within the script that is to be aligned with sequences from the file.

## Usage
To use the script, define the following variables at the beginning of the script:
- `$query`: The query DNA sequence.
- `$k`: The length of the substring to search within the query sequence.
- `$file_path`: The path to the file containing DNA sequences.
- `$threshold`: The minimum length of a match to be considered significant.

Here is an example of how to set these variables in the script:

```perl
my $query = 'ACGTGCTAGCT'; # Your query sequence
my $k = 4;                 # Length of substring
my $file_path = 'sequences.txt'; # Path to your DNA sequence file
my $threshold = 5;         # Minimum length of match to be considered significant
```

Then, execute the script from the command line:
```perl
perl script_name.pl
```
## Ouput 

The script will print to the console any significant sequence matches found within the sequence file, along with the number of the sequence in which they were found.

If no common substrings of length $k are found, it prints:
```perl
No common sequence found
```
Otherwise, it prints the significant sequence found and its location:
```perl
Significant sequence found in sequence [number] of file [file_path]: [significant_sequence]
```

## Notes 
- Ensure that the DNA sequences in the input file are formatted correctly.
- The script currently does not support multi-threading or large databases efficiently.

## Author 
Harrison Heath
