#!/bin/bash
declare -A ports
ports=(
	['ftp']="20 21"
	['ssh']="22"
	['telnet']="23"
	['smtp']="25"
	['dns']="53"
	['dhcp']="67 68"
	['tftp']="69"
	['http']="80"
	['popv3']="110"
	['ntp']="123"
	['imap']="143"
	['snmp']="161 162"
	['bgp']="179"
	['ldap']="389"
	['https']="443"
	['ldaps']="636"
	['ftp_secure']="989 990"
)

path="../data/times/"
mkdir -p $path
for protocol in "${!ports[@]}"; do 
	file="$protocol.txt"
	times=
	for port in ${ports[$protocol]}; do
		temp=$(tshark -r ../../maccdc2012_00003.pcap "tcp.dstport==$port or udp.dstport==$port" | awk {'print $2'})
		times="$times $temp"
	done
	echo $(echo $times | tr " " "\n" | sort -g) > "$path$file"
done
