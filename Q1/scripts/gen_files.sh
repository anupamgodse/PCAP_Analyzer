#!/bin/bash

mkdir -p ../data/final_results/

#identify all hosts
tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.src | sort | uniq > ../data/final_results/all_hosts_ip.txt

#probable red teams
tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x2 and not icmp"| sort | uniq > ../data/probable_red_teams.txt

#probable competitors
tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x12 and not icmp"| sort | uniq > ../data/probable_competitors_1.txt

tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x14 and not icmp"| sort | uniq > ../data/probable_competitors_2.txt

tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x4 and not icmp"| sort | uniq > ../data/probable_competitors_3.txt

#infrastructure IPs (routers)
tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.src "eigrp" | sort | uniq > ../data/infrastructure_1.txt

tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.src "icmp.type==9" | sort | uniq > ../data/infrastructure_2.txt

tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.src "icmp.type==11 and icmp.code==0" | sort | uniq > ../data/infrastructure_3.txt

#RST+ACK and RST receivers
tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.dst "tcp.flags.reset==1"| sort | uniq > ../data/reset_receivers.txt

#Topology generation
#Generating layer 3 connectivity
#get unique connections
tshark -r ../../maccdc2012_00003.pcap -T fields -e ip.src -e ip.dst | sort | uniq > ../data/connections.txt
