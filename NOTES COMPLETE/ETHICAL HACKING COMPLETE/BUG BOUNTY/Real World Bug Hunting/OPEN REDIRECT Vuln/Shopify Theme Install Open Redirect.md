---
title: Shopify Theme Install Open Redirect
updated: 2022-11-27T16:55:54.0000000+04:00
created: 2022-11-27T12:44:08.0000000+04:00
---

PM
Shopify offered a feature to provide a preview for the theme by redirecting the store owners to a URL

![image1](image1-177.png)

- The **domain_name** parameter at the end of the URL redirected to the user's store domain and added **/admin (to act like the admin panel)**
- Shopify was **expecting the domain_name parameter to always be the users store and they were not validating its value**.

**<u>Method to Exploit this:</u>**
- Change the parameter of domain_name=
- To domain_name=www.attackerwebsite.com

