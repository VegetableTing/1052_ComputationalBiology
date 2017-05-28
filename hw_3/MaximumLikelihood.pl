#Problem A. Inferring parameters when I tell you the die type.
#> perl MaximumLikelihood.pl counts1.txt

@countA,@countB;

open IN, "< @ARGV[0]";

sub MH
{
	for(@_)
	{
		$_ =~ /([\w])[\s]+([1-6]+)/;
		
		my $type = $1;
		my $roll = $2;
		
		while( $roll =~ /([1-6])/g)
		{
			if($type eq "A"){ 
				$countA[0] ++; 
				$countA[$1] ++;
			}
			elsif($type eq "B"){
				$countB[0] ++;
				$countB[$1] ++;
			}

		}
	}
}
sub showCount
{
	open OUT, "> params1.txt";

	for(my $i = 1, printf OUT "%.2f",$countA[0]/($countA[0]+$countB[0]); $i < 7; $i++)
	{
		printf OUT "\t%.4f",$countA[$i]/$countA[0];
	}
	for(my $i = 1, printf OUT "\n%.2f",$countB[0]/($countA[0]+$countB[0]); $i < 7; $i++)
	{
		printf OUT "\t%.4f",$countB[$i]/$countB[0];
	}

	close OUT;
}

##########################################################
MH(<IN>);
showCount();
close IN;


