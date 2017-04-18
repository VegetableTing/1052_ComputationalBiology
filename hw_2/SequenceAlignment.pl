#Consider the sequence v = TACGGGTAT and w = GGACGTACG. 
#Assume that the match score is+1, and the mismatch and gap penalties are -1.
#Fill out the dynamic programming table for a global alignment between v and w. 
#Draw arrowsin the cells to store traceback information. 
#What is the score of the optimal global alignment and what alignment(s) achieves this score?
#>>perl SequenceAlignment.pl TACGGGTAT GGACGTACG
#>>perl SequenceAlignment.pl AGGCTATCACCTGACCTCCAGGCCGATGCCC TAGCTATCACGACCGCGGTCGATTTGCCCGAC

my $m = 1;
my $s = -1;
my $d = -1;
my @v = split(undef,$ARGV[0]);
my @w = split(undef,$ARGV[1]);
my $M = scalar @v;
my $N = scalar @w;

my @score;
my @ptr;

sub max {
    my ($max, @vars) = @_;
    for (@vars) {
        $max = $_ if $_ > $max;
    }
    return $max;
}

for(my $j = 0; $j <= $N; $j++)
{
    for(my $i = 0; $i <= $M; $i++)
    {
        #init
        if($i == 0 && $j == 0)  { 
            $ptr[0] = "O";
        }
        elsif($j == 0)  { 
            $score[$i] = $i * $d; 
            $ptr[$i] = "LEFT";
        }
        elsif($i == 0) { 
            $score[$j*($M+1)] = $j * $d; 
            $ptr[$j*($M+1)] = "UP";
        }
        else { 
            my $case1 = $score[$j*($M+1)+$i-1] + $d;
            my $case2 = $score[($j-1)*($M+1)+$i] + $d;
            my $case3;

            if($v[$i-1] eq $w[$j-1]){ $case3 = $score[($j-1)*($M+1)+$i-1] + $m; }
            else{ $case3 = $score[($j-1)*($M+1)+$i-1] + $s;}
            
            my $max = max($case1,$case2,$case3);
            $score[$j*($M+1)+$i] = $max;

            if($max == $case3){ $ptr[$j*($M+1)+$i] = "DIAG"; }
            elsif($max == $case1){ $ptr[$j*($M+1)+$i] = "LEFT"; }
            else{ $ptr[$j*($M+1)+$i] = "UP"; }  
        }
    }

}
################################################################  
print "         ";
foreach (@v) { printf " %4s ",$_;}    
print "\n";
for(my $j = 0; $j <= $N; $j++){
    for(my $i = 0; $i <= $M; $i++){
        if( $i == 0 && $j != 0){printf "%2s ",$w[$j - 1];}
        elsif($i == 0 && $j == 0){print "   ";};
        printf " %4d ",$score[$j*($M+1)+$i];
    }
    print "\n";
}
print "\n";


print "         ";
foreach (@v) { printf " %4s ",$_;}    
print "\n";
for(my $j = 0; $j <= $N; $j++){
    for(my $i = 0; $i <= $M; $i++){
        if( $i == 0 && $j != 0){printf "%2s ",$w[$j - 1];}
        elsif($i == 0 && $j == 0){print "   ";};
        printf " %4s ",$ptr[$j*($M+1)+$i];
    }
    print "\n";
}
print "\n";
################################################################
my $M_ = $M;
my $N_ = $N;
my @trace;
while( $ptr[($M+1)*$N_+$M_] ne "O")
{
    my $now = $ptr[($M+1)*$N_+$M_];
    print "$now ($M_,$N_)\n";
    unshift(@trace,$now);
    if( $now eq "DIAG"){
        $M_ -= 1;
        $N_ -= 1;
    }
    elsif( $now  eq "LEFT"){
        $M_ -= 1;
    }
    else{
        $N_ -= 1;
    }
     
}
print "\n";
################################################################
for (my $i = 0,$gap = 0; $i < @trace; $i++)
{
    if(scalar @trace == $M){
        print $v[$i];
    }
    else{
        if($trace[$i] eq "UP"){
            print "_";
            $gap++;
        }
        else{
            print $v[$i-$gap];
        }
    }
}
print "\n";

for (my $i = 0,$gap = 0; $i < @trace; $i++)
{
    if(scalar @trace == $N){
        print $w[$i];
    }
    else{
        if($trace[$i] eq "LEFT"){
            print "_";
            $gap++;
        }
        else{
            print $w[$i-$gap]
        }
    }
}

