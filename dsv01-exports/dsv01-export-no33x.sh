#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-no336.fix < /opt/data/dsv01/dsv01_ohne_erwerbung.seq > dsv01-export-no336.csv
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-no337.fix < /opt/data/dsv01/dsv01_ohne_erwerbung.seq > dsv01-export-no337.csv
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-no338.fix < /opt/data/dsv01/dsv01_ohne_erwerbung.seq > dsv01-export-no338.csv
exit 0
