#!/bin/bash
# Compile
gfortran -fopenmp src/parallel.f90 -o src/ou_Parallel

for sims in 1000000 2000000
do
    echo "Running $sims simulations..."
    FILE="results/results_${sims}.csv"
    echo "Threads,Time" > $FILE
    for t in 1 2 4 8
    do
        export OMP_NUM_THREADS=$t
        TIME=$(./src/ou_parallel $sims | grep "Parallel Time" | awk '{print $3}')
        echo "$t,$TIME" >> $FILE
    done
done
