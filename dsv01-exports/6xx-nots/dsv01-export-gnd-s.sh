#!/bin/bash
catmandu convert MARC --type XML to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-gnd-s.fix < authorities-sachbegriff_dnbmarc_20200213.mrc.xml > dsv01-export-gnd-s.csv
exit 0
