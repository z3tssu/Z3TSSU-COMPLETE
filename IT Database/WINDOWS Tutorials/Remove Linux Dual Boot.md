[https://www.youtube.com/watch?v=acXGyruzyxw](https://www.youtube.com/watch?v=acXGyruzyxw)

  

```Bash
💻 Commands used in this video:
bcdedit /set {bootmgr} path \EFI\Microsoft\Boot\bootmgfw.efi
bcdedit /enum firmware
bcdedit /delete {identifier}

diskpart 
list disk
select disk X (X = System Drive Number)
list partition 
select partition X (X= EFI Partition Number)
assign letter=W 

cd /d W:\EFI
rmdir /s /q W:\EFI\ubuntu (Replace 'ubuntu' with your Linux boot folder name 
if you’re using a different distribution.)
mountvol W: /d
```