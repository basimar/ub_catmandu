#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to XLSX  --fields '_id,institution,signatur,stufe,titel,jahr_von,jahr_bis,umfang,fussnote,link,code' --fix /opt/scripts/catmandu/dsv05-exports/dsv05-export-kbar.fix < /opt/data/dsv05/dsv05.seq > /opt/scripts/catmandu/dsv05-exports/dsv05-export-kbar.xlsx
exit 0
