# Parallel Monte Carlo OU Process
High-performance simulation of the Ornstein-Uhlenbeck process using Fortran and OpenMP.

## Performance Analysis
The project includes strong scaling analysis for 1M and 2M simulations.
Results are located in `results/data/` and plots in `results/plots/`.

## To Run
1. `gfortran -fopenmp src/parallel.f90 -o ou_sim`
2. `./ou_sim [num_simulations]`
