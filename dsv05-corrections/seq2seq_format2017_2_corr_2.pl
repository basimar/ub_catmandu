#! /usr/bin/perl

use warnings;
use strict;

# Skript verlangt zwei Aleph-Sequential files als Input und exportiert aufgrund der 
# Systemnummern im ersten Inputfile sämtliche Felder im zweiten Inputfile mit der 
# gleichen Systemnummern.
# Autor: Basil Marti (basil.marti@unbas.ch)

# 2017.09.17: Uploaded to ub-catmandu /bmt 

die "Argumente: $0 Input (Actual Data), Input (Wrong corrections), Output\n" unless @ARGV == 3;

my($input1file,$input2file,$outputfile) = @ARGV;

open my $in1, "<", $input1file or die "$0: open $input1file: $!";
open my $out, ">", $outputfile or die "$0: open $outputfile: $!";

while (my $z1 = <$in1>) {
    my $tag = substr($z1,10,5);
    print $tag . "\n";
    open my $in2, "<", $input2file or die "$0: open $input2file: $!";
    while (my $z2 = <$in2>) {
        if ($z1 eq $z2) {
            if ($tag =~ /^592/) {
                $z1 =~ s/\$\$b/\$\$c/g;
            } elsif ($tag =~ /^593/) {
                $z1 =~ s/\$\$e/\$\$f/g;
            }
        }
    }
    print $out $z1;
    close $in2;
}

close $out or warn "$0: close $outputfile:: $!";

