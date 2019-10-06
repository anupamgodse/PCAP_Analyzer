Major protocols and used port numbers:

ftp 20, 21
ssh 22
telnet 23
smtp 25
dns 53
dhcp 67, 68
tftp 69
http 80
popv3 110
ntp 123
imap 143
snmp 161, 162
bgp 179
ldap 389
https 443
ldaps 636
ftp over tls/ssl 989, 990
catchall 0-1023 minus above ports

All times are w.r.t packet capture start time

#protocol packets time #for each protocol each port do tshark -r
maccdc2012_00003.pcap "tcp.dstport=protocol_port or udp.dstport=protocol_port" |
awk {'print $2'} > protocol_name.txt

This files will be used by python code to generate graph.
