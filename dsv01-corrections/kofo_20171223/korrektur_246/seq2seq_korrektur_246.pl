#! /usr/bin/perl

use warnings;
use strict;

# Skript zur Auswahl der zu korrigierenden 246-Felder
# Autor: Basil Marti (basil.marti@unibas.ch)

# 2017.09.17: Uploaded to ub-catmandu /bmt 

die "Argumente: $0 Falsch korrigierte Felder, Sämtliche 246-Felder der betroffenen Katalogisate, Output\n" unless @ARGV == 3;

my($input1file,$input2file,$outputfile) = @ARGV;

open my $wrong246, '<', $input1file;
chomp(my @wrong246 = <$wrong246>);
close $wrong246;

open my $all246, '<', $input2file;
chomp(my @all246 = <$all246>);
close $all246;

print "Katalogisate zum Korrigieren: " . scalar(@wrong246) . "\n";

my $corrected;

open my $out, ">", $outputfile or die "$0: open $outputfile: $!";

for (@all246) {
    my $corr;
    my $line_all = $_;
    for (@wrong246) {
        my $line_wrong = $_;
        $corr = 1 if $line_all eq $line_wrong;
    }
 
    if ($corr) {
        $line_all =~ s/ 24610 L/ 2461  L/g;
        $corrected++;
    }

    print $out $line_all . "\n";
}

print "Katalogisate korrigiert: " . $corrected . "\n";

for (@wrong246) {
    my $present;
    my $line_wrong = $_;
    for (@all246) {
        my $line_all = $_;
        $present = 1 if $line_all eq $line_wrong;
    }
 
    unless ($present) {
        print "Not present: $line_wrong\n";
    }

}


