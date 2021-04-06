#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-bbort.fix < /opt/data/dsv01/bbort.seq > dsv01-export-bb-bbort.csv
exit 0
