
---

**Note 1: Executing Script on Remote Machine with PsExec**

- **Command Structure:**

  ```shell
  psexec \\REMOTE_MACHINE -u USERNAME -p "PASSWORD" -c -f -w "REMOTE_DIRECTORY" "LOCAL_SCRIPT_PATH"
  ```

- **Explanation:**

  - `psexec`: The PsExec tool.
  - `\\REMOTE_MACHINE`: The name of the remote machine.
  - `-u USERNAME -p "PASSWORD"`: The username and password for the remote machine. Replace `USERNAME` with the appropriate username and `"PASSWORD"` with the password.
  - `-c`: Copy the specified program (your local script) to the remote system for execution.
  - `-f`: Run the program in the foreground (optional).
  - `-w "REMOTE_DIRECTORY"`: Set the working directory on the remote system where the script should be executed. Replace `"REMOTE_DIRECTORY"` with the appropriate path on the remote machine where you want the script to run.
  - `"LOCAL_SCRIPT_PATH"`: The path to the script you want to execute on your local machine. Make sure this path is correct.

- **Command:**

```
  psexec \\REMOTE_MACHINE -u USERNAME -p "PASSWORD" -c -f -w "C:\" "C:\Path\To\Local\Script\Office 2013 act(x64).bat"
 ``` 


---
