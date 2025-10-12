### Overview

SocksOverRDP leverages **Dynamic Virtual Channels (DVC)** in the **Remote Desktop Protocol (RDP)** to tunnel SOCKS5 traffic over an existing RDP session. This is particularly useful in Windows-only environments where traditional SSH-based tunneling is unavailable.

This technique enables **pivoting** through a compromised Windows machine to access deeper network resources. We'll use **Proxifier** to redirect traffic through the established SOCKS5 tunnel.

---

### Scenario

- **Attack Host**: Linux-based system with `xfreerdp`, `SocksOverRDP` binaries, and Proxifier installer
- **Pivot Host (Windows 10 User Machine)**: `10.129.x.x`
- **Internal Host (Target RDP Server)**: `172.16.6.155`
- **Intermediate RDP Server**: `172.16.5.19` (User: `victor`, Pass: `pass@123`)

---

## Step-by-Step Instructions

### Step 1: Prepare Required Tools (Attack Host)

Download the following:

- [SocksOverRDP-x64.zip](https://github.com/nccgroup/SocksOverRDP/releases)
- [ProxifierPE.zip (Portable version of Proxifier)](https://www.proxifier.com/download/#win-tab)

---

### Step 2: Transfer SocksOverRDP to Pivot Host

Establish RDP to the Windows 10 Pivot Host and transfer the SocksOverRDP binaries (e.g., via clipboard or drag-and-drop using RDP session).

---

### Step 3: Register SocksOverRDP Plugin (Pivot Host)

From an **elevated Command Prompt**:

```Plain
regsvr32.exe SocksOverRDP-Plugin.dll
```

This registers the plugin DLL. A dialog box should confirm successful registration.

![[Notion/CPTS/RESOURCES/image 6.png|image 6.png]]

---

### Step 4: RDP into Intermediate Host with Plugin Active (Pivot Host)

From the Pivot Host, open RDP to DC `172.16.5.19` using `mstsc.exe`.  
Use the credentials:

- **Username**: `victor`
- **Password**: `pass@123`

A prompt should indicate that the SocksOverRDP plugin is active and that it is listening on:

![[Notion/CPTS/RESOURCES/image 1 4.png|image 1 4.png]]

---

### Step 5: Start SocksOverRDP-Server on Internal Host (172.16.5.19)

Transfer `SocksOverRDP-Server.exe` to the internal DC host (`172.16.5.19`). Launch the server with **administrator privileges**:

```Plain
.\\SocksOverRDP-Server.exe
```

It will open a dynamic channel over RDP to handle SOCKS traffic.

---

### Step 6: Confirm SOCKS Listener is Active (Pivot Host)

Run the following from Command Prompt:

```Plain
netstat -antb | findstr 1080
```

---

## Configuring Proxifier (Pivot Host)

### Step 7: Transfer and Run Proxifier Portable

Move `ProxifierPE.zip` to the Pivot Host, extract it, and run `Proxifier.exe`.

### Step 8: Configure Proxy in Proxifier

- Add a new proxy server:
    - **Address**: `127.0.0.1`
    - **Port**: `1080`
    - **Protocol**: SOCKS5

Set this as the **default rule** for all connections.

---

## Using the Tunnel

### Step 9: RDP to Internal Host via Tunnel (Pivot Host)

From the Pivot Host, launch `mstsc.exe`:

```Plain
172.16.6.155
```

The RDP traffic is now tunneled over:

- SOCKS5 on `127.0.0.1:1080` (created by SocksOverRDP)
- RDP session to `172.16.5.19`
- Forwarded to final target `172.16.6.155`

---

## Performance Considerations

If experiencing lag in the RDP session:

1. Launch `mstsc.exe`
2. Go to the **Experience** tab
3. Set performance to: **Modem (56 Kbps)**

This disables animations, font smoothing, and other bandwidth-heavy features for smoother operation.

---