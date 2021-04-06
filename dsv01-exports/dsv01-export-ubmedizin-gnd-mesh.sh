#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char '|' --fix dsv01-export-ubmedizin-gnd-mesh.fix < /opt/data/dsv01/dsv01.a140mesh.seq > dsv01-export-ubmedizin-gnd-mesh.csv
exit 0
