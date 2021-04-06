#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-a214.fix < /opt/data/dsv01/dsv01.a214.bearb.seq > dsv01-export-a214-2.csv
exit 0
