#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-linkcheck.fix < linkchecking > VERZ_dsv01-export-linkcheck.csv
exit 0
