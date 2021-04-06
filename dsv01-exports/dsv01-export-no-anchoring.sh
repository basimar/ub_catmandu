#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-no-anchoring.fix < /opt/data/dsv01/no_anchoring.seq > dsv01-export-no-anchoring.csv
exit 0
