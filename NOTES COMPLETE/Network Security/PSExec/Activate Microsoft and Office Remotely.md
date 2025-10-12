- **Command:**

```shell
  psexec \\REMOTE_MACHINE -u USERNAME -p "PASSWORD" -c -f -w "C:\" "C:\Path\To\Local\Script\Office 2013 act(x64).bat"
```

- **Example**

```shell
psexec -is \\Hostname -c -f -w "C:\" "\\10.136.69.10\Volume_1\IT Support\PROGRAMS and APPLICATIONS\DICT Activators\Office 2013 act(x64).bat"
```

- **Explanation:**

  - `psexec`: The PsExec tool.
  - `\\REMOTE_MACHINE`: The name of the remote machine.
  - `-u USERNAME -p "PASSWORD"`: The username and password for the remote machine. Replace `USERNAME` with the appropriate username and `"PASSWORD"` with the password.
  - `-c`: Copy the specified program (your local script) to the remote system for execution.
  - `-f`: Run the program in the foreground (optional).
  - `-w "REMOTE_DIRECTORY"`: Set the working directory on the remote system where the script should be executed. Replace `"REMOTE_DIRECTORY"` with the appropriate path on the remote machine where you want the script to run.
  - `"LOCAL_SCRIPT_PATH"`: The path to the script you want to execute on your local machine. Make sure this path is correct.