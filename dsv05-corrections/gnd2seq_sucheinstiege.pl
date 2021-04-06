#!usr/bin/env perl

use strict;
use warnings;
no warnings 'uninitialized';

# Data::Dumper für Debugging
use Data::Dumper;

die "Argumente: $0 CSV-Dokument dsv05.seq seq-file original seq-file zum Laden \n" unless @ARGV == 4;

# Unicode-Support innerhalb des Perl-Skripts
use utf8;
# Unicode-Support für Output
binmode STDOUT, ":utf8";

# Catmandu-Module
use Catmandu::Importer::SRU;
use Catmandu::Exporter::MARC;
use Catmandu::Fix::marc_map as => 'marc_map';
use Catmandu::Fix::marc_add as => 'marc_add';
use Catmandu::Fix::marc_remove as => 'marc_remove';

# Text::CSV Module
use Text::CSV::Encoded;

my $csv = Text::CSV::Encoded->new({ sep_char => ';' });
 
my $csvfile = $ARGV[0] or die "Need to get CSV file on the command line\n";

# Hashes zum Einlesen der CSV-Datei ($n als Hashkey)
my $n = 0;
my %gnd;
my %newmarc;
my %origmarc;

# Öffne csv-file und lese zeile für zeile ein 
open(my $csvdata, '<', $csvfile) or die "Could not open '$csvfile' $!\n";

while (my $line = <$csvdata>) {
    chomp $line;
    if ($csv->parse($line)) {
        my @fields = $csv->fields();

	#auslesen der csv-spalten
	
	my $gnd = $fields[1];
	my $gnd_short = $fields[1];
        my $origmarc = $fields[0];
        
        $gnd_short =~ s/\(DE-588\)//g;

	my $marc;

        print "\n";				 
        #einlesen der csv-Spalten in Hash

        $gnd{$n} = $gnd;
        $origmarc{$n} = $origmarc;

        my $query = "pica.nid=$gnd_short";

        my $exporter = Catmandu->exporter('MARC', file => \$marc, type => 'ALEPHSEQ' );

        # Catmandu-Importer für SRU-Abfrage
        my $importer = Catmandu::Importer::SRU->new(
            base => 'http://swb.bsz-bw.de/sru/DB=2.1/username=/password=/',
            query => $query,
            recordSchema => 'marcxml' ,
            recordPacking => 'xml' ,
            parser => 'marcxml',
        );
   
        # Verarbeitung der MARC-Daten 
        $importer->each(sub {
            
            my $data = $_[0];
            my $sysnum = $data->{'_id'};

            for my $j ("000" .. "999") {
                marc_remove($data, $j) unless $j =~ /1[01][01]/;
                marc_remove($data, 'LDR');
            }
  
            $exporter->add($data);
            $exporter->commit;
        });
        # Ersatz GND-Systemnummer/Feldnummer durch HAN-Systenummer/Feldnummern; Ergänzung GND-Nummer
        # Fall 1: 100/700-Feld
        # Fall 2: 600-Feld
           
        chomp $marc;
    
        unless ($marc eq "") {
            unless ($origmarc =~ /^6/) {
                $marc = $sys . " " . $num .  substr($marc,13) . "\$\$1" . $gnd;
            } else {
                $marc = $sys . " " . $num .  substr($marc,13,1) . "7" . substr($marc,15) . "\$\$1" . $gnd . "\$\$2gnd";
            }
        }
        $newmarc{$n} = $marc;
        print "$marc\n";
        $n = $n + 1;
} else {
    warn "Line could not be parsed: $line\n";
}

exit;

my $testfile = $ARGV[2]; 
my $outfile = $ARGV[3]; 
open(my $test, '>:encoding(UTF-8)', $testfile) or die "Could not open file '$testfile' $!";
open(my $output, '>:encoding(UTF-8)', $outfile) or die "Could not open file '$outfile' $!";

my $seqfile = $ARGV[1];
open(my $seqdata, '<:encoding(UTF-8)', $seqfile) or die "Could not open '$seqfile' $!\n";
   
while (my $line = <$seqdata>) {
   chomp $line;
   #print substr($line,0,9) . "\n";
   my $testok = 0;
   my $outputok = 0;
   my $outputline;

   for my $i (0..$n) {
       if (substr($line,0,9) == $sys{$i}) {

	   if (substr($line,10,3) eq $num{$i}) {
	       $testok = 1; 
           
	       if (($line =~ /\$\$a$name{$i}/ ) && ($line =~ /$life{$i}/) && ($marc{$i} ne ""))  {
                   
		   $outputok = 1; 
		   $outputline = "$marc{$i}";
		   $check{$i} = 1;

		   if ($line =~ /\$\$e(.*)\$\$4(.*)(\$\$|$)/) {
			$outputline .= "\$\$e$1\$\$4$2"
		   } elsif ($line =~ /\$\$4(.*)\$\$e(.*)(\$\$|$)/) {
			$outputline .= "\$\$e$2\$\$4$1"
		   }
	       } 
	   }
       }
   }
   print $test "$line\n" if $testok;

   if ($outputok) {
       print $output "$outputline\n";
   } elsif ($testok) {
       print $output "$line\n";
   }
}

for my $k (0..$n) {
    unless ($check{$k}) {
        print $marc{$k} . ":  " . $gnd{$k} . " - " . $sys{$k} . " - " . $num{$k} . " - " . $name{$k} . " - " . $life{$k} . "\n";
    }
}

close $output;



