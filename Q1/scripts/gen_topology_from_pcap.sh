#identify all end hosts
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "not icmp" | sort | uniq > ../data/end_hosts_ip.txt

#IPs of defendors
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x14" | sort | uniq > ../data/Competitors.txt

#IPs of attackers
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.dst "tcp.flags==0x14" | sort | uniq > ../data/RedTeam.txt

exit
#get unique connections
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src -e ip.dst "not icmp" | sort | uniq > ../data/connections.txt

sleep 1

#generate .dot file "connections.dot" from connections.txt
python3 gen_dot_file.py ../data/connections.txt

#generate svg file from connections.dot
dot -T svg -o ../data/topology.svg ../data/connections.dot
