#!/bin/bash
catmandu convert MARC --type XML to MARC --type ALEPHSEQ  < /opt/data/dsv01/dsv01.xml > dsv01-transform-xml2seq.seq
exit 0
