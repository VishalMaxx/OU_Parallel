import matplotlib.pyplot as plt

threads = [1, 2, 4, 8]
times = [75.25, 38.99, 21.99, 11.97]
speedup = [times[0] / t for t in times]

plt.figure(figsize=(8, 5))
plt.plot(threads, speedup, 'o-', label='Measured Speedup', color='#E6B800') # Sirius Yellow-ish
plt.plot(threads, threads, '--', label='Ideal Speedup', color='black')
plt.xlabel('Number of Threads')
plt.ylabel('Speedup')
plt.title('Strong Scaling Analysis: OU Process Monte Carlo')
plt.legend()
plt.grid(True)
plt.savefig('scaling_plot.png')
print("Plot saved as scaling_plot.png")
