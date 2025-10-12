```
psexec \\REMOTE_COMPUTER_NAME logoff SESSION_ID

```

```
psexec \\RemotePC logoff 2
```

### OR when connected via CMD

Log Off a Specific User: If there are multiple user sessions on the computer

```bash
query user
```

This will display a list of all logged-in users and their corresponding session IDs.

Once you have the session ID, use the `logoff` command with the `/session` parameter to specify the user's session ID:

```
logoff /session:SESSION_ID
```

Replace `SESSION_ID` with the actual session ID of the user you want to log off.

