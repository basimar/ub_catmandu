#!/bin/bash
catmandu convert MARC --type ALEPHSEQ --fix seq2m21.fix to MARC --type XML --fix dsv01-export-a125-ld.fix < /opt/data/dsv01/dsv01.seq > dsv01-export-a125-ld.xml
exit 0
