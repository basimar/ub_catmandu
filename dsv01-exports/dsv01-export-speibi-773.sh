#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-speibi-773.fix < speibi-773.seq > dsv01-export-speibi-773.csv
exit 0
