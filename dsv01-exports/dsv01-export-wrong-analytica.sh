#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-wrong-analytica.fix < /opt/data/dsv01/wrongana.seq> dsv01-export-wrong-analytica.csv
exit 0
