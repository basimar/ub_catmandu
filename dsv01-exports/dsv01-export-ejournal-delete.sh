#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-ejournal-delete.fix < dsv01-export-ejournal-delete-2.seq > dsv01-export-ejournal-delete-2.csv
exit 0
