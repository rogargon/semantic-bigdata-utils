#!/bin/bash

usage="
        Parallelized script using GNU Parallel and Rapper to serialize input RDF/XML to N-Triples 
	Important: input RDF/XML must have a full rdf:Description per line. 
        Contact: http://rhizomik.net/~roberto/
        
        Usage examples: 
                pbzcat file.rdf.bz2 | ./$(basename "$0") http://base.org/ | gzip > file.nt.gz

		pbzcat file.rdf.bz2 | ./$(basename "$0") http://base.org/ | split -a 3 -d -l 100000000 --additional-suffix=.nt --filter='gzip > $FILE.gz' - file-
"

size="--block-size 100M"

if [ "$1" == "-h" ]
then
        echo "$usage"
else
	parallel --header 1 --pipe $size rapper -f relativeURIs=0 -o ntriples - \'$1\'
fi
