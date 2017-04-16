#Q1: 
#Write a PERL script using standard input to calculate life expectancy. 
#Assume that the average life expectancy is 70 and then adjust thisaccording to the following recorded variables:
#Calculate the life expectancy of a male non-smoker who exercisestwice a week, drinks 10 units of alcohol a week and eats fatty food.

my $averageLife = 70;
my $input = "";

#Are you male or female? Females get an extra 4 years. 
print "Are you male or female ? ";
$input = <STDIN>;
if ($input eq "female\n"){
	$averageLife += 4;
}

#Are you a smoker?  Add 5 yearsif not, subtract 5 years if you are. 
print "Are you a smoker (yes or no) ? ";
$input = <STDIN>;
if ($input eq "yes\n"){
	$averageLife -= 5;
}
elsif($input eq "no\n"){
	$averageLife += 5;
}

#How often (per week) do you exercise? Subtract 3 years if never, addone year for each exercise session.
print "How often (per week) do you exercise ? ";
$input = <STDIN>;
if ($input == "0"){
	$averageLife -= 3;
}
else{
	$averageLife += $input;
}

#How many units of alcohol do you drink per week?  Remove 0.5 year for every unit over 7.  Gain 2 years if teetotal. 
print "How many units of alcohol do you drink per week ? ";
$input = <STDIN>;
if ($input == 0){
	$averageLife += 2;
}
else{
	if($input <= 14)
	{
		$averageLife -= $input*0.5;
	}
	else 
	{
		$averageLife -= 7;
	}
}

#Do you eat fatty food?  Add 3 years if not.
print "Do you eat fatty food (yes or no) ? ";
$input = <STDIN>;
if ($input == "no"){
	$averageLife += 3;
}

print "\nlife expectancy : ",$averageLife,"\n";