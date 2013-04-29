#!/usr/bin/perl 
use strict;
use warnings;

my $debug = 0;

sub oneTest{
	my $scriptPath = $_[0];
	my $testPath = $_[1];
	my $ansPath = $_[2];
	if ((-e $scriptPath) && (-e $testPath) && (-e $ansPath)) {
		my $scriptResult = `$scriptPath $testPath`;
		open FILE, $ansPath;
		my $correctResult= do {local $/ = undef; <FILE>;};
		close FILE;
		my @sres = split ("\n", $scriptResult);
		my @cres;
		if ($correctResult =~ /\r\n/){
			@cres = split ("\r\n", $correctResult);
		} else {
			@cres = split ("\n", $correctResult);
		}
		if (@sres != @cres){
			print "Test '$testPath': results count are not equal\n";
		} else {
			my $fails = 0;
			for (my $i=0; $i<@sres; $i++){
				print "Script: $sres[$i] Correct: $cres[$i]\n" if ($debug); 
				if ($sres[$i] != $cres[$i]){
					$fails ++;
					print "Row failed. Script: $sres[$i] Correct: $cres[$i]\n"; 
				}
			}

			if ($fails == 0){
				print "Test '$testPath' passed successful\n";
			}	else { print "Test '$testPath' was failed\n";}
		}
		0;
	} else {print"Can nooooooot locate file\n";}
	-1;
}

my $testScript = $ARGV[0];
my $testFolder = $ARGV[1];
my $testOneScript = $ARGV[2];

if (defined $testOneScript){
	oneTest($testScript,$testFolder,$testFolder.'.a');
	exit;
}

my $flag = 1;
my $index = 1;
while ($flag){
	my $str = $index<10?'0'.$index:$index;
	if ((-e $testFolder.$str)&&(-e $testFolder.$str.'.a')) {
		oneTest($testScript,$testFolder.$str,$testFolder.$str.'.a');
		$index++;
	} else {
		$flag = 0;
	}
}
