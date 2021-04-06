#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-fdbbs.fix < /opt/data/dsv01/dsv01.fdbbs.seq > dsv01-export-fdbbs.csv
exit 0
