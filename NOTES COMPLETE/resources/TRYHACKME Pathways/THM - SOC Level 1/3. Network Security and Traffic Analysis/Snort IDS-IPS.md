- [SNORT](https://www.snort.org/) is an open-source, rule-based Network Intrusion Detection and Prevention System (NIDS/NIPS). 
	- It was developed and still maintained by Martin Roesch, open-source contributors, and the Cisco Talos team. 

# Snort as an IDS/IPS

## Intrusion Detection System
- IDS is a passive monitoring solution for detecting possible malicious activities/patterns, abnormal incidents, and policy violations. It is responsible for generating alerts for each suspicious event. 

	- There are two main types of IDS systems;

		- Network Intrusion Detection System (NIDS) - 
			- NIDS monitors the traffic flow from various areas of the network. The aim is to investigate the traffic on the entire subnet. If a signature is identified, an alert is created.
		- Host-based Intrusion Detection System (HIDS) - 
			- HIDS monitors the traffic flow from a single endpoint device. The aim is to investigate the traffic on a particular device. If a signature is identified, an alert is created.

## Intrusion Prevention System
- active protecting solution for preventing possible malicious activities/patterns, abnormal incidents, and policy violations. It is responsible for stopping/preventing/terminating the suspicious event as soon as the detection is performed.

	- Four Main Types of IPS Systems
		- NIPS 
			- Network Intrusion Protection System
		- Behavior-Based IPS
			- Behavior Based Intrusion Prevention System
		- WIPS 
			- Wireless Intrusion Prevention System
		- HIPS 
			- Host-Based Intrusion Prevention System

## Detection/Prevention Techniques
- Signature-Based
	- relies on rules that identify the specific patterns of the known malicious behaviour
- Behavior Based
	- This technique identifies new threats with new patterns that pass through signatures. The model compares the known/normal with unknown/abnormal behaviours. This model helps detect previously unknown or new threats.
- Policy Based
	- This technique compares detected activities with system configuration and security policies. This model helps detect policy violations.

# SNORT Basics

## Viewing Snort Version

```bash
snort -V
```

## Ensure our Snort configuration file is valid

``` bash
sudo snort -c /etc/snort/snort.conf -T 
```

- -T | testing configuration
- -c | Identifying the configuration file

