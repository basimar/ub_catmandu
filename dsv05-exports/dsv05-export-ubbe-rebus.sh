#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to MARC --type ALEPHSEQ --fix dsv05-export-ubbe-rebus.fix < /opt/data/dsv05/dsv05.seq > dsv05-export-ubbe-rebus.seq
exit 0
