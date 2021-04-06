#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-minimal.fix < /opt/data/dsv01/dsv01.seq > dsv01-export-minimal.csv
exit 0
