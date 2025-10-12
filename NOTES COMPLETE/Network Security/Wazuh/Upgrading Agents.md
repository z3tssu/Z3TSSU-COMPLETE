
# Upgrading Agent
```markdown
Upgrading an agent remotely can be performed at the command line and through the Wazuh API.

**Warning:** It is recommended to use the Wazuh API to upgrade agents if running a Wazuh cluster.
```
## Using the Command Line

To upgrade agents using the command line, use the `agent_upgrade` tool as follows:

1. List all outdated agents using the `-l` parameter:

```bash
/var/ossec/bin/agent_upgrade -l
```

**Output:**
```
ID    Name                               Version
002   VM_Debian9                         Wazuh v3.13.2
003   VM_Debian8                         Wazuh v3.13.2
009   VM_WinServ2016                     Wazuh v3.10.1

Total outdated agents: 3
```

2. Upgrade the agent with ID 002 using the `-a` parameter followed by the agent ID:

```markdown
/var/ossec/bin/agent_upgrade -a 002
```

**Output:**
```
Upgrading...

Upgraded agents:
    Agent 002 upgraded: Wazuh v3.13.2 -> 4.6.0
```

3. Following the upgrade, the agent is automatically restarted. Check the agent version to ensure it has been properly upgraded as follows:

```markdown
/var/ossec/bin/agent_control -i 002
```

**Output:**
```
Agent ID:   002
Agent Name: wazuh-agent2
IP address: any/any
Status:     Active

Operating system:    Linux |wazuh-agent2 |5.8.0-7625-generic |#26~1604441477~20.10~d41e407-Ubuntu SMP Wed Nov 4 01:25:00 UTC 2 |x86_64
Client version:      Wazuh v4.0.0
Configuration hash:  e2f47d482da37c099fa1d6e4c43b523c
Shared file hash:    aabb92f4a8cba49c7c6045c1aa80fbd3
Last keep alive:     1604927114

Syscheck last started at:  Mon Nov  9 13:00:55 2020
Syscheck last ended at:    Mon Nov  9 13:00:56 2020

Rootcheck last started at: Mon Nov  9 13:00:57 2020
```

## Using the RESTful API

1. List all outdated agents using endpoint GET /agents/outdated:

```markdown
curl -k -X GET "https://localhost:55000/agents/outdated?pretty=true" -H  "Authorization: Bearer $TOKEN"
```

**Output:**
```
{
    "data": {
        "affected_items": [
            {"version": "Wazuh v3.0.0", "id": "002", "name": "VM_Debian9"},
            {"version": "Wazuh v3.0.0", "id": "003", "name": "VM_Debian8"},
            {"version": "Wazuh v3.0.0", "id": "009", "name": "VM_WinServ2016"},
        ],
        "total_affected_items": 3,
        "total_failed_items": 0,
        "failed_items": [],
    },
    "message": "All selected agents' information was returned",
    "error": 0,
}
```

2. Upgrade the agents with ID 002 and 003 using endpoint PUT /agents/upgrade:

```markdown
curl -k -X PUT "https://localhost:55000/agents/upgrade?agents_list=002,003&pretty=true" -H  "Authorization: Bearer $TOKEN"
```

**Output:**
```
{
  "data": {
    "affected_items": [
      {
        "agent": "002",
        "task_id": 1
      },
      {
        "agent": "003",
        "task_id": 2
      }
    ],
    "total_affected_items": 2,
    "total_failed_items": 0,
    "failed_items": []
  },
  "message": "All upgrade tasks were created",
  "error": 0
}
```

3. Check the upgrade results using endpoint GET /agents/upgrade_result:

```markdown
curl -k -X GET "https://localhost:55000/agents/upgrade_result?agents_list=002,003&pretty=true" -H  "Authorization: Bearer $TOKEN"
```

**Output:**
```
{
  "data": {
    "affected_items": [
      {
        "message": "Success",
        "agent": "002",
        "task_id": 1,
        "node": "worker2",
        "module": "upgrade_module",
        "command": "upgrade",
        "status": "Updated",
        "create_time": "2020-10-21T17:13:45Z",
        "update_time": "2020-10-21T17:14:07Z"
      },
      {
        "message": "Success",
        "agent": "003",
        "task_id": 2,
        "node": "worker1",
        "module": "upgrade_module",
        "command": "upgrade",
        "status": "Updated",
        "create_time": "2020-10-21T17:13:45Z",
        "update_time": "2020-10-21T17:14:11Z"
      }
    ],
    "total_affected_items": 2,
    "total_failed_items": 0,
    "failed_items": []
  },
  "message": "All upgrade tasks were returned",
  "error": 0
}
```

4. Following the upgrade, the agents are automatically restarted. Check the agents' version to ensure it has been properly upgraded using endpoint GET /agents:

```markdown
curl -k -X GET "https://localhost:55000/agents?agents_list=002,003&pretty=true&select=version" -H  "Authorization: Bearer $TOKEN"
```

**Output:**
```
{
  "data": {
    "affected_items": [
      {
        "id": "002",
        "version": "Wazuh 4.6.0"
      },
      {
        "id": "003",
        "version": "Wazuh 4.6.0"
      }
    ],
    "total_affected_items": 2,
    "total_failed_items": 0,
    "failed_items": []
  },
  "message": "All selected agents' information was returned",
  "error": 0
}
```
```