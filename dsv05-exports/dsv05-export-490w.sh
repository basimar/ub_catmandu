#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv05-export-490w.fix < /opt/data/dsv05/dsv05.seq.sys_correction > dsv05-export-490w.csv
exit 0
