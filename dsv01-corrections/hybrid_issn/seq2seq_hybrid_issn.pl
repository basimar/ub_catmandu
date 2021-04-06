#!usr/bin/env perl

use strict;
use warnings;
no warnings 'uninitialized';

# Data::Dumper für Debugging
use Data::Dumper;

die "Argumente: $0 Input-Dokument (alephseq mit 022 und 776-Feldern), Modus: [E]lektronisch, [P]rint oder [A]lle ISSN \n" unless @ARGV == 2;

# Unicode-Support innerhalb des Perl-Skripts
use utf8;
# Unicode-Support für Output
binmode STDOUT, ":utf8";

# Catmandu-Module
use Catmandu::Importer::MARC::ALEPHSEQ;
use Catmandu::Exporter::MARC::ALEPHSEQ;
use Catmandu::Fix::Inline::marc_map qw(:all);
use Catmandu::Fix::Inline::marc_add qw(:all);

my $modus = $ARGV[1];

my $issn_master;

if ($modus =~ /P/) {
    $issn_master = 'ISSN_Print.csv.uniq.eindeutig'
} elsif ($modus =~ /E/) {
    $issn_master = 'ISSN_Elektronisch.csv.uniq.eindeutig'
} elsif ($modus =~ /A/) {
    $issn_master = 'ISSN_All.csv.uniq'
} else {
    die "Ungültiger Modus: E, P oder A eingeben\n"
}

open (my $fh_master, '<:encoding(UTF-8)', $issn_master)
  or die "Could not open file '$issn_master' $!";

my @issn_master;

while (my $line_master = <$fh_master>) {
    chomp $line_master;
    if ( $line_master =~ /^[0-9]{4}-[0-9]{3}[0-9X]$/ ) {
        push @issn_master, $line_master
    } else {
        print "Invalid ISSN: $line_master\n"
    }
}

my $filename = $ARGV[0];
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

my %issn_x;

while (my $line = <$fh>) {
    chomp $line;

    my $sys = substr($line, 0, 9);
    my $tag = substr($line, 10, 5);
    my $subfields = substr($line, 18);

    my @subfields = split(/\$\$/, $line);
    shift @subfields;

    if ($tag =~ /^022/) {

        for (@subfields) {
            my $subfield_code = substr $_, 0, 1;
            my $subfield = substr $_, 1;
            if ($subfield_code eq 'a') {
                my $issn_valid = 0;
                my $issn_mix = 0;
                for (@issn_master) {
                    if (lc($_) eq lc($subfield)) {
                        $issn_valid = 1;
                        $issn_mix = 1;
                    }
                }  
                unless ($modus =~ /A/) {
                    if ($issn_mix) {
                        $line =~ s/\$\$a/\$\$y/g;
                        unless ($issn_x{$sys}) {
                            $issn_x{$sys} = $subfield
                        } else {
                            print "Kann für $sys nur eine ungültige ISSN in Feld 776 einfügen\n"
                        }
                    }
                }
 
                if ($modus =~ /A/) { 
                   print $sys . " " . $subfield . "\n" unless $issn_valid
                }
            }
        }   
    print $line . "\n" unless $modus =~ /A/;
    }

}

open(my $fh2, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

while (my $line = <$fh2>) {
    chomp $line;

    my $sys = substr($line, 0, 9);
    my $tag = substr($line, 10, 5);
    my $subfields = substr($line, 18);

    my @subfields = split(/\$\$/, $line);
    shift @subfields;

    if ($tag =~ /^776/) {
        if ($modus =~ /P/) {
            if ($subfields =~ /\$\$i(Druck-Ausgabe|Erscheint auch als Druck-Ausgabe)/) {
                $line .= '$$x' . $issn_x{$sys};
                $line =~ s/\$\$x$//g;
            }
        } elsif ($modus =~ /E/) {
            if ($subfields =~ /\$\$i(Online-Ausgabe|Erscheint auch als Online-Ausgabe)/) {
                $line .= '$$x' . $issn_x{$sys};
                $line =~ s/\$\$x$//g;
            }
        }
    print $line . "\n" unless $modus =~ /A/;
    }
}


