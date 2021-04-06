#!usr/bin/env perl

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

# Catmandu-Module
use Catmandu::Importer::MARC::ALEPHSEQ;
use Catmandu::Exporter::MARC::ALEPHSEQ;
use Catmandu::Fix::Inline::marc_map qw(:all);
use Catmandu::Fix::Inline::marc_add qw(:all);

my $filename = $ARGV[0];
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

my %tags = (


'016 7' , '0167 ' ,
'019 7' , '019  ' ,
'019\\ ' , '019  ' ,
'0190 ' , '019  ' ,
'01900' , '019  ' ,
'01911' , '019  ' ,
'0197 ' , '019  ' ,
'019a ' , '019  ' ,
'0220 ' , '022  ' ,
'02410' , '0241 ' ,
'02420' , '0242 ' ,
'02430' , '0243 ' ,
'02431' , '0243 ' ,
'02434' , '0243 ' ,
'02470' , '0247 ' ,
'02471' , '0247 ' ,
'0280 ' , '02800' ,
'0281 ' , '02810' ,
'0282 ' , '02820' ,
'0283 ' , '02830' ,
'0284 ' , '02840' ,
'0285 ' , '02850' ,
'035i ' , '035  ' ,
'04111' , '0411 ' ,
'04112' , '0411 ' ,
'04117' , '0411 ' ,
'0440 ' , '044  ' ,
'0500 ' , '050 0' ,
'0501 ' , '05010' ,
'050-4' , '050 4' ,
'060 7' , '060 0' ,
'070  ' , '0700 ' ,
'072  ' , '072 7' ,
'072 2' , '072 7' ,
'072 a' , '072 7' ,
'072 A' , '072 7' ,
'072^7' , '072 7' ,
'07207' , '072 7' ,
'0721 ' , '072 7' ,
'0722 ' , '072 7' ,
'07227' , '072 7' ,
'07247' , '072 7' ,
'0727 ' , '072 7' ,
'072-7' , '072 7' ,
'07277' , '072 7' ,
'072a7' , '072 7' ,
'072D7' , '072 7' ,
'072p7' , '072 7' ,
'072v7' , '072 7' ,
'072w7' , '072 7' ,
'082  ' , '0820 ' ,
'082 0' , '0820 ' ,
'082 1' , '0821 ' ,
'082 2' , '0820 ' ,
'082 4' , '08204' ,
'082 7' , '0827 ' ,
'08201' , '0820 ' ,
'08209' , '0820 ' ,
'08211' , '0821 ' ,
'08217' , '0821 ' ,
'0822 ' , '0820 ' ,
'0823 ' , '0820 ' ,
'082DS' , '0820 ' ,
'083  ' , '0830 ' ,
'084 4' , '084  ' ,
'084 7' , '084  ' ,
'0840 ' , '084  ' ,
'08400' , '084  ' ,
'0841 ' , '084  ' ,
'0844 ' , '084  ' ,
'130  ' , '1300 ' ,
'13000' , '1300 ' ,
'1301 ' , '1300 ' ,
'13010' , '1300 ' ,
'210  ' , '2101 ' ,
'222  ' , '222 0' ,
'240  ' , '24010' ,
'240 0' , '24010' , 
'24000' , '24010' ,
'2401 ' , '24010' ,
'24011' , '24010' ,
'245 1' , '24510' ,
'24501' , '24510' ,
'2451 ' , '24510' ,
'2451#' , '24510' ,
'246 1' , '24610' ,
'246 3' , '24613' ,
'246 4' , '24614' ,
'246 8' , '24618' ,
'24600' , '24610' ,
'24601' , '24611' ,
'24602' , '24612' ,
'24603' , '24613' ,
'24604' , '24614' ,
'24605' , '24615' ,
'24606' , '24616' ,
'24608' , '24618' ,
'2461 ' , '24610' ,
'2461O' , '24610' ,
'24620' , '24610' ,
'24621' , '24611' ,
'24623' , '24613' ,
'24624' , '24614' ,
'24626' , '24616' ,
'2463 ' , '24613' ,
'24630' , '24610' ,
'24631' , '24611' ,
'24632' , '24612' ,
'24633' , '24613' ,
'24634' , '24614' ,
'24635' , '24615' ,
'24636' , '24616' ,
'24638' , '24618' ,
'247  ' , '24710' ,
'24700' , '24710' ,
'2471 ' , '24710' ,
'24711' , '24710' ,
'2500 ' , '250  ' ,
'25000' , '250  ' ,
'25080' , '250  ' ,
'250A0' , '250  ' ,
'254 3' , '254  ' ,
'256 1' , '256  ' ,
'256 3' , '256  ' ,
'263  ' , '     ' ,
'264  ' , '264 1' ,
'264|1' , '264 1' ,
'264|4' , '264 4' ,
'26400' , '264 0' ,
'26401' , '264 1' ,
'26404' , '264 4' ,
'2641 ' , '264 1' ,
'26410' , '264 1' ,
'26411' , '264 1' ,
'26413' , '264 3' ,
'2643 ' , '264 1' ,
'2644 ' , '264 4' ,
'300 _' , '300  ' ,
'300 2' , '300  ' ,
'300 4' , '300  ' ,
'300 a' , '300  ' ,
'300 B' , '300  ' ,
'300. ' , '300  ' ,
'3000 ' , '300  ' ,
'30000' , '300  ' ,
'3001 ' , '300  ' ,
'3004 ' , '300  ' ,
'300d ' , '300  ' ,
'3101 ' , '300  ' ,
'3360 ' , '336  ' ,
'362  ' , '3620 ' ,
'362 0' , '3620 ' ,
'3621 ' , '3620 ' ,
'3650 ' , '365  ' ,
'3650D' , '365  ' ,
'490  ' , '4900 ' ,
'490 1' , '4900 ' ,
'49000' , '4900 ' ,
'49003' , '4900 ' ,
'49009' , '4900 ' ,
'4900J' , '     ' ,
'4900o' , '4900 ' ,
'4901 ' , '4900 ' ,
'500 $' , '500  ' ,
'500 0' , '500  ' ,
'500 1' , '500  ' ,
'500 7' , '500  ' ,
'5000 ' , '500  ' ,
'50010' , '500  ' ,
'502_ ' , '502  ' ,
'5020 ' , '502  ' ,
'50200' , '502  ' ,
'5021 ' , '502  ' ,
'5022 ' , '502  ' ,
'505  ' , '50500' ,
'505 0' , '50500' ,
'509 1' , '509  ' ,
'50900' , '509  ' ,
'5091 ' , '509  ' ,
'510 4' , '5104 ' ,
'520Ac' , '520AC' ,
'520Am' , '520AM' ,
'524- ' , '524  ' ,
'524 7' , '524  ' ,
'524-7' , '524  ' ,
'5461 ' , '546  ' ,
'5500 ' , '550  ' ,
'5902 ' , '590  ' ,
'590FC' , '690FC' ,
'590FJ' , '690FJ' ,
'591FY' , '691FY' ,
'599 7' , '599  ' ,
'600 D' , '690D ' ,
'600 S' , '600S ' ,
'600 Z' , '600Z ' ,
'600-7' , '60017' ,
'600A8' , '690A8' ,
'600AH' , '690AH' ,
'600AW' , '690AW' ,
'600D5' , '600D ' ,
'600D7' , '600D ' ,
'600Da' , '600D ' ,
'600FJ' , '690FJ' ,
'600NN' , '     ' ,
'600S7' , '600S ' ,
'600TS' , '600T ' ,
'600z ' , '600Z ' ,
'610 4' , '61024' ,
'610 D' , '610D ' ,
'610 Z' , '610Z ' ,
'610TS' , '610T ' ,
'611 0' , '61120' ,
'611 7' , '61127' ,
'611 S' , '611S ' ,
'611|7' , '61127' ,
'611-7' , '61127' ,
'630 0' , '63000' ,
'630 1' , '63001' ,
'630 2' , '63002' ,
'630 4' , '63004' ,
'630 6' , '63006' ,
'630 7' , '63007' ,
'630-0' , '63000' ,
'63017' , '63007' ,
'630-7' , '63007' ,
'630TS' , '630T ' ,
'64807' , '648 7' ,
'64817' , '648 7' ,
'6487 ' , '648 7' ,
'650  ' , '650D ' ,
'650 D' , '650D ' ,
'650 S' , '650S ' ,
'650 t' , '650T ' ,
'650 z' , '650Z ' ,
'650 Z' , '650Z ' ,
'650#2' , '650 2' ,
'650.2' , '650 2' ,
'650.7' , '650 7' ,
'650_0' , '650 0' ,
'6500 ' , '650 0' ,
'650-0' , '650 0' ,
'65000' , '650 0' ,
'65002' , '650 2' ,
'65004' , '650 4' ,
'65007' , '650 7' ,
'65012' , '650 2' ,
'65014' , '650 4' ,
'65017' , '650 7' ,
'650-2' , '650 2' ,
'65022' , '650 2' ,
'65024' , '650 4' ,
'65026' , '650 6' ,
'65027' , '650 7' ,
'6507 ' , '650 7' ,
'650-7' , '650 7' ,
'65070' , '650 7' ,
'65077' , '650 7' ,
'650d ' , '650D ' ,
'650D_' , '650D ' ,
'650D3' , '650D ' ,
'650Da' , '650D ' ,
'650DB' , '650D ' ,
'650Dc' , '650D ' ,
'650DD' , '650D ' ,
'650De' , '650D ' ,
'650Do' , '650D ' ,
'650Dq' , '650D ' ,
'650DS' , '650D ' ,
'650DU' , '650D ' ,
'650DX' , '650D ' ,
'650E ' , '650D ' ,
'650F ' , '650D ' ,
'650FC' , '690FC' ,
'650TR' , '650T ' ,
'650TS' , '650T ' ,
'650z ' , '650Z ' ,
'651  ' , '651D ' ,
'651 D' , '651D ' ,
'651 S' , '651S ' ,
'6510 ' , '651 0' ,
'651-0' , '651 0' ,
'65112' , '651 2' ,
'651-2' , '651 2' ,
'651-7' , '651 7' ,
'65170' , '651 7' ,
'651d ' , '651D ' ,
'651TS' , '651T ' ,
'653- ' , '653  ' ,
'653 |' , '653  ' ,
'653 7' , '653  ' ,
'65502' , '655 2' ,
'65504' , '655 4' ,
'65507' , '655 7' ,
'65512' , '655 2' ,
'65517' , '655 7' ,
'6552 ' , '655 2' ,
'655-2' , '655 2' ,
'65522' , '655 2' ,
'6554 ' , '655 4' ,
'6557 ' , '655 7' ,
'655-7' , '655 7' ,
'65577' , '655 7' ,
'655S7' , '655 7' ,
'69 FH' , '691FH' ,
'690A1' , '     ' ,
'690A3' , '     ' ,
'690a8' , '690A8' ,
'690Aa' , '690AA' ,
'690Ad' , '690AD' ,
'690Af' , '690AF' ,
'690AJ' , '520AJ' ,
'690Ak' , '690AK' ,
'690AS' , '690AT' ,
'690Ax' , '690AX' ,
'690Ay' , '690AY' ,
'690b6' , '690B6' ,
'690bk' , '690BK' ,
'690bK' , '690BK' ,
'690Bk' , '690BK' ,
'690Bv' , '690BV' ,
'690FG' , '691FG' ,
'690FH' , '691FH' ,
'690FI' , '691FI' ,
'690FY' , '691FY' ,
'690Ga' , '690GA' ,
'690Gc' , '690GC' ,
'691Fb' , '691FB' ,
'691fg' , '691FG' ,
'691Fg' , '691FG' ,
'691Fh' , '691FH' ,
'691fy' , '691FY' ,
'691Fy' , '691FY' ,
'691GB' , '     ' ,
'691Gg' , '691GG' ,
'691gh' , '691GH' ,
'691Gp' , '691GP' ,
'692FY' , '691FY' ,
'700 2' , '70012' ,
'700 7' , '7001 ' ,
'7001`' , '7001 ' ,
'70011' , '7001 ' ,
'70014' , '7001 ' ,
'70015' , '7001 ' ,
'70017' , '7001 ' ,
'70018' , '7001 ' ,
'7001a' , '7001 ' ,
'7001A' , '7001 ' ,
'7001C' , '7001 ' ,
'7001J' , '7001 ' ,
'7001K' , '7001 ' ,
'7001l' , '7001 ' ,
'7001m' , '7001 ' ,
'7001n' , '7001 ' ,
'7001o' , '7001 ' ,
'7001s' , '7001 ' ,
'7001V' , '7001 ' ,
'7002 ' , '7001 ' ,
'700a ' , '7001 ' ,
'700l0' , '7001 ' ,
'71027' , '7102 ' ,
'730  ' , '7300 ' ,
'730 3' , '7300 ' ,
'7301 ' , '7300 ' ,
'730C ' , '7300 ' ,
'730o ' , '7300 ' ,
'740  ' , '7400 ' ,
'752D ' , '752  ' ,
'773 A' , '7730A' ,
'773 U' , '7730U' ,
'7731A' , '7730A' ,
'773AU' , '7730A' ,
'773OU' , '7730U' ,
'773-U' , '7730U' ,
'775  ' , '7750 ' ,
'7751 ' , '7750 ' ,
'77518' , '7750 ' ,
'776  ' , '7760 ' ,
'780 0' , '78000' ,
'78004' , '78001' ,
'78510' , '78500' ,
'78511' , '78501' ,
'787  ' , '7870 ' ,
'7871 ' , '7870 ' ,
'856 7' , '856  ' ,
'856 A' , '856  ' ,
'856A ' , '856  ' ,
'856 B' , '856  ' ,
'856 D' , '856  ' ,
'908A ' , '909A ' ,
'909 A' , '909A ' ,
'909 B' , '909B ' ,
'909a ' , '909A ' ,
'909A_' , '909A ' ,
'909b ' , '909B ' ,
'909B0' , '909B ' ,
'909Ba' , '909B ' ,
'909BB' , '909B ' ,
'909Be' , '909B ' ,
'909Bf' , '909B ' ,
'909Bk' , '909B ' ,
'909Bq' , '909B ' ,
'909BV' , '909B ' ,
'909D ' , '909DS' ,
'909Ds' , '909DS' ,
'909M;' , '909M ' ,
'909U ' , '909A ' ,
'909U1' , '909A ' ,
'909u2' , '909A ' ,
'909U2' , '909A ' ,
'909U3' , '909A ' ,
'909XY' , '909A ' ,
'909Z1' , '     ' ,
'909Z2' , '     ' ,
'949  ' , '     ' ,
'9700 ' , '970  ' ,
'97000' , '970  ' ,
'992  ' , '     ' ,
);

while (my $line = <$fh>) {
    chomp $line;
    my $sys = substr($line, 0, 9);
    my $tag = substr($line, 10, 5);
    my $subfields = substr($line, 18);
            
    my $change_line;
    my $newline;
    my $newrecord;
            
    if ($tag eq '019XX' && $subfields =~ /\$\$aU2I_W31: suspect indicator/) {
        $change_line = 1;
    }
           
    if ($tag eq '856 C') {
        $change_line = 1;
        $subfields =~ s/\$\$z.*?\$\$/\$\$/g;
        $subfields =~ s/\$\$z.*?$//g;
        $newline = $sys . ' 856   L ' . $subfields . '$$zInhaltsverzeichnis' . "\n";
    }
   
    for (keys %tags) {
        if ($_ eq $tag) {
            $newline = $sys . ' ' . $tags{$_} . ' L ' . $subfields . "\n" unless $tags{$_} eq '     ';
            $change_line = 1;
        }
    }
        
    if ($change_line) {
        print $newline . "\n";
    } else {
        print $line . "\n";
    }
      
    #print $line . "\n";
}


