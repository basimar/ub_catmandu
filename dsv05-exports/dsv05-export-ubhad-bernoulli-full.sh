#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to MARC --type ALEPHSEQ --fix dsv05-export-ubhad-bernoulli-full.fix < /opt/data/dsv05/dsv05.seq > dsv05-export-ubhad-bernoulli.seq
exit 0
