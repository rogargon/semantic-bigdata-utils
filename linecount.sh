#!/bin/bash

usage="
        Parallelized line count script using GNU Parallel. 
        Contact: http://rhizomik.net/~roberto/
        
        Usage: 
                $(basename "$0") filename
"

filename="${1%.*}"
extension="${1##*.}"
regex="(.*[^ ])[ ]+<[^ ]+>.*"
size="--block-size 100M"

if [ $# = 1 ]
then
        if [ -f "$1" ]
        then
                cat $1 | parallel  --pipe $size wc -l | awk '{s+=$1} END {print s}'
        else
                echo "$usage"
                echo "  Error: file '$1' not found."
                echo ""
        fi
else
        echo "$usage"
fi
