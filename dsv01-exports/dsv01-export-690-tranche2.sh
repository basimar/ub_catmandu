#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-690-be-tranche2.fix < /opt/data/dsv01/dsv01.seq > dsv01-export-690-be-tranche2.csv
exit 0
