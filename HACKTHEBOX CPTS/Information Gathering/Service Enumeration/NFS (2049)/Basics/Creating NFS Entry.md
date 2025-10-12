

```bash
root@nfs:~# echo '/mnt/nfs 10.129.14.0/24(sync,no_subtree_check)' >> /etc/exports

root@nfs:~# systemctl restart nfs-kernel-server

root@nfs:~# exportfs

/mnt/nfs 10.129.14.0/24
```

We have shared the folder `/mnt/nfs` to the subnet `10.129.14.0/24` with the setting shown above. This means that all hosts on the network will be able to mount this NFS share and inspect the contents of this folder.