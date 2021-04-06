#!usr/bin/env perl

use strict;
use warnings;
no warnings 'uninitialized';

# Data::Dumper für Debugging
use Data::Dumper;

die "Argumente: $0 Input-Dokument (alephseq) Output-Dokument (sys) \n" unless @ARGV == 2;

# Unicode-Support innerhalb des Perl-Skripts
use utf8;
# Unicode-Support für Output
binmode STDOUT, ":utf8";

# Catmandu-Module
use Catmandu::Importer::MARC::ALEPHSEQ;
use Catmandu::Exporter::MARC::ALEPHSEQ;
use Catmandu::Fix::Inline::marc_map qw(:all);
use Catmandu::Fix::Inline::marc_add qw(:all);

my @tags = (
    '600 0' , 
    '600-0' , 
    '600 4' ,
    '600 6' ,
    '600 7' ,
    '610 0' ,
    '610-0' ,
    '610 7' ,
);

my $input = $ARGV[0];
my $output = $ARGV[1];
open(my $in, '<:encoding(UTF-8)', $input)
  or die "Could not open file '$input' $!";

open(my $out, '>:encoding(UTF-8)', $output)
  or die "Could not open file '$output' $!";
 
while (my $line = <$in>) {
    chomp $line;
    my $sys = substr($line, 0, 9);
    my $tag = substr($line, 10, 5);
    my $subfields = substr($line, 18);
    my $change_line;
      
    for (@tags) {
        if ($_ eq $tag) {
            $change_line = 1;
        }
    }
    print $out $sys . "DSV01\n" if $change_line;
}

close $input;
close $output;





