#! /usr/bin/perl

#use warnings;
use strict;
use Text::CSV;
use Catmandu::Importer::MARC::ALEPHSEQ;
use Catmandu::Exporter::MARC::ALEPHSEQ;
use Catmandu::Fix::marc_remove as => 'marc_remove';
use Catmandu::Fix::marc_add as => 'marc_add';
use Catmandu::Fix::marc_map as => 'marc_map';


die "Argumente: $0 Input Output \n" unless @ARGV == 2;

my($inputfile,$outputfile) = @ARGV;

open my $in, "<", $inputfile or die "$0: open $inputfile: $!";
open my $out, ">", $outputfile or die "$0: open $outputfile: $!";

my $ldrpos6;

NEWLINE: while (<$in>) {
    my $sysnumber = (substr $_ , 0, 9);
    my $line = $_;
    my $field = (substr $line, 10, 3);
    my $ind1 = (substr $line, 13, 1);
    my $ind2 = (substr $line, 14, 1);
    my $content = (substr $line, 18);
    chomp $line;
    chomp $content;

    my @subfields = split(/\$\$/, $line);
    shift @subfields;

    if ($field =~ /500/) {
        if ($ind1 eq 'C' && $ind2 eq 'C') { 
            $line = $sysnumber . ' 592   L ' . $content;
            $line =~ s/\$\$a/\$\$b/g;
            print $out $line . "\n";
        } elsif ($ind1 eq 'Z' ) { 
            $line = $sysnumber . ' 593   L ' . $content;
            $line =~ s/\$\$a/\$\$e/g;
            print $out $line . "\n";
        }
    }
}

close $out or warn "$0: close $outputfile $!";

exit;

