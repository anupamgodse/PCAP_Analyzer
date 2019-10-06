#!/bin/bash

echo "Generating results, estimated time 10-15 mins, ignore warnings by tshark"

#Generate files to be processed
./gen_files.sh

#Now process above generated files
#Final identification of red_teams, competitors, infrastructure, service_requests and unknown
python3 filter_ips.py

#generate .dot file "connections.dot" from connections.txt
python3 gen_dot_file.py ../data/connections.txt

#generate svg file from connections.dot, note this is layer 3 connectivity
dot -T svg -o ../data/final_results/topology.svg ../data/connections.dot
