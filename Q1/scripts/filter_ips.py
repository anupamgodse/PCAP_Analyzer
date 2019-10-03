import sys
import os

all_hosts = set()
probable_red_teams = set()
probable_competitors = set()
infrastructure = set()
reset_receivers = set()
final_red_teams = set()
final_competitors = set()
service_requests = set()
unknown = set()

#Following .txt files re generated using scripts/identify.sh and stored in data/
#reading all host IPs from all_hosts_ip.txt
with open("../data/all_hosts_ip.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        ips = line.split(',')
        if not ips:
            continue

        all_hosts.add(ips[0])

        #for icmp packets: they have 2 sources one is original and another one is generator
        if(len(ips) == 2):
            all_hosts.add(ips[1])

    print(all_hosts)

print("hi")
with open("../data/infrastructure_1.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        infrastructure.add(line)
#probable_red_teams
with open("../data/probable_red_teams.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        probable_red_teams.add(line)

    print(probable_red_teams)

#probable_competitors
with open("../data/probable_competitors_1.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        probable_competitors.add(line)

with open("../data/probable_competitors_2.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        probable_competitors.add(line)

with open("../data/probable_competitors_3.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        probable_competitors.add(line)

print(probable_competitors)

#infrastructure
#EIGRP
with open("../data/infrastructure_1.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        infrastructure.add(line)

#ICMP type 9
with open("../data/infrastructure_2.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        ips = line.split(',')
        if ips:
            #we only want router's IP
            infrastructure.add(ips[0])

#ICMP type 9
with open("../data/infrastructure_3.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        ips = line.split(',')
        if ips:
            #we only want router's IP
            infrastructure.add(ips[0])

print(infrastructure)

#reset recievers

#ICMP type 9
with open("../data/reset_receivers.txt") as f:
    for line in f:
        line = line.rstrip()
        if not line:
            continue
        reset_receivers.add(line)

print(reset_receivers)

#Outputing results to folder ../data/final_results/
os.makedirs(os.path.dirname('../data/final_results/'), exist_ok=True)

#Filtering final red teams: probable_red_teams intersection reset_receivers
print("before: ", probable_red_teams)
final_red_teams = probable_red_teams.intersection(reset_receivers)
with open("../data/final_results/red_teams.txt", "w") as f:
    f.write(str(final_red_teams))
    f.write("\n")
print("after: ", probable_red_teams, final_red_teams)

#Final comeptitors: {probable_competitors} - {final_red_teams} 
print("before: ", probable_competitors)
final_competitors = probable_competitors.difference(final_red_teams)
with open("../data/final_results/competitors.txt", "w") as f:
    f.write(str(final_competitors))
    f.write("\n")
print("after: ", probable_competitors, final_competitors)

#Service Requests: {probable_red_teams} - {final_red_teams}
service_requests = probable_red_teams.difference(final_red_teams)
with open("../data/final_results/service_requests.txt", "w") as f:
    f.write(str(service_requests))
    f.write("\n")

#Unknown IPs
unknown = all_hosts.difference(final_competitors).difference(final_red_teams).difference(service_requests).difference(infrastructure)
with open("../data/final_results/unknown.txt", "w") as f:
    f.write(str(unknown))
    f.write("\n")

#infrastructure
with open("../data/final_results/infrastructure.txt", "w") as f:
    f.write(str(infrastructure))
    f.write("\n")
