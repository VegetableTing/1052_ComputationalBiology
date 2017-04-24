#Given a FASTA file,write a PERL program that outputs the reverse compliment of the string.
#>> perl ReverseComplement.pl example1.fa
#CGATAATTTCCTCACTATTATCGGAATAAAGCGGATAAGGGCACAGGTGACAGCGAACACTAATATATTAGCACGGACCTCATCTTTGGAGCGCTCCTCAATTCTAATCGGCTCAATGGACAGTGTGCGAAACAT

sub ReverseComplement
{
	my $output = "";
	for( @_ )
	{
		if( $_ !~ /^>/ ) # not first line
		{
			while( /(.)/g ) # replace
			{
				$_ =~ tr/ATCG/TAGC/;
				chomp $_;
				$output = $_; 
			}
		}
	}
	return scalar reverse $output;
}


open FASTA, "< $ARGV[0]";
print ReverseComplement(<FASTA>);
close FASTA;


