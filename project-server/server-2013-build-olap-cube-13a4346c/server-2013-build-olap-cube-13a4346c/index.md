# Project Server 2013 build OLAP Cub

## Original Links

- [x] Original Technet URL [Project Server 2013 build OLAP Cub](https://gallery.technet.microsoft.com/Server-2013-build-OLAP-Cube-13a4346c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-2013-build-OLAP-Cube-13a4346c/description)
- [x] Download: [Download Link](Download\BuildProjectServerOLAPCube.ps1)

## Output from Technet Gallery

This PowerShell script will fire a cube build job. Using this script will bypass the need for users to access Central Admin to build an OLAP cube. The user running the script will still require the correct Project Server permissions to build a cube.

A code snippet can be seen below:

```
$cubeGUID = "00007829-4392-48b3-b533-5a5a4797e3c9"
$svcPSProxy.BuildOlapDatabase($cubeGUID)
```

This script also works for Project Server 2010.

The script will need to be updated with the correct PWA URL for the WebServiceProxy and the correct cube GUID. For further details on this script please see the following post:

http://pwmather.wordpress.com/2014/02/18/projectserver-2013-build-olap-cube-via-powershell-sp2013-ppm-ps2013/

