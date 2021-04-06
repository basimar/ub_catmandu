#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-analytica-ohne-link.fix < /opt/data/dsv01/dsv01.773ohnesys.seq > dsv01-export-analytica-ohne-link.csv
exit 0
