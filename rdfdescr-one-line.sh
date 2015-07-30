#!/bin/bash

usage="
        Parallelized script using GNU Parallel and Perl removing newlines inside rdf:Descriptions, 
	thus getting each rdf:Description in one line in the output RDF/XML. 
        Contact: http://rhizomik.net/~roberto/
        
        Usage: 
                $(basename "$0") filename.rdf
"

filename="${1%.*}"
extension="${1##*.}"
regex="^(?!\s*<\/rdf\:Description\>|\s*<rdf\:RDF|\s*<\/owl\:Ontology\>)(.*)\n+$"
sizes="--block-size 10M"

if [ $# = 1 ]
then
        if [ -f "$1" ]
        then
                if [ $extension = "rdf" ]
                then
                        cat $1 | parallel -k --pipe $sizes perl -p -e "'s/"$regex"/\1/p'" > $filename.ll.rdf
                else
                        echo "$usage"
                        echo "  Error: input file extension should be '.rdf'"
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
