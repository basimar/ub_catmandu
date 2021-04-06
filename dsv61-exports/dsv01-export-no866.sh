#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-no866.fix < /opt/data/dsv61/dsv61.seq > dsv01-export-no866.csv
exit 0
