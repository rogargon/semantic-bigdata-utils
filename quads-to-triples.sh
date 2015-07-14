#!/bin/bash

usage="
        Parallelized RDF NQuads to NTriples conversion script using GNU Parallel. 
        Contact: http://rhizomik.net/~roberto/
        
        Usage: 
                $(basename "$0") filename.[nq|nquads]
"

filename="${1%.*}"
extension="${1##*.}"
regex="(.*[^ ])[ ]+<[^ ]+>.*"
sizes="--block-size 10M -L 100000"

if [ $# = 1 ]
then
        if [ -f "$1" ]
        then
                if [ $extension = "nq" ] || [ $extension = "nquads" ]
                then
                        cat $1 | parallel --pipe $sizes sed -rn "'s/"$regex"/\1 ./p'" > $filename.nt
                else
                        echo "$usage"
                        echo "  Error: input file extension should be '.nq' or '.nquads'"
                        echo ""
                fi
        else
                echo "$usage"
                echo "  Error: file '$1' not found."
                echo ""
        fi
else
        echo "$usage"
fi