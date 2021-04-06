#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv12-export.fix < /opt/data/dsv12/dsv12fj.seq > dsv12-690.csv
exit 0
