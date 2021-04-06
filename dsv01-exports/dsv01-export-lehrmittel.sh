#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-lehrmittel.fix < /opt/data/dsv01/lehrmittel.seq > dsv01-export-lehrmittel.csv
exit 0
