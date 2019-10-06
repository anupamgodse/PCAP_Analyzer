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
catch_all_filter="((tcp.dstport >= 0 and tcp.dstport < 1024) or (udp.dstport >= 0 and udp.dstport < 1024)) "
mkdir -p $path
for protocol in "${!ports[@]}"; do 
	file="$protocol.txt"
	times=
	for port in ${ports[$protocol]}; do
		#temp=$(tshark -r ../../maccdc2012_00003.pcap "tcp.dstport==$port or udp.dstport==$port" | awk {'print $2'})
		#times="$times $temp"
		catch_all_filter="$catch_all_filter and not tcp.dstport==$port and not udp.dstport==$port"
	done
	#echo $(echo $times | tr " " "\n" | sort -g) > "$path$file"
done

echo $catch_all_filter
tshark -r ../../maccdc2012_00003.pcap "$catch_all_filter" | awk {'print $2'} > $path"catch_all.txt"
