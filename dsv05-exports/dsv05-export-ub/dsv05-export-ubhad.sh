#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to XLSX  --fields '_id,institution,signatur,stufe,titel,person,corporate,congress,jahr_von,jahr_bis,umfang,entstehungsort,link,code' --fix /opt/scripts/catmandu/dsv05-exports/dsv05-export-ub/dsv05-export-ubhad.fix < /opt/data/dsv05/dsv05.seq > /opt/scripts/catmandu/dsv05-exports/dsv05-export-ub/dsv05-export-ubhad.xlsx
scp /opt/scripts/catmandu/dsv05-exports/dsv05-export-ub/dsv05-export-ubhad.xlsx repro@ub-reprofiler:/scratch/reprodigi/ZZZ_Download/listen/VERZ_DSV05-Export-UB_bmt.xlsx 
exit 0
