#!/bin/bash

# run all test 
for i in `ls test??.sub`; do
    sbatch $i
done

# run dependency test
bash test10.sh

# collect stats info
bash stats.sh
