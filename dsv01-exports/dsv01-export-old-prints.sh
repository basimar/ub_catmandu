#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-old-prints.fix < /opt/data/dsv01/008-2.seq > dsv01-export-old-prints.csv
exit 0
