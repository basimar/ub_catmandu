#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-ggs-del.fix < /opt/data/dsv01/ggs.bibdel.seq > dsv01-export-ggs-del.csv
exit 0
