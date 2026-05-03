program ou_parallel
    use omp_lib
    implicit none

    ! Parameters (Constants)
    real(8), parameter :: dt = 0.01_8, theta = 0.7_8, mu = 1.2_8, sigma = 0.3_8
    integer, parameter :: n_steps = 1000         
    
    
    integer :: i, j, n_simulations
    real(8) :: t1, t2, x, r1, r2, dw, total_sum, dt_sqrt
    character(len=32) :: arg

 
    if (command_argument_count() >= 1) then
        call get_command_argument(1, arg)
        read(arg, *) n_simulations
    else
        n_simulations = 1000000 
    end if

    dt_sqrt = sqrt(dt)
    total_sum = 0.0_8
    
    t1 = omp_get_wtime()

    !$omp parallel do private(i, j, x, r1, r2, dw) reduction(+:total_sum)
    do i = 1, n_simulations
        x = 1.0_8 
        do j = 1, n_steps
            call random_number(r1)
            call random_number(r2)
            ! Box-Muller transform
            dw = sqrt(-2.0_8 * log(r1)) * cos(2.0_8 * 3.1415926535_8 * r2)
            x = x + theta * (mu - x) * dt + sigma * dw * dt_sqrt
        end do
        total_sum = total_sum + x
    end do
    !$omp end parallel do

    t2 = omp_get_wtime()
    
    print *, "Parallel Mean:", total_sum / n_simulations
    print *, "Parallel Time:", t2 - t1, "s"
end program ou_parallel
