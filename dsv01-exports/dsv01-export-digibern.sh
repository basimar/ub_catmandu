#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-digibern.fix < /opt/data/dsv01/digibern.seq > dsv01-export-digibern.csv
exit 0
