import os
import matplotlib.pyplot as plt
plt.figure(figsize=(8,7))
#cve_freq.txt  snort_competitors_vs_cve.txt  snort_red_team_vs_cve.txt

path="../data/snort/"

f = "cve_freq.txt"
with open(path+f) as fl:
    cve = []
    freq = []
    for line in fl:
        t = line.split();

        if len(t) == 2:
            cve.append(t[1])
            freq.append(int(t[0]))

    plt.barh(cve, freq, align='center', alpha=0.5)
    plt.ylabel('CVEs')
    plt.xlabel('detected_freq')
    #plt.subplots_adjust(left=0.2)
    plt.tight_layout()
    plt.savefig('../data/cve.png')

#plt.figure(figsize=(8,10))
plt.clf()
f = "snort_competitors_vs_cve.txt"
with open(path+f) as fl:
    host = []
    freq = []
    for line in fl:
        t = line.split();

        if len(t) == 2:
            host.append(t[1])
            freq.append(int(t[0]))

    plt.barh(host, freq, align='center', alpha=0.5)
    plt.ylabel('Competitors')
    plt.xlabel('Involved in CVE freqency')
    #plt.subplots_adjust(left=0.2, top=1.2, bottom=)
    plt.tight_layout()
    plt.savefig('../data/competitors_cve_freq.png')

plt.clf()
f = "snort_red_team_vs_cve.txt"
with open(path+f) as fl:
    host = []
    freq = []
    for line in fl:
        t = line.split();

        if len(t) == 2:
            host.append(t[1])
            freq.append(int(t[0]))

    plt.barh(host, freq, align='center', alpha=0.5)
    plt.ylabel('Red teams')
    plt.xlabel('Involved in CVE freqency')
    #plt.subplots_adjust(left=0.2, top=1.2, bottom=)
    plt.tight_layout()
    plt.savefig('../data/red_team_cve_freq.png')
