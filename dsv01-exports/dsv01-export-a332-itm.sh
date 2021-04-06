#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fields _id,leader,f007,f008,f028,f090,f245,f246,f264,f300,f336,f505,f511,f508,f100,f700,f920,standort,signatur --fix dsv01-export-a332-itm.fix < /opt/data/dsv01/itma332.seq > dsv01-export-export-a332.csv
exit 0
