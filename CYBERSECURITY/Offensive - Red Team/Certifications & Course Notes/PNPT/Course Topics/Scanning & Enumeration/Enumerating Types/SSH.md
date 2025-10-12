- Login into SSH (Simple way)
    
    ```JavaScript
    ssh ip_address
    
    ssd username@Ip_address
    ```
    
- Other login SSH method
    
    ```JavaScript
    ssh ip_address -oKexAlgorithms=+diffie-hellman-group1-sha1 -c aes128-cbc
    ```