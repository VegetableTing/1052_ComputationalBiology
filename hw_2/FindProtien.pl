#>> perl FindProtien.pl GGAGGCGTAAAATGCGTACTGGTAATGCAAACTAATGG

sub DNAReverse {
	my $output;
	while( $_[0] =~ /(.)/g ) {
		if( $1 eq "A" ) { $output .= "T"; }
		elsif( $1 eq "T" ) { $output .= "A"; }
		elsif( $1 eq "C" ) { $output .= "G"; }
		elsif( $1 eq "G" ) { $output .= "C"; }
	}
	return $output;
}

sub checkCodon{
	my @find;
	while($_[0] =~ /AUG|UAA|UGA|UAG/g)
	{
		push(@find,pos($_[0]) - 3);
	}
	if( $_[0] =~ /AUG/) { print "start "; }
	if( $_[0] =~ /UAA|UGA|UAG/) { print "stop"; }
	print "\n   ";
	for (my $i = 0,$j = 0; $i < length $_[0]; ){
		if($find[$j] == $i){
			print "***";
			$i += 3;
			$j ++;
		}else{
			print " ";
			$i++;
		}
	} 
}

my $conding = $ARGV[0];
my $template = DNAReverse($conding);
print "5' $conding 3' [Coding strand]\n";
print "3' $template 5' [Template strand]\n\n";

my $mTemplate = $conding;
my $mCoding = $template;
$mCoding =~ tr/T/U/;
$mTemplate =~ tr/T/U/;
print "3' $mCoding 5' [Coding mRNA]\n";
print "5' $mTemplate 3' [Template mRNA]\n\n";

$mCoding = reverse $mCoding;
print "5' $mCoding 3' [Reverse Coding mRNA] : ";
checkCodon($mCoding);
print "\n5' $mTemplate 3' [Template mRNA] : ";
checkCodon($mTemplate);

print "\n";

