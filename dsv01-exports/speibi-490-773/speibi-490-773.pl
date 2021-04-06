#!/usr/bin/perl

use strict;
use warnings;
no warnings 'uninitialized';

# Data::Dumper für Debugging
#use Data::Dumper;

die "Argumente: $0 Input-Dokument (alephseq), Systemnummern, die in Unterfeld w vorkommen könnten \n" unless @ARGV == 2;

# Unicode-Support innerhalb des Perl-Skripts
use utf8;
# Unicode-Support für Output
binmode STDOUT, ":utf8";

use Unicode::Normalize;

# Catmandu-Module
use Catmandu::Importer::MARC::ALEPHSEQ;
use Catmandu::Exporter::MARC::ALEPHSEQ;
use Catmandu::Fix::Inline::marc_map qw(:all);
use Catmandu::Fix::Inline::marc_add qw(:all);

use List::Util 'first';

select(STDERR);
$| = 1;
select(STDOUT); # default
$| = 1;

my $speibi_records = $ARGV[1];
open(my $speibi, '<:encoding(UTF-8)', $speibi_records);
chomp(my @speibi = <$speibi>);
close $speibi;

my $filename = $ARGV[0];
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

while (my $line = <$fh>) {
    chomp $line;
    my $tag = substr($line, 10, 5);
    my $subfields = substr($line, 18);

    my @subfields = split(/\$\$/, $line);
    shift @subfields;
        
    my $found_490;

    if ($tag =~ /^(490|773)/ ) {
        for (@subfields) {
            my $subfield_code = substr $_, 0, 1;
            my $subfield = substr $_, 1;
            if ($subfield_code eq 'w') {
                my $subfield_compare = sprintf("%09d", $subfield);
                if ( first { $_ eq $subfield_compare } @speibi) {
                    $found_490 = 1;
                }
            }
        }
        unless ($found_490) {
            print $line . "\n" ;
        } 
    }
}

close $fh;
exit;

