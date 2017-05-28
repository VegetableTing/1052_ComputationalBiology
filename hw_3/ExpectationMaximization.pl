require "BaysianProbability.pl";

@countA,@countB;
sub MH
{
	my $data = $_[0];
	
	for(my $i = 0; $i < 7; $i++)
	{
		$countA[$i] = 0;
		$countB[$i] = 0;
	}
	
	for(@_)
	{
		/([\w])[\s]+([1-6]+)/;
		
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
	
	my $A = $countA[0], $B = $countB[0];
	$countA[0] = $A / ($A + $B);
	$countB[0] = $B / ($A + $B);
	for(my $i = 1; $i < 7; $i++)
	{
		$countA[$i] = $countA[$i] / $A;
		$countB[$i] = $countB[$i] / $B;
	}

	
	my @temp;
	$temp[0] = join(" ",@countA);
	$temp[1] = join(" ",@countB);
	
	return @temp;
}


##########################################################

open PARAM, "< params3.txt";
open DATA, "< counts3.txt";
open RESULT, "> result.txt";
my @data;
my @param; 


print "#random\n\n";
@param = setParam(<PARAM>);
@data = inferType(<DATA>);
close DATA,PARAM;
@param = MH(@data);

#print "$param[0]\n$param[1]\n";

my $i = 1;
while($i<10)
{
	print "##############################################################################################################\n";
	print "#$i time\n";
	
	

	foreach my $i(keys @data)
	{
		$data[$i] =~ s/[AB][\s]+//;
		$data[$i] .= "\n";
	}
	
	@param = setParam(@param);
	@data = inferType(@data);
	for(@data){
		#print $_,"\n";
	}

	@param = MH(@data);
	for(@param){
		#print $_,"\n";
	}
	$i ++;
}


