#Consider the sequence v = TACGGGTAT and w = GGACGTACG. 
#Assume that the match score is+1, and the mismatch and gap penalties are -1.
#Fill out the dynamic programming table for a global alignment between v and w. 
#Draw arrowsin the cells to store traceback information. 
#What is the score of the optimal global alignment and what alignment(s) achieves this score?
#>>perl SequenceAlignment.pl TACGGGTAT GGACGTACG
#>>perl SequenceAlignment.pl AGGCTATCACCTGACCTCCAGGCCGATGCCC TAGCTATCACGACCGCGGTCGATTTGCCCGAC
#>>perl SequenceAlignment.pl AGGCTAGTT AGCGAAGTTT
my $m = 1;
my $s = -1;
my $d = -1;
@v = split(undef,$ARGV[0]);
@w = split(undef,$ARGV[1]);
$M = scalar @v;
$N = scalar @w;

my @score;
my @ptr;

sub max {
    my ($max, @vars) = @_;
    for (@vars) {
        $max = $_ if $_ > $max;
    }
    return $max;
}

sub showTable {
    print "         ";
    foreach (@v) { printf " %4s ",$_;}    
    print "\n";
    for(my $j = 0; $j <= $N; $j++){
        for(my $i = 0; $i <= $M; $i++){
            if( $i == 0 && $j != 0){printf "%2s ",$w[$j - 1];}
            elsif($i == 0 && $j == 0){print "   ";};
            printf " %4s ",$_[$j*($M+1)+$i];
        }
        print "\n";
    }
    print "\n";
}

sub showResult {
    my ($which,$direct,@trace) = @_;
    my @sequence = @v;

    if ($which eq "w"){
        @sequence = @w;
    }

    for (my $i = 0,$gap = 0; $i < @trace; $i++)
    {
        if(scalar @trace == $M){
            print $sequence[$i];
        }
        else{
            if($trace[$i] eq $direct){
                print "_";
                $gap++;
            }
            else{
                print $sequence[$i-$gap];
            }
        }
    }
    print "\n";
}
################################################################
#建表
for(my $j = 0; $j <= $N; $j++)
{
    for(my $i = 0; $i <= $M; $i++)
    {
        #init
        if($i == 0 && $j == 0)  { 
            $score[0] = 0 ;
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
#印出走訪的結果
print "[Score Table]\n";
showTable(@score);
print "[Path Table]\n";
showTable(@ptr);
################################################################
print "[Trace Back]\n";
my $temp_M = $M;
my $temp_N = $N;
my @trace;
while($ptr[($M+1)*$temp_N+$temp_M] ne "O")
{
    my $now = $ptr[($M+1)*$temp_N+$temp_M];
   
    print "$now ($temp_M,$temp_N)\n";

    unshift(@trace,$now);
    if($now eq "DIAG"){ $temp_M -= 1; $temp_N -= 1; }
    elsif($now  eq "LEFT"){ $temp_M -= 1; }
    elsif($now  eq "UP"){ $temp_N -= 1; }
}
################################################################
print "\n[Result]\n";
showResult("v","UP",@trace);
showResult("w","LEFT",@trace);



