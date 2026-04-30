import matplotlib.pyplot as plt
import os

def load_csv(path):
    t, tm = [], []
    with open(path, 'r') as f:
        next(f)
        for line in f:
            parts = line.strip().split(',')
            t.append(int(parts[0])); tm.append(float(parts[1]))
    return t, tm

# Strong Scaling Plot
t_s, tm_s = load_csv('results/data/strong_scaling.csv')
speedup = [tm_s[0]/x for x in tm_s]
plt.figure(figsize=(8, 5))
plt.plot(t_s, t_s, 'k--', label='Ideal')
plt.plot(t_s, speedup, 'o-', label='Measured Speedup')
plt.title('Strong Scaling (Fixed Load: 1M)')
plt.xlabel('Threads'); plt.ylabel('Speedup'); plt.legend(); plt.grid()
plt.savefig('results/plots/strong_scaling.png')

# Weak Scaling Plot
t_w, tm_w = load_csv('results/data/weak_scaling.csv')
efficiency = [tm_w[0]/x for x in tm_w] 
plt.figure(figsize=(8, 5))
plt.plot(t_w, [1.0]*len(t_w), 'k--', label='Ideal (Constant Time)')
plt.plot(t_w, efficiency, 's-', color='orange', label='Efficiency')
plt.title('Weak Scaling (1M per Thread)')
plt.xlabel('Threads'); plt.ylabel('Efficiency (T1 / Tn)'); plt.legend(); plt.grid()
plt.savefig('results/plots/weak_scaling.png')
