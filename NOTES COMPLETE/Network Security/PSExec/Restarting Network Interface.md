Do this for network issues

1. Show available interfaces 

```bash
netsh interface show interface
```

2. Disable the interface

```bash
netsh interface set interface "InterfaceName" admin=disable
```

3. Enable the Interface

```bash
netsh interface set interface "InterfaceName" admin=enable
```

