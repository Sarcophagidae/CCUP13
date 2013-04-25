#!/usr/bin/perl
use strict;
use warnings;
use 5.014;


my $debug = 0;


sub swap{
	my $ar = $_[0];
	my $a = $_[1];
	my $b = $_[2];
	my $tmp = $ar->[$a];
	$ar->[$a] = $ar->[$b]; 	
	$ar->[$b] = $tmp;
}

sub swapIL{
	my $ar = $_[0];
	my $a = $_[1];
	my $b = $_[2];
	swap($ar, $a, $b) if ($ar->[$a] < $ar->[$b]);
}

sub swapPair{
	my $ar = $_[0];
	my $a = $_[1];
	my $b = $_[2];
	swap($ar, $a*2, $b*2);
	swap($ar, $a*2+1, $b*2+1);
}

sub swapPairIFL{
	my $ar = $_[0];
	my $a = $_[1];
	my $b = $_[2];

	swapPair($ar,$a,$b) if ($ar->[$a*2] < $ar->[$b*2]);
}

sub swapPairISLFE{
	my $ar = $_[0];
	my $a = $_[1];
	my $b = $_[2];

	swapPair($ar,$a,$b) if (($ar->[$a*2+1] < $ar->[$b*2+1])&&($ar->[$a*2] == $ar->[$b*2]));
}
sub minimalArea{ 
	my @m = @_; 

	say join (' ', @m)."\n" if ($debug);	
	swapIL(\@m, 0,1);
	swapIL(\@m, 2,3);
	swapIL(\@m, 4,5);

	say join (' ', @m)."\n" if ($debug);	
	swapPairIFL(\@m,0,1);
	swapPairIFL(\@m,1,2);
	swapPairIFL(\@m,0,1);

	say join (' ', @m)."\n" if ($debug);	
	swapPairISLFE(\@m,0,1);
	swapPairISLFE(\@m,1,2);
	swapPairISLFE(\@m,0,1);

	say join (' ', @m)."\n" if ($debug);	
	my $area = $m[0] * $m[1];

	if ($m[3] > $m[1]){
		$area += ($m[3] - $m[1]) * ($m[2]);
	}

	if (($m[5] > $m[3]) && ($m[3] > $m[1])){
		$area += ($m[5] - $m[3]) * ($m[4]);
	} elsif (($m[5]>$m[1])&&($m[3]<$m[1])) {
		$area += ($m[5] - $m[1]) * ($m[4]);
	}	

	$area;
}

say minimalArea(4, 1, 3, 2, 2, 3) if ($debug);
exit if ($debug);

my $line;
while ($line = <>){
	my @x = split (/ /, $line);
	exit if ($x[0]==0);

	say minimalArea($x[0],$x[1],$x[2],$x[3],$x[4],$x[5]);
}
