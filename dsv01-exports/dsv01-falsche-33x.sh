#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-falsche-33x.fix < /opt/data/dsv01/falsche-33x.seq > dsv01-falsche-33x.csv
exit 0
