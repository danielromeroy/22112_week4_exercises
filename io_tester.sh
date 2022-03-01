#!/usr/bin/env bash

# TEST PERFORMANCE OF DIFFERENT COPY/WRITE METHODS

tests_per_file=3

GENOME_PATH='/path/to/genome/human.fsa'
COPY_PATH='/destination/genome/path/human.fsa'
RESULTS_FILE='/destination/results/file.txt'
FILES_LOCATION='/pyhton/scripts/location/'

files=('method1_forlineinfile.py' 'method2_whileloop.py' 'method3_forlineinfile_binary.py'
      'method4_chunk_10000.py' 'method4_chunk_100000.py')

> $RESULTS_FILE

for (( i=1; i <= tests_per_file; ++i )); do
    for ((j=0; j<${#files[@]}; ++j )); do
        echo "Testing ${files[$j]} for the ${i}'th time"
        echo -n "N $i ${files[$j]}" >> $RESULTS_FILE
        (time python "$FILES_LOCATION${files[$j]}") &>> $RESULTS_FILE
        rm $COPY_PATH
    done

    echo "Testing unix copy for the ${i}'th time"
    echo -n "N $i unixcopy" >> $RESULTS_FILE
    (time cp $GENOME_PATH $COPY_PATH) &>> $RESULTS_FILE
    rm $COPY_PATH
done


