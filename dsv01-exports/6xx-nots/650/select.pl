#! /usr/bin/perl

use warnings;
use strict;

# Skript verlangt zwei Aleph-Sequential files als Input und exportiert aufgrund der 
# Systemnummern im ersten Inputfile sämtliche Felder im zweiten Inputfile mit der 
# gleichen Systemnummern.
# Autor: Basil Marti (basil.marti@unbas.ch)

# 2017.09.17: Uploaded to ub-catmandu /bmt 

die "Argumente: $0 Input (Systemnummer), Input (Daten), Output\n" unless @ARGV == 3;

my($input1file,$input2file,$outputfile) = @ARGV;

open my $in1, "<", $input1file or die "$0: open $input1file: $!";
open my $out, ">", $outputfile or die "$0: open $outputfile: $!";

while (my $z1 = <$in1>) {
    #print $z1;
    chomp $z1;
    my $teilbestand_f;
    open my $in2, "<", $input2file or die "$0: open $input2file: $!";
    while (my $z2 = <$in2>) {
        chomp $z2;
        if ( index($z1, $z2) != -1) {
             $teilbestand_f = 1;
             next;
        }
    }
    if ($teilbestand_f) {
        print $out $z1 . "\n";
        print $z1 . "\n";
    }
    close $in2;
}

close $out or warn "$0: close $outputfile:: $!";

