#!/bin/bash
echo "Generating results, Ignore tshark warnings if any"

#Gen intermediate files
./get_protocol_times.sh

#Generate result graph
python3 plot_graph.py
