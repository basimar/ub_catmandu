#usr/bin/env perl

use strict;
use warnings;
no warnings 'uninitialized';

# Data::Dumper für Debugging
use Data::Dumper;

die "Argumente: $0 Input-Dokument (alephseq) \n" unless @ARGV == 1;

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

# Einlesen Ortschaftenliste aus LoC NA
open my $handle, '<:encoding(UTF-8)', 'locna_places.txt'
  or die "Could not open file";
chomp(my @places = <$handle>);
close $handle;

my $filename = $ARGV[0];
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

while (my $line = <$fh>) {
    chomp $line;
    my $sys = substr($line, 0, 9);
    my $tag = substr($line, 10, 5);
    my $ind1 = substr($tag, 3, 1);
    my $ind2 = substr($tag, 4, 1);
    my $subfields = substr($line, 18);

    my @subfields = split(/\$\$/, $line);
    shift @subfields;
            
    my $change_line;
    my $newline;
    my $newrecord;
            
    if ($tag =~ /(600 0|600-0|600 4|600 6|600 7)/ ) {
        for (@subfields) {
            my $subfield_code = substr $_, 0, 1;
            my $subfield = substr $_, 1;
            if ($subfield_code eq 'a') {
                if ($subfield =~ /,/) { 
                    $change_line = 1;
                    $newline = $sys . ' 6001' . $ind2 . ' L ' . $subfields . "\n";
                } elsif ($subfield =~ /(family|dynasty|clan|house|famille|dynastie|maison|famiglia|dinastia|casa|familie|haus)/i ) {
                    $change_line = 1;
                    $newline = $sys . ' 6003' . $ind2 . ' L ' . $subfields . "\n";
                } else {
                    $change_line = 1;
                    $newline = $sys . ' 6000' . $ind2 . ' L ' . $subfields . "\n";
                }
            }
        }
    } elsif ($tag =~ /(610 0|610-0)/) {
        for (@subfields) {
            my $subfield_code = substr $_, 0, 1;
            my $subfield = substr $_, 1;
            if ($subfield_code eq 'a') {
                my $subfield_compare = NFD($subfield);
                my $subfield_compare_1 = substr($subfield_compare,1);
                my $subfield_compare_2 = $subfield_compare_1;
                $subfield_compare_2 =~ s/.$//g;
                #print $subfield_compare_1 . " " . $subfield_compare_2 . "\n";
                if ($subfield_compare ~~ @places) {
                    #print '"' . $subfield . '"' . " is place" . "\n"
                    $newline = $sys . ' 61010 L ' . $subfields . "\n";
                } elsif ($subfield_compare_1 ~~ @places) {
                    #print '"' . $subfield . '"' . " is place" . "\n"
                    $newline = $sys . ' 61010 L ' . $subfields . "\n";
                } elsif ($subfield_compare_2 ~~ @places) {
                    #print '"' . $subfield . '"' . " is place" . "\n"
                    $newline = $sys . ' 61010 L ' . $subfields . "\n";
                } else {
                    #print '"' . $subfield . '"' . " is not a place" . "\n"
                    $newline = $sys . ' 61020 L ' . $subfields . "\n";
                }
                $change_line = 1;
            }
        }
    } elsif ($tag =~ /610 7/) {
        $change_line = 1;
        $newline = $sys . ' 61027 L ' . $subfields . "\n";
    }
           
    if ($change_line) {
        print $newline;
    } else {
        print $line . "\n";
    }
}


