#!/bin/bash

usage="
        Parallelized script using GNU Parallel and Perl that removes newlines inside rdf:Descriptions, 
	thus getting each rdf:Description in one line in the output RDF/XML. 
        Contact: http://rhizomik.net/~roberto/
        
        Usage example: 
                xzcat file.rdf.xz | ./$(basename "$0") | pbzip2 > file.rdf.bz2
"

regex="^(?!\s*<\/rdf\:Description\>|\s*<rdf\:RDF|\s*<\/owl\:Ontology\>)(.*)\n+$"
sizes="--block-size 10M"

if [ "$1" == "-h" ]
then
	echo "$usage"
else
	parallel -k --pipe $sizes perl -p -e "'s/"$regex"/\1/p'"
fi
