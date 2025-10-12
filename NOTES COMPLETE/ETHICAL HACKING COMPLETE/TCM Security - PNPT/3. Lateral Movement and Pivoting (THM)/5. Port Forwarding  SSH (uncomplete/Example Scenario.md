---
title: Example Scenario
updated: 2023-04-23T19:14:45.0000000+04:00
created: 2023-04-18T14:35:34.0000000+04:00
---

Example Scenario
Tuesday, April 18, 2023
2:35 PM
# If using attackbox:

## Step 1: Set DNS

- Systemd-resolve --interface lateralmovement --set-dns DC_IP --set-domain DC_name

## Step 2: Create TunnelUser

- Useradd tunneluser -m -d /home/tunneluser -s /bin/true
- Passwd tunneluser

## Step 3: Connect to THMJMP2 using gathered user Credentials

- Ssh za\\\username@za.tryhackme.com

## Step 4: Our first objective will be to connect via RDP to THMIIS

- If we try to connect directly from our attacker machine, we will find that port 3389 has been filtered via a firewall and is therefore not available directly.

## Step 5: Forwarding the RDP port to make it available on THMJMP2 to connect from our attacker's machine

By using socat, which is available on C:\tools\socat\\ on THMJMP2, we will forward the RDP port to make it available on THMJMP2 to connect from our attacker's machine.

To do so, we will run socat with the following parameters:

| Command | socat TCP4-LISTEN:13389,fork TCP4:THMIIS.za.tryhackme.com:3389 |
|---------|----------------------------------------------------------------|

![image1](image1-115.png)

- In a typical setup, you'd have to add a firewall rule to allow traffic through the listener port

## Step 6: Once the listener has been set up, you should be able to connect to THMIIS via RDP from your attacker machine by pivoting through your socat listener at THMJMP2:

| Command | xfreerdp /v:THMJMP2.za.tryhackme.com:13389 /u:t1_thomas.moore /p:MyPazzw3rd2020 |
|---------|---------------------------------------------------------------------------------|

![image2](image2-55.png)

