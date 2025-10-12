---
title: Nmap Scan
updated: 2023-04-11T14:37:37.0000000+04:00
created: 2023-04-11T14:08:01.0000000+04:00
---

Nmap Scan
Tuesday, April 11, 2023
2:08 PM

## Simple Nmap Scan 

| Command | Nmap ip_address -T5 -A -Pn -vv |
|---------|--------------------------------|

## Once you have identify available open ports:

| Command | nmap -sV -sC -Pn -v -oN nmap-report -p 53,88,135,139,389,445,464,593,3268,3269,5985,49665,49668,49670,49672,49680,49713 ip_address |
|---------|------------------------------------------------------------------------------------------------------------------------------------|

## Alternative:

| Command | nmap -T5 --open -sS -vvv --min-rate=300 --max-retries=3 -p- -Pn -oN all-ports-nmap-report 10.10.114.63 |
|---------|--------------------------------------------------------------------------------------------------------|

**

**

