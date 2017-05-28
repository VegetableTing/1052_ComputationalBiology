#Problem A. Inferring parameters when I tell you the die type.
#> perl BaysianProbability.pl counts2.txt params2.txt


@paramA, @paramB;
$p_A = 1, $p_B = 1;

open DATA, "< @ARGV[0]";
open PARAM, "< @ARGV[1]";

sub showParam	
{
	for(my $i = 1, printf "[A]%.4f\t", $paramA[0]; $i < 7; $i++){
		printf "[%d]%.4f\t", $i, $paramA[$i];
	}
	print "\n";
	for(my $i = 1, printf "[B]%.4f\t", $paramB[0]; $i < 7; $i++){
		printf "[%d]%.4f\t", $i, $paramB[$i];
	}
	print "\n\n";

}

sub setParam
{
	my $flag = 0;

	for(@_){
		my $i = 0;
		while( /(\.[\w]+)[\s]*/g){	
			if( $flag ){
				$paramB[$i++] = $1;		
			}
			else{
				$paramA[$i++] = $1;
			}
		}
		$flag++;
	}
	showParam();
	my @temp;
	$temp[0] = join(" ",@paramA);
	$temp[1] = join(" ",@paramB);
	
	return @temp;
}

sub inferType{
	my @count;
	my $temp,$data = "";
	
	printf "infer\tP(D|A)P(A)\tP(D|B)P(B)\tP(D)\t\tP(A|D)\t\tP(B|D)\n";
	for(@_){
		$temp = $_;
		
		while( /([1-6])/g){
			
			$p_A *= $paramA[$1];
			$p_B *= $paramB[$1];
		}

		$p_A *= $paramA[0];
		$p_B *= $paramB[0];
		
		if($p_A > $p_B){
			#print "A";
			$data .= "A ".$temp;
		}
		else{
			#print "B"; 
			$data .= "B ".$temp;
		}
		
		my $p_D = ($p_A + $p_B);
		#printf "\t%.2e\t%.2e\t%.2e\t%f\t%f\n", $p_A, $p_B, $p_D, $p_A / $p_D, $p_B  / $p_D;
		$p_A = 1;
		$p_B = 1;
	}
	print "\n";
	my @t = split("\n",$data);
	
	return @t;
}
##########################################################


setParam(<PARAM>);
inferType(<DATA>);

close DATA,PARAM;

##########################################################

