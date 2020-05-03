#!/bin/sh

page=$PAGER
export PAGER=cat
book=$(kjv -l | awk 'NF>1{print $NF}' | tr -d '()' | xargs shuf -n1 -e)
chapter=$(kjv "$book" | grep -E "[0-9]+:[0-9]+" | awk '{split($0,a,":"); print a[1]}' | xargs shuf -n1 -e)
verse=$(kjv "$book":"$chapter" | grep -E "[0-9]+:[0-9]+" | awk '{print $1}' | awk '{split($0,a,":"); print a[2]}'| xargs shuf -n1 -e)
kjv "$book":"$chapter":"$verse"
vul "$book":"$chapter":"$verse"
export PAGER=$page