#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to XLSX  --fields '_id,institution,signature,year_beginning,year_end,language,creator,contributor,place_original,place_norm' --fix /opt/scripts/catmandu/dsv05-exports/dsv05-export-ubhad-bernoulli-emlo/dsv05-export-ubhad-bernoulli-emlo.fix < /opt/data/dsv05/dsv05.seq > /opt/scripts/catmandu/dsv05-exports/dsv05-export-ubhad-bernoulli-emlo/dsv05-export-ubhad-bernoulli-emlo.xlsx
exit 0
