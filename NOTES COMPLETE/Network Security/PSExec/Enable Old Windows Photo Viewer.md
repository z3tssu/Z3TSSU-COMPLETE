
Here's how to enable "Windows Photo Viewer" using the command line:

1. **Open Command Prompt as Administrator:**
   Right-click on the **Start** button, and from the context menu, select **"Windows Terminal (Admin)"** or **"Command Prompt (Admin)"**.

2. **Run the Registry Command:**
   Copy and paste the following command into the Command Prompt and press **Enter**:

```bash
REG ADD "HKLM\Software\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v .jpg /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKLM\Software\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v .jpeg /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKLM\Software\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v .png /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKLM\Software\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v .bmp /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKLM\Software\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v .gif /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
```

3. **Set "Windows Photo Viewer" as Default:**
   Now that you have enabled "Windows Photo Viewer," you need to set it as the default photo viewer. Copy and paste the following command into the Command Prompt and press **Enter**:

```bash
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\OpenWithList /v a /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\OpenWithList /v a /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\OpenWithList /v a /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\OpenWithList /v a /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\OpenWithList /v a /d "PhotoViewer.FileAssoc.Tiff" /f
```

4. **Refresh File Associations:**
   To ensure the changes take effect immediately, execute the following command:

```bash
assoc .jpg=PhotoViewer.FileAssoc.Tiff
assoc .jpeg=PhotoViewer.FileAssoc.Tiff
assoc .png=PhotoViewer.FileAssoc.Tiff
assoc .bmp=PhotoViewer.FileAssoc.Tiff
assoc .gif=PhotoViewer.FileAssoc.Tiff
```

