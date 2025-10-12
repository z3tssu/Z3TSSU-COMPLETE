---
title: Load Balancer
updated: 2022-11-23T08:14:41.0000000+04:00
created: 2022-11-23T08:12:30.0000000+04:00
---

Load Balancer
Wednesday, November 23, 2022
8:12 AM
- When a website's traffic starts getting quite large or is running an application that needs to have high availability, one web server might no longer do the job. Load balancers provide two main features, ensuring high traffic websites can handle the load and providing a failover if a server becomes unresponsive.

- When you request a website with a load balancer, the load balancer will receive your request first and then forward it to one of the multiple servers behind it.

- The load balancer uses different algorithms to help it decide which server is best to deal with the request.

**<u>examples of these algorithms are</u>**
- round-robin, which sends it to each server in turn,
- or weighted, which checks how many requests a server is currently dealing with and sends it to the least busy server.
