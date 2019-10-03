Question1:

Identifying IP addresses of all hosts:
#identify all hosts
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src | sort | uniq > ../data/all_hosts_ip.txt

Now we want to classify these IP addresses as "Red Team", "Competitors", "Service Requests" and "Unknown"

To do this I analyzed the PCAP file and found that few hosts are sending SYN requests to random ports and in return receiving "RST ACK" packets from the target.
Clearly this looks like an attack.

We can assume that probable RED teams are one sending SYN packets (i.e initialting TCP connections), we will process this later to filter final red teams.
#probable red teams
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x2 and not icmp"| sort | uniq > ../data/probable_red_teams.txt

We can assume competitors be the ones responding to SYN packets. These will be hosts sending packets withSYN+ACK or RST+ACK or RST flags. We will filter these later to get final competitors. 
#probable competitors
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x12 and not icmp"| sort | uniq > ../data/probable_competitors_1.txt
or
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x14 and not icmp"| sort | uniq > ../data/probable_competitors_2.txt
or
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x4 and not icmp"| sort | uniq > ../data/probable_competitors_3.txt

We can identify infrastucture IPs(i.e Routers):
1) Using EIGRP protocol (Only CISCO routers)
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "eigrp" | sort | uniq > ../data/infrastructure_1.txt

2) Src address of packets having "icmp.type==9", These are router advertisement messages sent by routers
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "icmp.type==9" | sort | uniq > ../data/infrastructure_2.txt

3) Src address of packets having "icmp.type==11 and icmp.code==0", these are ttl exceeded icmp error msgs sent by routers
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "icmp.type==11 and icmp.code==0" | sort | uniq > ../data/infrastructure_3.txt

Now we will identify final RED teams from probable_red_teams by identifying IPs which sent SYN packets but received RST or RST+ACK
This can be done by filtering out above IPs in probable_read_teams.txt by only selecting IPs which are destination address for packets with RST+ACK or RST
So we will require destination address of packets recieving RST+ACK or RST
#RST+ACK and RST receivers
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.dst "tcp.flags.reset==1"| sort | uniq > ../data/reset_receivers.txt

Final red teams can be found by taking intersection of IPs in probable_red_teams.txt and reset_receivers.txt files

Final competitors can be found by taking union of probable_competitors_1/2/3.txt files above and removing IPs which are final red_teams.

IDENTIFYING SERVICE REQUESTS i.e benign endpoints that are requesting some resource from competitors
We already have IPs of ones sending SYN requests and IPs of red teams. So the service request IPs would be ones that are sending SYN requests which are not red teams.

UNKNOWN IPs:
These can simply be all IPs which are not RED teams or competitors or routers or sevice requests.


BUILDING TOPOLOGY:
To identify the defendors and the attackers I filtered all packets having tcp flags set to "0x14" i.e the RST and ACK bits are set meaning that the host is resetting the connection (A probable technique to defend an attack or if a host is not listening on that port then it will send this or maybe a firewall will send this)

#IPs of defendors
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src "tcp.flags==0x14" | sort | uniq > ../data/Competitors.txt

#IPs of attackers
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.dst "tcp.flags==0x14" | sort | uniq > ../data/RedTeam.txt

Firstly, I split pcap file into multiple 100000 packet files.

Scanning through single file revealed multiple protocols in use: ARP, BROWSER, CDP, CLASSICSTUN, DB-LSP-DISC, DHCP, DNS, EIGRP, HTTP, ICMP, ICP, LLMNR, LOOP, MDNS, MySQL, NBNS, NTP, PGSQL, RADIUS, RARP, RIPv1, SMB, SNMP, SRVLOC, SSDP, SSH, SSLv3, STP, TCP, TLSv1, UDP, XDMCP

Further I classified these protocols as used by hosts, routers and switches

Used by,
hosts: ARP, BROWSER, CDP, CLASSICSTUN, DB-LSP-DISC, DHCP, DNS, HTTP, ICMP, LLMNR, MDNS, MySQL, NBNS, NTP, PGSQL, RADIUS, RARP, RIPv1, SMB, SNMP, SRVLOC, SSDP, SSH, SSLv3, TCP, TLSv1, UDP, XDMCP

routers: ARP, CDP, DHCP, DNS, EIGRP, HTTP, ICMP, LLMNR, MDNS, RARP, RIPv1, SNMP, UDP

switches: CDP, LOOP, SNMP, STP 


Identifying all end hosts devices and communications between them:
#get unique connections
tshark -r ../data/maccdc2012_00003.pcap -T fields -e ip.src -e ip.dst "not icmp" | sort | uniq > ../data/connections.txt

Explanation: identify unique source and destination tuples which are no icmp packets. This will give all endhosts communications.

Identifying routers:
1) Using EIGRP protocol (Only CISCO routers)
2) Src address of packets having "icmp.type==9", These are router advertisement messages sent by routers
3) Src address of packets having "icmp.type==11 and icmp.code==0", these are ttl exceeded icmp error msgs sent by routers

Identifying switches:
1) src and dst MAC addresses of packets having protocol field as STP, this is a spanninng tree protocol run by switches
2) src and dst MAC addresses of packets having protocol field as LOOP, this is a protocol used by switches to detect loops


