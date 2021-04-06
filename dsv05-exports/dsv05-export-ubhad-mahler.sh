#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to MARC --type XML --pretty 1  --fix dsv05-export-ubhad-mahler.fix < /opt/data/dsv05/dsv05.seq > dsv05-export-ubhad-mahler.output 
exit 0
