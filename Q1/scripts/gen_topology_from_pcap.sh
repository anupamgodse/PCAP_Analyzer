#identify all hosts
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src | sort | uniq > ../data/all_hosts_ip.txt

#probable red teams
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x2 and not icmp"| sort | uniq > ../data/probable_red_teams.txt

#probable competitors
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x12 and not icmp"| sort | uniq > ../data/probable_competitors_1.txt

tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x14 and not icmp"| sort | uniq > ../data/probable_competitors_2.txt

tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x4 and not icmp"| sort | uniq > ../data/probable_competitors_3.txt

#infrastructure IPs (routers)
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "eigrp" | sort | uniq > ../data/infrastructure_1.txt

tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "icmp.type==9" | sort | uniq > ../data/infrastructure_2.txt

tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "icmp.type==11 and icmp.code==0" | sort | uniq > ../data/infrastructure_3.txt

#RST+ACK and RST receivers
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.dst "tcp.flags.reset==1"| sort | uniq > ../data/reset_receivers.txt


exit
#get unique connections
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src -e ip.dst "not icmp" | sort | uniq > ../data/connections.txt

sleep 1

#generate .dot file "connections.dot" from connections.txt
python3 gen_dot_file.py ../data/connections.txt

#generate svg file from connections.dot
dot -T svg -o ../data/topology.svg ../data/connections.dot
