#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-free.fix < /opt/data/dsv01/free2.seq > dsv01-export-free2.csv
exit 0
