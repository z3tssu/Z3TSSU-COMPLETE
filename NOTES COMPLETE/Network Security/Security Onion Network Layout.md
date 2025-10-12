1. **Using a Network TAP:**
    
    - A network TAP (Test Access Point) is a hardware device that sits between your switch and the rest of your network devices.
    - The TAP passively copies all traffic passing through it and sends it to Security Onion for analysis.
    - This setup allows Security Onion to monitor network traffic without requiring a managed switch with port mirroring capabilities.
    - Network TAPs come in various configurations, including copper and fiber options, depending on your network's needs.
    - ![[Pasted image 20240405102458.png]]
    
1. **Placing Security Onion in a Different Location:**
    
    - If your network layout allows for it, you can place Security Onion in a different location where you have access to mirrored or SPAN ports.
    - For example, you could place Security Onion between your router and your distribution switch.
    - In this setup, the router would connect to Security Onion, and Security Onion would connect to the distribution switch.
    - This way, Security Onion can monitor the traffic passing between the router and the switch, which is often a critical point in the network where you want to monitor for security purposes.
