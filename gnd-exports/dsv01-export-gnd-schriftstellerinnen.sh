#!/bin/bash
catmandu convert MARC --type XML to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-gnd-schriftstellerinnen.fix < ../dsv01-exports/6xx-nots/authorities-person_dnbmarc_20200213.mrc.xml > dsv01-export-gnd-schriftstellerinnen.csv
exit 0
