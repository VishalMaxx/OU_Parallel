#!/bin/bash
gfortran -fopenmp src/parallel.f90 -o src/ou_parallel
mkdir -p results/data

# 1. Strong Scaling (Fixed 1M total)
echo "Threads,Time" > results/data/strong_scaling.csv
for t in 1 2 4 8; do
    export OMP_NUM_THREADS=$t
    TIME=$(./src/ou_parallel 1000000 | grep "Parallel Time" | awk '{print $3}')
    echo "$t,$TIME" >> results/data/strong_scaling.csv
done

# 2. Weak Scaling (1M simulations PER THREAD)
echo "Threads,Time" > results/data/weak_scaling.csv
for t in 1 2 4 8; do
    export OMP_NUM_THREADS=$t
    SIMS=$((t * 1000000))
    TIME=$(./src/ou_parallel $SIMS | grep "Parallel Time" | awk '{print $3}')
    echo "$t,$TIME" >> results/data/weak_scaling.csv
done
