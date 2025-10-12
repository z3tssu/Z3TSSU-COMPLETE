---
title: What is RPCbind
updated: 2023-03-24T15:54:17.0000000+04:00
created: 2023-03-24T15:53:34.0000000+04:00
---

What is RPCbind
Friday, March 24, 2023
3:53 PM
This is just a server that converts remote procedure call (RPC) program number into universal addresses. When an RPC service is started, it tells rpcbind the address at which it is listening and the RPC program number its prepared to serve.

In our case, port 111 is access to a network file system. Lets use nmap to enumerate this.
