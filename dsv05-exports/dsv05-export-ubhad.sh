#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV  --fix dsv05-export-ubhad.fix < /opt/data/dsv05/dsv05.seq > dsv05-export-ubhad.csv
exit 0
