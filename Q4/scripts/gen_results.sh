#!/bin/bash

echo "Generating results"

#Use snort to detect attacks and process alert file
./snort_analysis.sh

#Plot graphs
python3 plot_graph.py
