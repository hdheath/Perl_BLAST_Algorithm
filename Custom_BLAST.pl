# Initialize variables
my %substrings;
my $i;
my $j;

# Extract substrings of length k from query and store in hash table
for ($i = 0; $i <= (length($query) - $k); $i++) {
    my $substring = substr($query, $i, $k);
    $substrings{$substring} = $i;
}

# Create a hash table to store significant sequences found
my %significant_sequences;

# Read DNA sequences from file and check for common substrings of length k
open(my $fh, '<', $file_path) or die "Could not open file '$file_path' $!";

my $paragraph_number = 1;
my $dna_sequence = '';

while (my $line = <$fh>) {
    chomp $line;
    if ($line eq '') {
        $paragraph_number++;
        $dna_sequence = '';
        next;
    }
    $dna_sequence .= $line;

    # Check for common substrings of length k in dna_sequence
    foreach my $substring (keys %substrings) {
        if ($dna_sequence =~ /$substring/) {
            # Extract location of the common substring in dna_sequence
            my $index = index($dna_sequence, $substring);

            # Count matching characters to the left of the common substring
            my $query_start = $substrings{$substring};
            my $dna_start = $index;
            my $left_count = 0;
            while ($query_start > 0 && $dna_start > 0) {
                my $query_char = substr($query, $query_start - 1, 1);
                my $dna_char = substr($dna_sequence, $dna_start - 1, 1);
                if ($query_char eq $dna_char) {
                    $left_count++;
                    $query_start--;
                    $dna_start--;
                }
                else {
                    last;
                }
            }

            # Count matching characters to the right of the common substring
            my $query_end = $substrings{$substring} + $k;
            my $dna_end = $index + $k;
            my $right_count = 0;
            while ($query_end < length($query) && $dna_end < length($dna_sequence)) {
                my $query_char = substr($query, $query_end, 1);
                my $dna_char = substr($dna_sequence, $dna_end, 1);
                if ($query_char eq $dna_char) {
                    $right_count++;
                    $query_end++;
                    $dna_end++;
                }
                else {
                    last;
                }
            }
	    # Check if the match is significant (at least $threshold characters)
            my $match_length = $left_count + $right_count + $k;
            if ($match_length >= $threshold) {
                # Extract the significant sequence from the dna_sequence
            	my $significant_sequence = substr($dna_sequence, $index - $left_count, $match_length, $paragraph_number);


            	# Check if the significant sequence has already been recorded
            	if (!exists $significant_sequences{$significant_sequence}) {
                # Record the significant sequence
                push @{$significant_sequences{$significant_sequence}}, $paragraph_number;
                print "Significant sequence found in sequence $paragraph_number of file $file_path: $significant_sequence\n";
		}
            }
    	}
    }
}

# If no common substrings found, print message
print "No common sequence found\n" unless scalar keys %substrings;
