#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv05-export-ubhad-gII19.fix < /opt/data/dsv05/dsv05.seq > dsv05-export-ubhad-gII19.csv
exit 0
