program ou_serial
    implicit none
    integer, parameter :: n_simulations = 1000000 
    integer, parameter :: n_steps = 1000         
    real(8), parameter :: dt = 0.01_8, theta = 0.7_8, mu = 1.2_8, sigma = 0.3_8
    real(8) :: t1, t2, x, r1, r2, dw, total_sum, dt_sqrt
    integer :: i, j

    dt_sqrt = sqrt(dt)
    total_sum = 0.0_8
    call cpu_time(t1)

    do i = 1, n_simulations
        x = 1.0_8 
        do j = 1, n_steps
            call random_number(r1)
            call random_number(r2)
            ! Trying with Box-Muller transform for Gaussian Noise
            dw = sqrt(-2.0_8 * log(r1)) * cos(2.0_8 * 3.1415926535_8 * r2)
            x = x + theta * (mu - x) * dt + sigma * dw * dt_sqrt
        end do
        total_sum = total_sum + x
    end do

    call cpu_time(t2)
    print *, "Serial Mean:", total_sum / n_simulations
    print *, "Serial Time:", t2 - t1, "s"
end program ou_serial
