#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-ubreligion-rvk.fix < /opt/data/dsv01/ubreligion.seq > dsv01-export-ubreligion-rvk.csv
exit 0
