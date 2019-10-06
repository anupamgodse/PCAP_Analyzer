import os
import matplotlib.pyplot as plt
plt.figure(figsize=(8,7))

path="../data/times/"
for f in os.listdir(path):
    protocol = f.split('.')[0] 
    times = []
    with open(path+f) as fl:
        for line in fl:
            t = line.split()
            for each in t:
                times.append(int(float(each)))

    times_set = set(times)
    freq = []
    xtimes = []

    for each in times_set:
        freq.append(times.count(each))
        xtimes.append(each)

    plt.plot(xtimes, freq, label=protocol)

plt.xlabel('Time(s)')
plt.ylabel('Freqency')
plt.legend()
plt.savefig('../data/freq_graph.png')
