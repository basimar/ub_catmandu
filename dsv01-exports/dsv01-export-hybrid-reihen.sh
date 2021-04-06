#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-hybrid-reihen.fix < hybrid-reihe.seq > dsv01-export-hybrid-reihen.csv
exit 0
