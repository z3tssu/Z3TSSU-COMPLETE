To remotely view a list of all installed applications on a remote computer, you can use PsExec in combination with the `wmic` (Windows Management Instrumentation Command-line) tool. Here's how you can do it:

1. **Execute PsExec Command:**

   ```bash
   psexec \\Server123 -u AdminUser -p AdminPass wmic product get name,version
   ```

2. **Execute Command:**
   Press Enter to execute the command. PsExec will establish a remote connection to the specified computer and use `wmic` to retrieve the list of installed applications.

3. **View List of Installed Applications:**
   The command output will display a list of installed applications along with their names and versions.

   Example output:
   ```
   Name                 Version
   Adobe Acrobat Reader 11.0.10
   Google Chrome        94.0.4606.71
   Microsoft Office     16.0.14326.20306
   ```

4. Output the application list into a text file

```bash
psexec \\Server123 -u AdminUser -p AdminPass wmic product get name,version > InstalledApplications.txt
```
