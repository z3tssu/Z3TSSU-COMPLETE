## ![Question](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAEJSURBVDhPY2RAA8udt6oxMP+tAkp4ALniYMF/DMf+MzFMitzltxLMRwIoBoA0MzL/3g5i/2dgms3EyPABxP73758LIyODB1AsGd0QFigNAUCbQdT/v6yekXu9b4HFIGDGcreNOxj/MeQB2SgGMEFpMGBk+GcLtGUlmmYwYGJk3ABUbQXlwgGKAUCuEtDZj6Ac6oLlbpvaVrhtuAvlwgGaC7ADoOZwoPfyQAELFYIDjGhEB1DNc/8zMB6J3OUPiloUgNcAWLQCNd/GphkE8HuB+c+kf/8YPuPSDAJ4DWBkYHRnYmIohHJJAyDnr3Db9B/KxQlwuoCJ5a8TlDlAYJnLhgsUeYE4wMAAADQ2UW0jvvHhAAAAAElFTkSuQmCC) What is Lateral Movement?

Simply put, lateral movement is the group of techniques used by attackers to move around a network.

-   Once an attacker has gained access to the first machine of a network, moving is essential for many reasons
-   Reaching our goals as attackers -
-   Bypassing network restrictions in place -
-   Establishing additional points of entry to the network -
-   Creating confusion and avoid detection.

While many cyber kill chains reference lateral movement as an additional step on a linear process, it is actually part of a cycle. During this cycle, we use any available credentials to perform lateral movement, giving us access to new machines where we elevate privileges and extract credentials if possible. With the newfound credentials, the cycle starts again.

## ![Question](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAEJSURBVDhPY2RAA8udt6oxMP+tAkp4ALniYMF/DMf+MzFMitzltxLMRwIoBoA0MzL/3g5i/2dgms3EyPABxP73758LIyODB1AsGd0QFigNAUCbQdT/v6yekXu9b4HFIGDGcreNOxj/MeQB2SgGMEFpMGBk+GcLtGUlmmYwYGJk3ABUbQXlwgGKAUCuEtDZj6Ac6oLlbpvaVrhtuAvlwgGaC7ADoOZwoPfyQAELFYIDjGhEB1DNc/8zMB6J3OUPiloUgNcAWLQCNd/GphkE8HuB+c+kf/8YPuPSDAJ4DWBkYHRnYmIohHJJAyDnr3Db9B/KxQlwuoCJ5a8TlDlAYJnLhgsUeYE4wMAAADQ2UW0jvvHhAAAAAElFTkSuQmCC) A Quick Example:

1.  Suppose we are performing a red team engagement where our final goal is to reach an internal code repository, where we got our first compromise on the target network by using a phishing campaign. Usually, phishing campaigns are more effective against non-technical users, so our first access might be through a machine in the Marketing department.

1.  Marketing workstations will typically be limited through firewall policies to access any critical services on the network, including administrative protocols, database ports, monitoring services or any other that aren't required for their day to day labour, including code repositories.

1.  To reach sensitive hosts and services, we need to move to other hosts and pivot from there to our final goal. To this end, we could try elevating privileges on the Marketing workstation and extracting local users' password hashes. If we find a local administrator, the same account may be present on other hosts. After doing some recon, we find a workstation with the name DEV-001-PC. We use the local administrator's password hash to access DEV-001-PC and confirm it is owned by one of the developers in the company. From there, access to our target code repository is available.

## ![Question](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAEJSURBVDhPY2RAA8udt6oxMP+tAkp4ALniYMF/DMf+MzFMitzltxLMRwIoBoA0MzL/3g5i/2dgms3EyPABxP73758LIyODB1AsGd0QFigNAUCbQdT/v6yekXu9b4HFIGDGcreNOxj/MeQB2SgGMEFpMGBk+GcLtGUlmmYwYGJk3ABUbQXlwgGKAUCuEtDZj6Ac6oLlbpvaVrhtuAvlwgGaC7ADoOZwoPfyQAELFYIDjGhEB1DNc/8zMB6J3OUPiloUgNcAWLQCNd/GphkE8HuB+c+kf/8YPuPSDAJ4DWBkYHRnYmIohHJJAyDnr3Db9B/KxQlwuoCJ5a8TlDlAYJnLhgsUeYE4wMAAADQ2UW0jvvHhAAAAAElFTkSuQmCC) Attackers Perspective

-   There are several ways in which an attacker can move laterally. The simplest way would be to use standard administrative protocols like - WinRM, RDP, VNC or SSH to connect to other machines around the network.
-   This approach can be used to emulate regular users' behaviours somewhat as long as some coherence is maintained when planning where to connect with what account.
-   While a user from IT connecting to the web server via RDP might be usual and go under the radar, care must be taken not to attempt suspicious connections (e.g. why is the local admin user connecting to the DEV-001-PC from the Marketing-PC?).

Attackers nowadays also have other methods of moving laterally while making it somewhat more challenging for the blue team to detect what is happening effectively. While no technique should be considered infallible, we can at least attempt to be as silent as possible. In the following tasks, we will look at some of the most common lateral movement techniques available.