#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-leichenreden.fix < /opt/data/dsv01/leichen.seq > dsv01-export-leichenreden.csv
exit 0
