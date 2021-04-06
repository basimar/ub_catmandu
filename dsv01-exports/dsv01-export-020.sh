#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-020.fix < /opt/data/dsv01/020.seq > dsv01-export-020.csv
exit 0
