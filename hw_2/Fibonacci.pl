#Fibonacci numbers
#1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, … 
#F(0) = 1; 
#F(1) = 1; 
#F(n) = f(n 1) + f(n -2)
#>>perl Fibonacci.pl 19
#4184

sub fib
{
	my @F = (1, 1);
	my $n = $_[0];

	for(my $i = 2; $i < $n; $i++)
	{
		#push(@F, $F[$i - 1] + $F[$i - 2]);
		$F[$i] = $F[$i - 1] + $F[$i - 2];
	}
	return @F[$n - 1],"\n";
}

print fib($ARGV[0]);

