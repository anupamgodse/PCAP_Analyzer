import os
import matplotlib.pyplot as plt

path="../data/times/"
for f in os.listdir(path):
    print(f)
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

plt.xlabel('intervals')
plt.ylabel('Freqency')
plt.legend(loc='upper center', bbox_to_anchor=(0.5, 1.05),
          ncol=5, fancybox=True, shadow=True)
plt.show()
plt.savefig('freq_graph.png')
