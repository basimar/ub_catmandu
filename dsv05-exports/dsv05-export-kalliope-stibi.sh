#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to MARC --type ALEPHSEQ --fix dsv05-export-kalliope-stibi.fix < /opt/data/dsv05/dsv05.seq > dsv05-export-kalliope-stibi.seq
exit 0
