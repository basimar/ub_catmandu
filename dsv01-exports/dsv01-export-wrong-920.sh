#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-wrong-920.fix < /opt/data/dsv01/dsv01_ohne_erwerbung.seq > dsv01-export-wrong-920.csv
exit 0
