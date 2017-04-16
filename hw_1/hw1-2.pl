#Q2: 
#Write a PERL script to check passwords. 
#The input will come from the command line, which records the user name, old password and new password. 
#The rules are that a password is OK if it is >7 characters long, contains someuppercase characters and is different to the old password. 
#The admin user(username ‘admin’) can do whatever they like. Print out whether the newpassword is OK.

my $uname = $ARGV[0];
my $oldpwd = $ARGV[1];
my $newpwd = $ARGV[2];

sub isLong
{
	if(length $_[0] > 7 && length $_[1] > 7)
	{
		return 1;
	}
	else
	{
		print "Password < 8 characters!\n";
		return 0;
	}
}

if($uname ne "admin")
{
	if(isLong($oldpwd,$newpwd))
	{
		if($newpwd ne $oldpwd && $newpwd =~ /[A-Z]+/)
		{
			print "OK!";
		}
		else 
		{
			print "ERROR!"
		}
	}
	
}else 
{
	print "You are 'admin'. OK!";
}