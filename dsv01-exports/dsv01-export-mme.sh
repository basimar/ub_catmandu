#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to MARC --type ALEPHSEQ --fix dsv01-export-mme.fix < /opt/data/dsv01/dsv01.seq > dsv01-export-mme.csv
exit 0
