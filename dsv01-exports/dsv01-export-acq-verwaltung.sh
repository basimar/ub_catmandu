#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fields _id,ldr,fmt,f019,f040,f245,f909,f655,f906,f907 --fix dsv01-export-acq-verwaltung.fix < /opt/data/dsv01/verwaltung.seq > dsv01-export-acq-verwaltung.csv
exit 0
