#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-ebook-delete.fix < /opt/data/dsv01/dsv01.seq > dsv01-export-ebook-delete.csv
exit 0
