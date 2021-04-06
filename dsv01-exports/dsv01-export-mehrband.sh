#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-mehrband.fix < /opt/data/dsv01/mehrband.seq > dsv01-export-mehrband.csv
exit 0
