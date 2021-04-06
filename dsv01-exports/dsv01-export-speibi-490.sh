#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-speibi-490.fix < speibi-490.seq > dsv01-export-speibi-490.csv
exit 0
