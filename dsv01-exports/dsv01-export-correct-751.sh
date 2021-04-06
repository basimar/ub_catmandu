#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-correct-751.fix < /opt/data/dsv01/751-2.seq > dsv01-export-correct-751.csv
exit 0
