#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [network]"
    exit 1
fi

network=$1

echo "Scanning network: $network"

nmap -sS -T4 -p- $network -oN nmap-scan.txt

echo "Identifying open ports and services"

nmap -sV -sC -p $(grep -Eo '[0-9]+' nmap-scan.txt | tr '\n' , | sed 's/,$//' ) $network -oN nmap-services.txt

echo "Scanning for vulnerabilities"

nmap -sV --script vuln -p $(grep -Eo '[0-9]+' nmap-scan.txt | tr '\n' , | sed 's/,$//' ) $network -oN nmap-vuln.txt

echo "Done"
