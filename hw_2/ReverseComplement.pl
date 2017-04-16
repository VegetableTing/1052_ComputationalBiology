#Given a FASTA file,write a PERL program that outputs the reverse compliment of the string.
#>> perl ReverseComplement.pl example1.fa
#CGATAATTTCCTCACTATTATCGGAATAAAGCGGATAAGGGCACAGGTGACAGCGAACACTAATATATTAGCACGGACCTCATCTTTGGAGCGCTCCTCAATTCTAATCGGCTCAATGGACAGTGTGCGAAACAT

my $output = "";
open FASTA, "< $ARGV[0]";

while( <FASTA>)
{
	if( $_ !~ /^>/ ) # not first line
	{
		$_ = scalar reverse $_; # reverse

		while( /(.)/g ) # replace
		{
			if( $1 eq "A" ) { $output .= "T"; }
			elsif( $1 eq "T" ) { $output .= "A"; }
			elsif( $1 eq "C" ) { $output .= "G"; }
			elsif( $1 eq "G" ) { $output .= "C"; }
		}
	}
} 

close FASTA;

print $output;