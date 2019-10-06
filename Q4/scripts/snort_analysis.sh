#!/bin/bash
#This will generate alerts in /var/log/snort/alert file
sudo snort -v -c /etc/snort/snort.conf -r ../../maccdc2012_00003.pcap -A full

#That file can be further processed with series of grep, uniq and sort commands

mkdir -p ../data/snort/

#Find type of attack freqencies categorized by CVEs
cat /var/log/snort/alert | grep -o "name=....-...." | sort | uniq -c | sort -nrk1 > ../data/snort/cve_freq.txt

#Find attackers involved in CVEs detected by snort analysis
cat /var/log/snort/alert | grep cve -B 5 | grep 3/16 | cut -d ' ' -f 2 | cut -d ':' -f 1 | sort | uniq -c | sort -nrk1 > ../data/snort/snort_red_team_vs_cve.txt

#Find competitors involved in CVEs detected by snort analysis
cat /var/log/snort/alert | grep cve -B 5 | grep 3/16 | cut -d ' ' -f 4 | cut -d ':' -f 1 | sort | uniq -c | sort -nrk1 > ../data/snort/snort_competitors_vs_cve.txt
