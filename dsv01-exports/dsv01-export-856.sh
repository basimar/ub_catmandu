#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-856.fix < /opt/data/dsv01/856.seq > dsv01-export-856.csv
exit 0
