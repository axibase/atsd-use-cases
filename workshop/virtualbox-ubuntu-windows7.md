# Installing Windows 7 on VirtualBox in Headless Mode

## Overview

The note describes how to install Microsoft Windows 7 on Ubuntu 14.04 LTS server in headless mode.

### Configure Virtual Box

Check the Virtual Box version.

```sh
VBoxManage --version
```

```txt
4.3.36_Ubuntur105129
```

List the installed Virtual Box extensions.

```sh
VBoxManage list extpacks
```

```txt
Extension Packs: 1
Pack no. 0:   VNC
Version:      4.3.36
Revision:     105129
Edition:
Description:  VNC plugin module
VRDE Module:  VBoxVNC
Usable:       true
Why unusable:
```

If the `VBoxVRDP` [extension](https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm-vrde) is **not installed**, [download](https://download.virtualbox.org/virtualbox/) the compatible extension pack.

```sh
wget https://download.virtualbox.org/virtualbox/4.3.36/Oracle_VM_VirtualBox_Extension_Pack-4.3.36-105129a.vbox-extpack
```

Install the `VBoxVRDP` extension pack under the `root` privileges.

```sh
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.3.36-105129a.vbox-extpack
```

```txt
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Successfully installed "Oracle VM VirtualBox Extension Pack".
```

List the extensions again to verify that `VBoxVRDP` is installed.

```sh
VBoxManage list extpacks
```

```txt
Extension Packs: 2
Pack no. 0:   Oracle VM VirtualBox Extension Pack
Version:      4.3.36
Revision:     105129
Edition:
Description:  USB 2.0 Host Controller, Host Webcam, VirtualBox RDP, PXE ROM with E1000 support.
VRDE Module:  VBoxVRDP
Usable:       true
Why unusable:

Pack no. 1:   VNC
Version:      4.3.36
Revision:     105129
Edition:
Description:  VNC plugin module
VRDE Module:  VBoxVNC
Usable:       true
Why unusable:
```

Configure the Virtual Box to run only the RDP extension (no VNC).

```sh
VBoxManage setproperty vrdeextpack "Oracle VM VirtualBox Extension Pack"
```

## Download Windows VM

Download the VM image from the Microsoft Developer [site](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/)

```sh
wget -O IE11.Win7.VirtualBox.zip https://az792536.vo.msecnd.net/vms/VMBuild_20180102/VirtualBox/IE11/IE11.Win7.VirtualBox.zip
```

```sh
unzip IE11.Win7.VirtualBox.zip
```

Rename the `ova` file, mostly out of convenience to avoid dealing with spaces in file names.

```sh
mv IE11\ -\ Win7.ova IE11_Win7.ova
```

## Import Window VM

Check the VM properties.

```sh
VBoxManage import IE11_Win7.ova --dry-run
```

```txt
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Interpreting /home/axibase/win_vm/IE11_Win7.ova...
OK.
Disks:  vmdisk1 42949672960-1 http://www.vmware.com/interfaces/specifications/vmdk.html#streamOptimized IE11 - Win7-disk001.vmdk -1 -1
Virtual system 0:
 0: Suggested OS type: "Windows7"
    (change with "--vsys 0 --ostype <type>"; use "list ostypes" to list all possible values)
 1: Suggested VM name "IE11 - Win7"
    (change with "--vsys 0 --vmname <name>")
 2: Number of CPUs: 1
    (change with "--vsys 0 --cpus <n>")
 3: Guest memory: 4096 MB
    (change with "--vsys 0 --memory <MB>")
 4: Sound card (appliance expects "", can change on import)
    (disable with "--vsys 0 --unit 4 --ignore")
 5: Network adapter: orig NAT, config 3, extra slot=0;type=NAT
 6: IDE controller, type PIIX4
    (disable with "--vsys 0 --unit 6 --ignore")
 7: IDE controller, type PIIX4
    (disable with "--vsys 0 --unit 7 --ignore")
 8: Hard disk image: source image=IE11 - Win7-disk001.vmdk, target path=/home/axibase/VirtualBox VMs/IE11 - Win7/IE11 - Win7-disk001.vmdk, controller=6;channel=0
    (change target path with "--vsys 0 --unit 8 --disk path";
    disable with "--vsys 0 --unit 8 --ignore")
```

Import the VM with the default settings by running `VBoxManage import IE11_Win7.ova` or modify the settings.

Check settings by adding `--dry-run argument` prior to importing the VM.

```sh
VBoxManage import IE11_Win7.ova \
  --vsys 0 --cpus 4 --memory 4096 --vmname ie11-win7 \
  --unit 8 --disk /home/axibase/vms/ie11-win7.vmdk \
  --dry-run
```

The import process takes 3-5 minutes.

```txt
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Interpreting /home/axibase/win_vm/IE11_Win7.ova...
OK.
Disks:  vmdisk1 42949672960 -1 http://www.vmware.com/interfaces/specifications/vmdk.html#streamOptimized IE11 - Win7-disk001.vmdk -1 -1
Virtual system 0:
 0: Suggested OS type: "Windows7"
    (change with "--vsys 0 --ostype <type>"; use "list ostypes" to list all possible values)
 1: VM name specified with --vmname: "ie11-win7"
 2: No. of CPUs specified with --cpus: 4
 3: Guest memory specified with --memory: 4096 MB
 4: Sound card (appliance expects "", can change on import)
    (disable with "--vsys 0 --unit 4 --ignore")
 5: Network adapter: orig NAT, config 3, extra slot=0;type=NAT
 6: IDE controller, type PIIX4
    (disable with "--vsys 0 --unit 6 --ignore")
 7: IDE controller, type PIIX4
    (disable with "--vsys 0 --unit 7 --ignore")
 8: Hard disk image: source image=IE11 - Win7-disk001.vmdk, target path=/home/axibase/vms/ie11-win7.vmdk, controller=6;channel=0
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Successfully imported the appliance.
```

Check that the `vmdk` disk is located as configured in the `target path` setting.

```sh
ls -lah /home/axibase/vms
```

```txt
total 12G
drwx------  2 axibase axibase 4.0K Jun 12 15:37 .
drwxr-xr-x 65 axibase axibase 4.0K Jun 12 15:37 ..
-rw-------  1 axibase axibase  12G Jun 12 15:41 ie11-win7.vmdk
```

## Attach Shared Folder

Create a directory on the host that will be mapped to the VM.

```sh
mkdir /home/axibase/win_vm/ie_disk
```

```sh
VBoxManage sharedfolder add ie11-win7 --name ie_disk --hostpath /home/axibase/win_vm/ie_disk --automount
```

## RDP Connection

To connect to the guest VM, configure settings for the native RDP server or for the VirtualBox built-in `VRDE` extension.

The native RDP connection supports attaching local folders as shared folders.

### Native RDP Connection

Open **Control Panel > System** and check **Remote Settings**. Modify the Windows firewall to enable remote RDP access.

Configure a port forwarding rule to tunnel RDP connections into the guest VM on the default RDP port `3389`.

The external host port is set to `3389` in the example below.

```sh
VBoxManage controlvm ie11-win7 natpf1 "rdp,tcp,,3389,,3389"
```

### `VRDE` RDP Connection

Review VM attributes.

```sh
VBoxManage showvminfo ie11-win7 | grep "VRDE property: TCP"
```

```txt
VRDE property: TCP/Ports  = "5989"
VRDE property: TCP/Address = "127.0.0.1"
```

If the `TCP/Address` is set to `127.0.0.1`, the VM is accessible only to the local clients.

To reconfigure the VM to listen on all interfaces change the `TCP/Address` to `0.0.0.0`.

```sh
VBoxManage modifyvm ie11-win7 --vrdeaddress "0.0.0.0"
```

> The port can be changed with `--vrdeport 5989`

List the VM properties again and check that the RDP address and port are set as expected.

```sh
VBoxManage showvminfo ie11-win7 | grep "VRDE property: TCP"
```

```txt
VRDE property: TCP/Ports  = "5989"
VRDE property: TCP/Address = "0.0.0.0"
```

## Start VM

```sh
VBoxManage startvm ie11-win7 --type headless
```

```txt
Waiting for VM "ie11-win7" to power on...
VM "ie11-win7" has been successfully started.
```

## Connect to Guest VM

Connect to the VM under the `Administrator` or `IEUser` using the `Passw0rd!` password.

### SSH Tunnel

Use SSH tunnel to connect to the VM restricted to local clients from `127.0.0.1`.

* RDP

```sh
ssh -L 3389:127.0.0.1:3389 user@example.org -p 22 -i /path/to/ssh_priv_key
```

* `VRDE`

```sh
ssh -L 5989:127.0.0.1:5989 user@example.org -p 22 -i /path/to/ssh_priv_key
```

When connecting to the VM, specify `localhost` instead of the host IP address.

![](./images/vbox_rdp_localhost.png)

### Add Firewall Rules

Configure the firewall to grant access to the `VRDE` port or external RDP port, as configured.

* Allow access to `5589` clients from `192.0.2.1`

```sh
sudo ufw allow from 192.0.2.1 to any port 5589
```

* Allow access to `5589` clients from any IP address

```sh
sudo ufw allow 5589
```

If the connection fails, check that the VM is listening on all interfaces on the configured RDP port and add firewall rules if necessary.

```sh
netstat -l | grep 5989
```

```txt
tcp        0      0 *:5989                  *:*                     LISTEN
```

## Application Port Forwarding

To forward application traffic from host port `12000` to guest port `11000`, add the following NAT rule.

```sh
VBoxManage modifyvm ie11-win7 --natpf1 "test,tcp,,12000,,11000"
```

The `controlvm` allows adding or deleting port forwarding rules without restarting the VM.

```sh
VBoxManage controlvm ie11-win7 natpf1 delete test
VBoxManage controlvm ie11-win7 natpf1 "test,tcp,,12000,,10000"
```

## Connect to RDP

## Check VM Settings

![](./images/vbox_ie_win7.png)

## Modifying VM Settings

Stop the VM by initiating the shutdown from the guest OS or by powering off the VM.

```sh
VBoxManage controlvm ie11-win7 poweroff
```

Run `modifyvm` to increase CPU count or memory.

```sh
VBoxManage modifyvm ie11-win7 --cpus 4
```

## Delete VM

```sh
VBoxManage unregistervm ie11-win7 --delete
```