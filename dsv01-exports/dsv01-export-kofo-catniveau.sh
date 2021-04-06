#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-kofo-catniveau.fix < /opt/data/dsv01/niveau.seq > dsv01-export-kofo-catniveau.csv
exit 0
