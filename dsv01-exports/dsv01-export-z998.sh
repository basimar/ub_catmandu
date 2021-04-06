#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-z998.fix < /opt/data/dsv01/z998.seq > dsv01-export-z998.csv
exit 0
