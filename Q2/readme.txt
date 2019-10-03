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

#FTP packets time
tshark -r maccdc2012_00003.pcap "tcp.dstport=20 or tcp.dstport=21 or udp.dstport=20 or udp.dstport=21" | awk {'print $2'}

#ssh packets time
tshark -r maccdc2012_00003.pcap "tcp.dstport==22 or udp.dstport==22" | awk {'print $2'}

#telnet packets time
tshark -r maccdc2012_00003.pcap "tcp.dstport==23 or udp.dstport==23" | awk {'print $2'}

#smtp packets time
tshark -r maccdc2012_00003.pcap "tcp.dstport==25" | awk {'print $2'}

#dns packets time
tshark -r maccdc2012_00003.pcap "tcp.dstport==53" | awk {'print $2'}

#dhcp packets time
tshark -r maccdc2012_00003.pcap "tcp.dstport==67 or tcp.dst" | awk {'print $2'}
