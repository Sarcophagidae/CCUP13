#!/usr/bin/perl
use strict;
use warnings;
use 5.014;

my $debug = 0;

sub fact{
	#return undef if ($_[0] == undef);
	return (($_[0] == 1) || ($_[0] == 0)) ? 1 : $_[0] * fact( $_[0] - 1);
}

sub cmn{
	my $m_ = $_[0]; 
	my $n_ = $_[1];
	fact($n_)/(fact($n_-$m_)*fact($m_));
}
	
#print cmn(3,2),' ',cmn(4,2);
#exit;
my $questCnt = <>;
my $line;
for (my $i = 1; $i <= $questCnt; $i ++){
	say "-------------";
	my $sideCnt = <>;
	my @sides = split (' ',<>);
	my %g;
	map {$g{$_}++;} @sides;
	#map {say "key <$_><$g{$_}>"} keys %g;

	map {
		my $tmpk = $_;
		say "key [$tmpk][$g{$tmpk}]";
		if ($g{$tmpk}>=4){
			say "[$tmpk] >= 4";
			say "\t",cmn(4,$g{$tmpk}); 
		}	
		say "[$tmpk] >= 2";
		map {
			say "[$tmpk] x $_";
			say "\t",cmn(2,$g{$tmpk})*cmn(2,$g{$_}); 
		} grep (($g{$_}>=2)&&($_!=$tmpk), keys %g);
	} grep ($g{$_}>=2, keys %g);

	#map {print "$_ $g{$_}\n"} keys %g;
	#say "------";
	%g=();	
}
