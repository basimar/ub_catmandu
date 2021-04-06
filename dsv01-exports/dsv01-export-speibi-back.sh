#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-speibi-back.fix < speibi-back.seq > dsv01-export-speibi-back.csv
exit 0
