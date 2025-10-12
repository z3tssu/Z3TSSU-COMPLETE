1. Once you have a psexec session

```powershell
psexec -is \\HOST-NAME -c -f -w "C:\" "\\10.136.69.10\Volume_1\IT Support\PROGRAMS and APPLICATIONS\PATCH MANAGEMENT\ManageEngine Patch Management\LocalOffice\setup.bat"

```

2. Or use this method

```shell
net use Z: "\\10.136.69.10\Volume_1\IT Support\PROGRAMS and APPLICATIONS\PATCH MANAGEMENT\ManageEngine Patch Management\LocalOffice"
```

3. Access the mounted drive

```
Z:
```

3. Delete the drive

```shell
net use Z: /delete
```
