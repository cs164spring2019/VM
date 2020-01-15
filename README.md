# VM

### Creating a headless micro vm with bakerx

Pull an 3.9 alpine image.

```bash
bakerx pull ottomatica/slim#images alpine3.9-simple
```

Check which images are available on your system.

```bash
bakerx images
```

Verify image is pulled.


```
│  'alpine3.9-simple'   │ 'vbox.iso' │ 'qemu,vbox' │
```

### Virtual Machine Inspection through VirtualBox.

![img](imgs/VM-preview.png)


### Using VM 

Note the size of the image: XXMB

Connecting to VM.



Persistance lost.

Add a file.
Stopping VM. Starting VM. Check if file.




### Creating a headless VM with bakerx

Pull an 18.04 ubuntu image (codename 'bionic').

```bash
bakerx pull cloud-images.ubuntu.com bionic
```

Start an new virtual machine instance called `VM0`, using the 18.04 image

```bash
bakerx run VM0 bionic
```

Explaining output.
**
**
**

Wait for connection.

Sanity checking virtualization.


### Virtual Networking 

Your VM would not be very useful if it does not have any way to connect to a network.

There are four primary ways to virtualize the network:

* Network Address Translation (NAT), which is the default.
  ![VM-NAT](imgs/VM-NAT.png)
  A NAT network provides a simple way for your VM to connect to external networks. Incoming network requests are translated by the virtualization software and routed to the appropriate VM.


  Inside the VM, the network will appear as a private network.
  ```bash
  nanobox:~# ifconfig
  eth0      Link encap:Ethernet  HWaddr 08:00:27:DE:D2:AD  
            inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
            inet6 addr: fe80::a00:27ff:fede:d2ad/64 Scope:Link
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
   ```

   The address will not be addressable from the host machine.
   ```bash
   $ ping 10.0.2.15
   PING 10.0.2.15 (10.0.2.15): 56 data bytes
   Request timeout for icmp_seq 0
   Request timeout for icmp_seq 1
   ```

* Bridged network
   ![VM-Bridge](imgs/VM-bridged.png)
   A bridged network will share a host network interface, by filtering and routing network traffic belonging to the VM to a virtual network interface. In effect, your VM is on the same network as your host computer.

   On the host computer, you can see the following network.
   ```
   $ ifconfig
   en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500 options=400<CHANNEL_IO>
      inet6 fe80::4f:70a1:5a:8e6a%en0 prefixlen 64 secured scopeid 0x5 
      inet 10.154.40.185 netmask 0xffffc000 broadcast 10.154.63.255
   ```

   Inside the VM, it shares the same 10.154.x.x subnet as the host.

   ```bash
   nanobox:~# ifconfig
   eth1      Link encap:Ethernet  HWaddr 08:00:27:EF:CE:8F  
             inet addr:10.154.62.77  Bcast:10.154.63.255  Mask:255.255.192.0
   ```

   A bridged network can be useful if you want to interact with your VM from your host or even other computers on your network.

* Internal network

  An internal network allows multiple VMs on the same internal network to communicate; however, the network cannot be reached by the host. 

* Host-Only network.

  A host-only network creates a local loopback network on the host machine. Hosts and VMs can then communicate on the host-only network.

  ```bash
  $ ifconfig
  vboxnet24: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	ether 0a:00:27:00:00:18 
	inet 172.30.25.1 netmask 0xffffff00 broadcast 172.30.25.255
  ```

  Typically, VMs are statically assigned an IP address on the host-only network.

  One disadvantange of a host-only network is that it requires sudo/admin privilenges to create the host-only network on the host (the first time it is created).





Portforwarding.

Adding a bridge network in bionic.

### Creating an UP script.