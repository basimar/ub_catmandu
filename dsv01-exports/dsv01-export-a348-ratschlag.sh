#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-a348-ratschlag.fix < /opt/data/dsv01/a348.items.seq > dsv01-export-a348-ratschlag.csv
exit 0
