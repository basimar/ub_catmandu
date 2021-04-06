#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-690.fix < /opt/data/dsv01/mdk_analytica.seq > dsv01-export-690-mdk-analytica.csv
exit 0
