#!/usr/bin/perl
use strict;
use warnings;
use 5.014;

my $debug = 0;

sub fact{
	return 24 if ($_[0] == 4);
	return (($_[0] == 1) || ($_[0] == 0)) ? 1 : $_[0] * fact( $_[0] - 1);
}

sub cmn{
	my $m = $_[0]; 
	my $n = $_[1];
	#fact($n_)/(fact($n_-$m_)*fact($m_));
	my $up = 1;
	$up*=$_	foreach ($n-$m+1..$n);
	$up/fact($m);
}
	
sub checkTrap{
	my $a = $_[0];
	my $x = $_[1];
	my $y = $_[2];

	#say "$a $x $y";
	if ($y<$x){
		my $tmp = $x;
		$x = $y;
		$y = $tmp;
	}
	
	my $z = ($y - $x) / 2;
	#print "z = $z\n";
	if ($a*$a - $z*$z <= 0){
		return 0;
	} else {return 1;}
}

sub isFourEqual{
	my ($a1, $a2, $a3, $a4) = @_;
	if (($a1 == $a2) and ($a2==$a3) and ($a3 == $a4)) {
		1;
	} else {
		0;
	}
}

sub checkFullTrap{
	my %g;
	#say @_;
	map {$g{$_}++;} @_;
	my @pareInd = grep ($g{$_}>1, keys %g);
	return 1 if (@pareInd == 2);
	my ($i, $j);

	for ($i=0; $i<4; $i++){
		my $sum = 0;
		for ($j = 0; $j<4; $j++){
			next if ($i == $j);
			$sum += $_[$j];	
		}
		if ($sum < $_[$i]){
			return 0;
		}
	}
	if (@pareInd == 1){
		if (isFourEqual(@_)){
			return 1;
		} else {
			my @ar = grep ($_!=$pareInd[0], keys %g);
			if (@ar == 1){
				return checkTrap($pareInd[0], $pareInd[0], @ar);
			} else {
				return checkTrap($pareInd[0], @ar);
			}
		} 
	} else { return 0; }
}

sub hard{
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
}

sub soft{
	my $questCnt = <>;
	my $line;
	for (my $i = 1; $i <= $questCnt; $i ++){
		my $cnt = 0;
		my $cntYes = 0;
		my $sideCnt = <>;
		my @sides = split (' ',<>);
		if (@sides == 4) {
			$cntYes = checkFullTrap(@sides); 
		} else {
			for (my $j1 = 0; $j1< @sides; $j1++){	
				for (my $j2 = $j1; $j2< @sides; $j2++){	
					next if ($j2 <= $j1);
					for (my $j3 = $j2; $j3< @sides; $j3++){	
						next if (($j3 <= $j2)or($j3 <= $j1));
						for (my $j4 = $j3; $j4< @sides; $j4++){	
							next if (($j4 <= $j3)or($j4 <= $j2)or($j4 <= $j1));
							$cntYes++ if (checkFullTrap(@sides[$j1,$j2,$j3,$j4]));
							$cnt++;
						}
					}
				}
			}
		}
	say "$cntYes";
	} 
}
#say checkTrap(5,3,9);
#say checkTrap(5,9,3);
#say checkTrap(4,2,10);
#say checkTrap(4,4,4);

#print checkFullTrap(1,2,10,10)."\n"; # 1
#print checkFullTrap(1,2,2,10)."\n"; 	# 0
#print checkFullTrap(10,10,10,10)."\n";#1
#print checkFullTrap(1,2,1,150)."\n";	# 0
#print checkFullTrap(11,1,12,10)."\n";# 1
say cmn(4,5000); exit;
#soft;
