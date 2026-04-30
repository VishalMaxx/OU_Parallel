import matplotlib.pyplot as plt
import os

def get_data(filename):
    threads, times = [], []
    with open(filename, 'r') as f:
        next(f) 
        for line in f:
            t, tm = line.strip().split(',')
            threads.append(int(t))
            times.append(float(tm))
    
    t1 = times[0]
    speedup = [t1 / tm for tm in times]
    return threads, speedup


t1, s1 = get_data('results/results_1000000.csv')
t2, s2 = get_data('results/results_2000000.csv')

plt.figure(figsize=(10, 6))
plt.plot(t1, t1, 'k--', label='Ideal Scaling', alpha=0.7)
plt.plot(t1, s1, 'o-', label='1M Simulations', color='#0072B2')
plt.plot(t2, s2, 's-', label='2M Simulations', color='#D55E00')

plt.xlabel('Number of Threads')
plt.ylabel('Speedup (T1 / Tn)')
plt.title('Strong Scaling Analysis: Monte Carlo OU Process')
plt.legend()
plt.grid(True, ls="-", alpha=0.5)

os.makedirs('results/plots', exist_ok=True)
plt.savefig('results/plots/scaling_comparison.png')
print("Success: Plot saved to results/plots/scaling_comparison.png")
