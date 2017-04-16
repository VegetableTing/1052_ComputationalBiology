#Write a PERL program that takes in a seriesof words from the command line and outputs the number of letters and the average length of a word.
#>> perl Letters.pl . # %
#Letters: 0
#Average Length: 1.00
#>> perl Letters.pl There once was a man from Nantupket
#Letters: 29
#Average Length: 4.14

my $letters = 0; #[0-9a-zA-Z]
my $total = 0; #All letters's length

foreach my $key (keys @ARGV)
{
	$letters += $ARGV[$key] =~ s/([\w])/$1/g;
	$total += length $ARGV[$key];
	#用RE算長度
	#$total += $ARGV[$key] =~ s/(.)/$1/g;
}

print "Letters : $letters\n";
printf "Average Length:  : %.2f", $total / scalar @ARGV;
