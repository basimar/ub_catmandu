#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-doppelte-710.fix < /opt/data/dsv01.seq > dsv01-export-doppelte-710.csv
exit 0
