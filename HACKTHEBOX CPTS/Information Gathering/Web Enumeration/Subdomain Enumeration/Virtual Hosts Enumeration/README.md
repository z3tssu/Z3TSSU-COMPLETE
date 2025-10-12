
## **Concept**

- Virtual hosting allows **multiple websites or applications** to share the **same IP address**.
    
- This is made possible by the **`HTTP Host` header**, sent with every HTTP request.
    
- Web servers use this header to determine **which site or app** the client wants to access.
    

---

## **VHost Fuzzing**

- Technique to discover **public and hidden subdomains or virtual hosts**.
    
- Performed by **fuzzing the `Host` header** with different potential hostnames while targeting a known IP address.
    

---

## **Virtual Host Discovery Tools**

|**Tool**|**Description**|**Key Features**|
|---|---|---|
|[**Gobuster**](https://github.com/OJ/gobuster)|Multi-purpose brute-forcing tool, often used for directory/file discovery and VHost fuzzing.|Fast, supports custom wordlists, multiple HTTP methods.|
|[**Feroxbuster**](https://github.com/epi052/feroxbuster)|Rust-based tool, known for **speed** and **flexibility**.|Supports recursion, wildcard detection, and filtering.|
|[**ffuf**](https://github.com/ffuf/ffuf)|Lightweight and fast web fuzzer for multiple use cases including VHost discovery.|Customizable wordlists, advanced filtering, and header manipulation.|

---
