#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-unikat.fix < /opt/data/dsv01/019unikat.seq > dsv01-export-unikat-019.csv
exit 0
