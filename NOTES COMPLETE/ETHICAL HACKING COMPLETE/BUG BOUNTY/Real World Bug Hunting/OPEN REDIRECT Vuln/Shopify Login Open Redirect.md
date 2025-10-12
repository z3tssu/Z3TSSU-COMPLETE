---
title: Shopify Login Open Redirect
updated: 2022-11-27T17:00:22.0000000+04:00
created: 2022-11-27T16:56:22.0000000+04:00
---

Shopify Login Open Redirect
Sunday, November 27, 2022
4:56 PM
In this bug, after the user logged into Shopify,

- Shopify used the parameter **checkout_url** to redirect the user. For example, let’s say a target visited this URL:

![image1](image1-178.png)

- They would have been redirected to the URL:

