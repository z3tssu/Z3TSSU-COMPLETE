# Cloudflare Basics

When you use Cloudflare with your domain, the setup changes a few things about how requests are handled for your website. Here’s a step-by-step breakdown of how it works, specifically for your example domain, `test.com` with IP `198.123.123.123`:

1. **DNS Update**:
    - When you sign up for Cloudflare and add `test.com`, Cloudflare gives you two nameservers to use instead of your current nameservers. You’ll need to update the nameservers for your domain (e.g., via your domain registrar).
    - Once you do this, Cloudflare starts handling DNS requests for `test.com`. This means that, instead of pointing directly to `198.123.123.123`, `test.com` will now point to Cloudflare’s IP addresses.
2. **Traffic Routing through Cloudflare**:
    - When a user tries to access `test.com`, the request first goes to Cloudflare’s network. Cloudflare then forwards the request to your server at `198.123.123.123`, acting as a middleman.
    - This process hides your server’s actual IP address from users, as they only see Cloudflare’s IPs, enhancing security by preventing direct access to your server.
3. **Security and Protection**:
    - Cloudflare provides a layer of security by filtering out malicious traffic. It has tools to prevent DDoS attacks, block suspicious IP addresses, and provide a web application firewall (WAF) to protect against various threats.
    - If an attacker tries to access `test.com`, they’ll hit Cloudflare’s network instead of your server, reducing the risk of a direct attack on your IP address.
4. **Caching and Performance**:
    - Cloudflare caches static content (like images, CSS, JavaScript) from your site across its global network of servers. When a user accesses `test.com`, Cloudflare serves cached content from the location closest to the user, which speeds up load times.
    - For dynamic content, Cloudflare can be configured to optimize load times without full caching, ensuring fast response times even for parts of your site that require real-time data from your server.
5. **SSL and HTTPS**:
    - Cloudflare provides SSL certificates for your site, allowing it to be accessed over HTTPS even if your origin server doesn’t have SSL configured. You can enable "Full" or "Full (Strict)" SSL modes if your server supports HTTPS.
    - This means users will see a secure connection ([https://test.com](https://test.com/)) without requiring you to manage the SSL certificate directly.
6. **Additional Features**:
    - **Load Balancing**: If you have multiple servers, Cloudflare can distribute traffic to balance the load.
    - **Page Rules**: Cloudflare lets you create specific rules for different parts of your website, applying different caching, forwarding, or security settings as needed.

### Summary of Changes with Cloudflare

By using Cloudflare:

- The DNS for `test.com` points to Cloudflare’s IP addresses instead of `198.123.123.123`.
- Cloudflare handles traffic routing, security, and performance optimization.
- Your server’s IP (198.123.123.123) is hidden, reducing exposure to attacks.
- Cached content loads faster, SSL is simplified, and additional protection features are available.