#!/usr/bin/perl
use strict;
use warnings;
use 5.014;

my $debug = 0;
sub d{
	say $_[0] if (($debug) or (defined $_[1]));
}

sub fact{
	return 24 if ($_[0] == 4);
	return (($_[0] == 1) || ($_[0] == 0)) ? 1 : $_[0] * fact( $_[0] - 1);
}

sub cmn{
	my $m = $_[0]; 
	my $n = $_[1];
	#fact($n_)/(fact($n_-$m_)*fact($m_));
	my $up = 1;
	return 1 if ($m==$n);
	$up*=$_ foreach ($n-$m+1..$n);
		
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

sub fast{
	my $questCnt = <>;
	my $line;
	for (my $i = 1; $i <= $questCnt; $i ++){
		d("-------------");
		my $sideCnt = <>;
		my @sides = split (' ',<>);
		my %g;
		my $sum = 0;
		map {$g{$_}++;} @sides;
		map {d("key [$_] = [$g{$_}]")} @sides ;
		d("-------------");
		map {

			my $ind = $_;
			d("key [$ind] = [$g{$ind}]");
			if ($g{$ind}>=4){
				$sum += cmn(4,$g{$ind});
				d("!4! sum = $sum");
			}	

			if ($g{$ind}>=3){
				map {$sum += cmn(3,$g{$ind}) if (checkTrap($ind,$ind,$_))} grep ($g{$_}==1,keys %g);
				d("!3! sum = $sum");
			}

			map {
				$sum += cmn(2,$g{$ind})*cmn(2,$g{$_}); 
				d("!2! sum = $sum");
			} grep (($g{$_}>=2)&&($_!=$ind), keys %g);
			
			my @sides = grep ($g{$_}, keys %g);
			for (my $i = 0; $i<@sides; $i++){
				for (my $j = $i; $j<@sides; $j++){
					next if ($j <= $i);
					$sum += cmn(2,$g{$ind}) if (checkTrap($ind,$sides[$i],$sides[$j]));
					d("!1! sum = $sum");
				}
			}
				
			delete $g{$ind};

		} grep ($g{$_}>=2, keys %g);

		#map {print "$_ $g{$_}\n"} keys %g;
		d("result = $sum");
		say $sum if (not $debug);

		%g=();	
		d("-------------");
	}
}

sub brute{
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
#my $m = 4; my $n = 6; say "C($m,$n) = ".cmn($m,$n); exit;
fast;
