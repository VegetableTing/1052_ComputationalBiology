#Q3: 
#Make a hash of one letter amino acids codes (keys) to their molecular weight (values) using PERL. 
#Check that you have included tryptophan,and print out its weight. 
#Print out a list of all of the amino acids sorted bytheir molecular weights (heaviest to lightest). 
#Find the sequence for mouselysozyme protein and work out its molecular weight.
#https://www.ncbi.nlm.nih.gov/protein/AAA41551.1

my $molecularWeight = 0;
my $count;
my %hash;
my %aminoAcid = (
	"G" => 75.07,
	"A" => 89.09,
	"V" => 117.15,
	"L" => 131.17,
	"I" => 131.17,
	"F" => 165.19,
	"W" => 204.23,
	"Y" => 181.19,
	"D" => 133.10,
	"H" => 155.16,
	"N" => 132.12,
	"E" => 147.13,
	"K" => 146.19,
	"Q" => 146.15,
	"M" => 149.21,
	"R" => 174.20,
	"S" => 105.09,
	"T" => 119.12,
	"C" => 121.16,
	"P" => 115.13
);
print "Code\tMolecular weight\n";
foreach $key(sort{$aminoAcid{$b} <=> $aminoAcid{$a}} keys %aminoAcid)
{
	printf "%s\t%6.2f\n",$key,$aminoAcid{$key};
	$hash{$key} = 0;
}

while(<DATA>)
{
	if(/^>(\S*)\ (\S*)/)
	{
		print "\n>$2's molecular weight : ";
	}else
	{
		while(/(.)/g)
		{
			$molecularWeight += $aminoAcid{$1};
			$hash{$1}++;
			$count++;
		}	
	}
}
print "$molecularWeight\t\tTotal : $count\n";
print "Code\tCount\tRate\t\n";
foreach $key(sort{$hash{$b} <=> $hash{$a}} keys %hash)
{
	printf "%s\t%2s\t%3.1f%\n",$key,$hash{$key},$hash{$key}/$count*100;
}
print "";

__DATA__
>AAA41551.1 lysozyme [Rattus norvegicus]
MKALLVLGFLLLSASVQAKIYERCQFARTLKRNGMSGYYGVSLADWVCLAQHESNYNTQARNYNPGDQST
DYGIFQINSRYWCNDGKTPRAKNACGIPCSALLQDDITQAIQCAKRVVRDPQGIRAWVAWQRHCKNRDLS
GYIRNCGV