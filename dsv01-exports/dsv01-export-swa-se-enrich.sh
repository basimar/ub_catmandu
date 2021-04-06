#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-swa-se-enrich.fix < /opt/data/dsv01/swa_3.seq > dsv01-export-swa-3.csv
exit 0
