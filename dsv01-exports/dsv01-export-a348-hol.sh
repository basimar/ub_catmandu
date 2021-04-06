#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-a348-hol.fix < /opt/data/dsv01/a348_hol.seq > dsv01-export-a348-hol.csv
exit 0
