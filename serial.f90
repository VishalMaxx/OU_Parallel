program ou_simulation
    use omp_lib
    implicit none

    integer, parameter :: n_simulations = 1000000 
    integer, parameter :: n_steps = 1000         
    real(8), parameter :: dt = 0.01_8            
    real(8), parameter :: theta = 0.7_8          
    real(8), parameter :: mu = 1.2_8             
    real(8), parameter :: sigma = 0.3_8          
    
    real(8) :: start_time, end_time, dt_sqrt
    integer :: i, j
    real(8) :: total_sum, x, dw
    real(8), dimension(:), allocatable :: random_vals

    dt_sqrt = sqrt(dt)
    total_sum = 0.0_8
    start_time = omp_get_wtime()

    do i = 1, n_simulations
        x = 1.0_8 ! Initial value X0
        
        do j = 1, n_steps
            call random_number(dw) 
            dw = (dw - 0.5_8) * sqrt(12.0_8) 
            
            x = x + theta * (mu - x) * dt + sigma * dw * dt_sqrt
        end do
        
        total_sum = total_sum + x
    end do

    end_time = omp_get_wtime()
    
    print *, "Average Final X:", total_sum / n_simulations
    print *, "Execution Time (Serial):", end_time - start_time, "seconds"

end program ou_simulation
