#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-noLDR.fix < /opt/data/dsv01/dsv01_test.seq > dsv01-export-noLDR.csv
exit 0
