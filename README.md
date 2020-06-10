vdi-tools - RaspberryPi VDI TOOLS
=======================================

## DESCRIPTION
Use a RaspberryPi as a Thinclient device.
Install 'Raspbian Stretch Lite' to your RaspberryPi and Setup following steps.

## SETUP
1. Clone
```
$ cd /opt
$ git clone https://github.com/HeavyMoon/vdi-tools.git
```
2. Install Remote Desktop Environment
```
$ sudo .vdi-tools/mainte/build-env.sh
```
3. After reboot, login as root and setup users
```
# /opt/vdi-tools/mainte/setup-usr.sh
```

## USAGE
1. Open console, then auto login as vdi user
2. Select `Preferences > Remmina Menu` and create a connection profile
3. Select `Preferences > Select a Connection Profile` and choose the profile that you created
4. Select `Connect`, then start Remote Desktop

## License
This software is released under the MIT License, see LICENSE.md.

