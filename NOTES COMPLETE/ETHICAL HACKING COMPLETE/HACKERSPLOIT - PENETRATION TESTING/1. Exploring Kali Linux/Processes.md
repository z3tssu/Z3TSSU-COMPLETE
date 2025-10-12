# Processes

**Date:** Sunday, March 19, 2023  
**Time:** 9:32 AM

## Overview
- `ps`: Provides a list of running processes
- `top`: Provides a real-time list of processes, refreshing every 10 seconds

## Managing Processes
- Signals can be sent to terminate processes
- Use `kill` command followed by PID to kill a process
- Signals include:
  - `SIGTERM`: Allows cleanup tasks before killing
  - `SIGKILL`: Kills process without cleanup
  - `SIGSTOP`: Stops/suspends a process

## Starting Processes on Boot
- Some applications can be set to start on system boot
- Use `systemctl` to interact with systemd
- Format: `systemctl [option] [service]`
- Options include:
  - `start`: Starts a service
  - `stop`: Stops a service
  - `enable`: Sets a service to start on boot
  - `disable`: Prevents a service from starting on boot
