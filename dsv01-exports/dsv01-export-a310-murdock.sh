#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-a310-murdock.fix < /opt/data/dsv01/murdock.seq > dsv01-export-a310-murdock.csv
exit 0
