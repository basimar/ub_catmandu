#! /usr/bin/perl

#use warnings;
use strict;
use Text::CSV;
use Catmandu::Importer::MARC::ALEPHSEQ;
use Catmandu::Exporter::MARC::ALEPHSEQ;
use Catmandu::Fix::marc_remove as => 'marc_remove';
use Catmandu::Fix::marc_add as => 'marc_add';
use Catmandu::Fix::marc_map as => 'marc_map';
use Catmandu::Fix::marc_set as => 'marc_set';

# Unicode-Support innerhalb des Perl-Skripts
use utf8;
# Unicode-Support für Output
binmode STDOUT, ":utf8";

die "Argumente: $0 Input Output \n" unless @ARGV == 2;

my($inputfile,$outputfile) = @ARGV;
my $tempfile = './temp.seq';

open my $in, "<:encoding(UTF-8)", $inputfile or die "$0: open $inputfile: $!";
open my $out, ">:encoding(UTF-8)", $tempfile or die "$0: open $tempfile: $!";

my $fmt;

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

    my $f853;

    #Originales Feld 852 in 853 verschieben, Felder 852 ohne Indikatoren so anpassen, so dass in Alma Holdings generiert werden können 
    if ($field =~ /852/) {

        $f853 = $sysnumber . ' 853' . $ind1 . $ind2 . ' L ' . $content . "\n";

        my $f852a;
        my $f852b;
        my $f852c;
        my $f852n;
        my $f852p;
        my $f852q;
        my $f852x;
        my $f852z;
        
        foreach (@subfields) {
            if (substr($_, 0, 1) eq 'a') {
                $f852a = substr($_, 1)
            } elsif (substr($_, 0, 1) eq 'b') {
                $f852b = substr($_, 1)
            } elsif (substr($_, 0, 1) eq 'c') {
                $f852c = substr($_, 1)
            } elsif (substr($_, 0, 1) eq 'n') {
                $f852n = substr($_, 1)
            } elsif (substr($_, 0, 1) eq 'p') {
                $f852p = substr($_, 1)
            } elsif (substr($_, 0, 1) eq 'q') {
                $f852q = substr($_, 1)
            } elsif (substr($_, 0, 1) eq 'x') {
                $f852x = substr($_, 1)
            } elsif (substr($_, 0, 1) eq 'z') {
                $f852z = substr($_, 1)
            }
        }

        if ($ind1 eq 'A') {

            print $out $f853 if $f853;
            next NEWLINE;
            
        } elsif ($ind1 eq 'E') {
            
            print $out $f853 if $f853;
            next NEWLINE;
            
        } else {
            if ( $f852a =~ /Basel UB Wirtschaft - SWA/ ) {
                $f852b = 'A125';
                $f852c = '125PA';
                $f852p =~ s/^CH //g;
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
                $line =~ s/\$\$.\$\$/\$\$/g;
            } elsif ( $f852a =~ /Basel UB/ ) {
                if ($f852b =~ /Handschriften/ ) {
                    $f852c = '102HSS'
                } elsif ( $f852b =~ /Magazin/ ) {
                    $f852c = 'MAG'
                } elsif ( $f852b =~ /Porträtsammlung/ ) {
                    $f852c = '100KS'
                } elsif ( $f852b =~ /Kartensammlung/ ) {
                    $f852c = '100KS'
                } 
                $f852b = 'A100';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$hUBH ' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /Beromünster Stift/ ) {
                if ($f852b =~ /Bibliothek/ ) {
                    $f852c = '380BI'
                } elsif ( $f852b =~ /Archiv/ ) {
                    $f852c = '380AR'
                } elsif ( $f852b =~ /Schatzkammer/ ) {
                    $f852c = '380SK'
                } 
                $f852b = 'A380';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y68';
            } elsif ( $f852a =~ /KB Thurgau/ ) {
                $f852c = '381HB';
                $f852b = 'A381';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /Zofingen SB/ ) {
                $f852c = '382HS';
                $f852b = 'A382';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y68';
            } elsif ( $f852a =~ /St. Gallen Stiftsbibliothek/ ) {
                $f852c = 'KGSR';
                $f852b = 'SGSTI';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y68';
            } elsif ( $f852a =~ /Appenzell Ausserrhoden/ ) {
                $f852c = 'ZSA';
                $f852b = 'SGARK';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /KB Aargau/ ) {
                if ($f852b =~ /Magazin/ ) {
                    $f852c = 'AKBMA'
                } elsif ( $f852b =~ /Handschriften/ ) {
                    $f852c = 'AKBHA'
                } elsif ( $f852b =~ /Nachlässe/ ) {
                    $f852c = 'AKBNA'
                } 
                $f852b = 'AKB';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /St. Gallen KB Vadiana/ ) {
                if ($f852b =~ /Rara Vadianische Sammlung/ ) {
                    $f852c = 'RAVS'
                } elsif ( $f852b =~ /Rara KB Vadiana St. Gallen/ ) {
                    $f852c = 'RAKB'
                } elsif ( $f852b =~ /Rara KB St. Gallen/ ) {
                    $f852c = 'RAKB'
                } elsif ( $f852b =~ /St. Galler Zentrum für das Buch/ ) {
                    $f852c = 'RAZB'
                } 
                $f852b = 'SGKBV';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /Luzern ZHB/ ) {
                if ($f852b =~ /Sondersammlung Tresor BB/ ) {
                    $f852c = 'ZBTRB'
                } elsif ( $f852b =~ /Sondersammlung Tresor KB/ ) {
                    $f852c = 'ZBTRK'
                } elsif ( $f852b =~ /Sondersammlung 114/ ) {
                    $f852c = 'ZBT14'
                } elsif ( $f852b =~ /Sondersammlung U30/ ) {
                    $f852c = 'ZBT10'
                } elsif ( $f852b =~ /Sondersammlung Rollgestell/ ) {
                    $f852c = 'ZBT10'
                } elsif ( $f852b =~ /Sondersammlung Rollgestell U30/ ) {
                    $f852c = 'ZBT10'
                } elsif ( $f852b =~ /Sondersammlung Elektronisches Archiv ZHB/ ) {
                    $f852c = 'ZBT14'
                } elsif ( $f852b =~ /Sondersammlung Graphiksammlung/ ) {
                    $f852c = 'ZBSOS'
                } 
                $f852b = 'LUZHB';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /Bern UB Schweizerische Osteuropabibliothek/ ) {
                $f852c = '415H2';
                $f852b = 'B415';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /Bern UB Bibliothek Münstergasse/ ) {
                $f852c = '404U3';
                $f852b = 'B404';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /Bern UB Archives REBUS/ ) {
                $f852c = '400K1';
                $f852b = 'B400';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /Bern UB Medizingeschichte: Rorschach-Archiv/ ) {
                $f852c = '583RO';
                $f852b = 'B583';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /Bern Gosteli-Archiv/ ) {
                if ($f852b =~ /Biografische Notizen/ ) {
                    $f852c = '445BN'
                } else  {
                    $f852c = '445AN'
                } 
                $f852b = 'B445';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } elsif ( $f852a =~ /Solothurn ZB/ ) {
                if ($f852b =~ /Handschriften/ ) {
                    $f852c = '150SO'
                } elsif ($f852b =~ /Alte Drucke/ ) {
                    $f852c = '150SO'
                } elsif ($f852b =~ /Historische Musiksammlung/ ) {
                    $f852c = '150SO'
                } 
                $f852b = 'A150';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852z . '$$y12';
            } else {
                my $f852a_old = "Standort: " . $f852a if $f852a;
                my $f852b_old = ", " . $f852b if $f852b;
                $f852c = '117B1';
                $f852b = 'A117';
                $line = $sysnumber . ' 8524  L $$b' . $f852b . '$$c' . $f852c . '$$n' .  $f852n . '$$h' .  $f852p . '$$z' . $f852q . '$$x' . $f852x . '$$z' . $f852a_old . $f852b_old . '$$y12';
            }
        }

        $line =~ s/\$\$z\$\$/\$\$/g;
        $line =~ s/\$\$x\$\$/\$\$/g;
        $line =~ s/\$\$z$//g;
        
        #if ( $f852q =~ /(Zugang|Benutzung) eingeschränkt/ ) {
        #    $line =~ s/\$\$y12/\$\$y67/g;
        #    $line =~ s/\$\$y68/\$\$y67/g;
        #}
    }

    print $out $line . "\n";
    print $out $f853 if $f853;
}

close $out or warn "$0: close $tempfile $!";

my $importer = Catmandu::Importer::MARC::ALEPHSEQ->new(file => $tempfile);
#my $exporter = Catmandu::Exporter::MARC::ALEPHSEQ->new(file => $outputfile);
#my $exporter = Catmandu::Exporter::MARC::XML->new(file => $outputfile);
my $exporter = Catmandu::Exporter::MARC::XML->new(file => $outputfile, pretty => 1);

$importer->each(sub {
    my $data = $_[0];

    my $sysnumber = $data->{_id};
    my $f001 = 'H' . $sysnumber;
    $f001 =~ s/^H0/H/g;
    my $f035 = '(HAN)' . $sysnumber . 'DSV05';
     
    # Feld 035 mit HAN-Systemnummer hinzufügen     
    $data = marc_add($data,'001','_', $f001);
    $data = marc_add($data,'035','a', $f035);
        
    $exporter->add($data);
});

$exporter->commit;


exit;

