#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv05-export-format.fix < /opt/data/dsv05/dsv05_fd906.seq > dsv05-export-format.csv
exit 0
