#!/usr/bin/perl
#
use strict;
use warnings;

my @data = `cmus-remote -Q`;
my $np;
my %cmus;

chomp @data;
foreach (@data) {
	my ($k,$v);
	$_ =~ s/(set|tag) //;
        $k = $_;
	$v = $_;
	$v =~ s/^[a-z]+ //;
	$k =~ s/^([a-z]+) .*/$1/;
	$cmus{$k} = $v;
#	print "$k => $v\n";
}

if (!$cmus{artist} or !$cmus{title}) {
	my $file = $cmus{file};
	$file =~ s/.*\///;
	$file =~ s/\.(mp3|ogg)$//;
	$np = $file;
}
else {
	$np = $cmus{artist} . " - " . $cmus{title};	
}

if ($cmus{status} ne "playing") {
	print "cmus is " . $cmus{status};
}
else {
	print "np. $np";
}
