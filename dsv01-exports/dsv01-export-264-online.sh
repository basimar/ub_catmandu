#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-264-online.fix < /opt/data/dsv01/264onl.seq> dsv01-export-264-online.csv
exit 0
