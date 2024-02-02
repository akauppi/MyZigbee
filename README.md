
# My Zigbee

How I set up a minor Zigbee network, with:

- [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)

  .. running within Docker, under Windows 10 Home

## Aims

Simplicity.

Learning Zigbee quirks and possibilities.


### Safety

I don't want to give the Docker container `privileged: true` rights (i.e. ability to do anything with the host Windows), or `networking: host` for that matter.

Instead, we bridge the dongle to WSL using USB/IP.

### Persistence

Stateful files are kept on the WSL filesystem.


## Requires

- WSL2 (requirement also for Docker)
- [`usbipd-win`](https://github.com/dorssel/usbipd-win) installed

   [MyZWave](https://github.com/akauppi/MyZWave?tab=readme-ov-file#steps) (GitHub) may help on this.

>Do `wsl --update` in a Windows (admin) command prompt.

### Hardware used

- [Sonoff Zigbee Dongle Plus <big>E</big>](https://www.proshop.fi/Smart-Home-Aelykoti/Sonoff-ZigBee-Gateway-ZigBee-30-USB-Dongle-Plus-E/3213488) - (Proshop; distributor)

- [Schneider / Wiser smoke alarm](https://www.zigbee2mqtt.io/devices/W599001.html) (Zigbee2MQTT > Devices)


## Prepare

### Driver install (`CH343`)

>*"Windows and macOS require corresponding driver installation."*

>I only tried with the driver; cannot say what is the experience if you don't install it. (let me know! Would **love** to avoid driver installs.)

Download from Sonoff (Windows): [link to zip](http://sonoff.tech/wp-content/uploads/2022/07/CH343SER.zip)

><small>The link is from https://sonoff.tech/product-review/how-to-use-sonoff-dongle-plus-on-home-assistant-how-to-flash-firmware/) (visited 1-Feb-24)</small>

<p />

>⚠️ Warn! Installing a driver is always a risk on your system. You don't really have a choice here, though.
>
>The zip contains a `LIB` folder with some sources, but there's no saying that the binaries (under `DRIVER`, with some awkward fodlers like `WIN1X`) match those. INSTALL ANY DRIVER AT YOUR OWN RISK!

- unzip
- either run the `SETUP.EXE`
- ..or right-click on the `.INF` file and > `Install`

>Running `SETUP.EXE` brought up a Windows safety dialog. Later, it didn't. The author yielded; installed by the `.INF`.

Sonoff gives ZERO GUIDANCE; likely they assume one to just shoot `SETUP` with no safety concerns. Back to 1990's?

---

>Note: Device Manager showed the driver the same before and after install, but `usbipd list` shows a difference:
>
>before ![](.images/usbipd-list-before-install.png)
>
>after ![](.images/usbipd-list-after-install.png)

---

### Create `data.z/configuration.yaml`

This file will eventually contain your network key, and info about the device you've paired. The author didn't come up with a better way than... please copy-paste the template from here. :)

```yaml
homeassistant: false
mqtt:
  base_topic: zigbee2mqtt
  server: mqtt://mqtt
frontend:
  port: 8088
permit_join: true
# Eventually, you'll turn this to 'false', right?
serial:
  port: /dev/ttyZIGBEE
  adapter: ezsp
  # This is very important - automatic discovery did NOT detect the Sonoff "plus v2" dongle correctly! 
advanced:
  network_key: GENERATE
  # Zigbee2MQTT will replace this with a key
```

Note that while comments are tolerated, they will be lost eventually. Zigbee2MQTT writes stuff back to this file.


## Steps

1. Attach the USB stick to WSL

   In an admin `cmd.exe` prompt:

   ```
   >usbipd list
   Connected:
   BUSID  VID:PID    DEVICE
   3-1    1a86:55d3  USB-Enhanced-SERIAL CH9102 (COM7)
   [...snipped]
   ```

   ```
   >usbipd bind -b 3-1
   ```

   ```
   > usbipd attach --wsl -b 3-1
   usbipd: info: Using WSL distribution 'Ubuntu' to attach; the    device will be available in all WSL 2 distributions.
   usbipd: info: Using IP address 172.25.32.1 to reach the host.
   ```

   Within WSL, see that the device is seen:

   ```
   $ lsusb
   [...]
   Bus 001 Device 002: ID 1a86:55d4 QinHeng Electronics SONOFF Zigbee 3.0 USB Dongle Plus V2
   [...]
   ```

2. Launch the Docker container

   ```
   $ dc up -d
   [+] Running 2/2
    ✔ Container myzigbee-mosquitto-1    
       Healthy                                                                         6.7s
    ✔ Container zigbee2mqtt           Started
   ```

   >For seeing the logs, check Docker Desktop > `Containers` > (pick) > `Logs`

   ---

   >Note: If there is an error communicating with the dongle (but [flashing](./Flashing.md) succeeded), check the `serial` > `adapter` type field in the config. The author needed to
   explicitly set it to force the dongle to EZSP.


3. Open [localhost:8088](http://localhost:8088)

   Tada!!  (hopefully)


4. Attach the devices

   Read device specific instructions. 

   >e.g. for the Wiser smoke alarm [press reset 3 times fast](https://www.productinfo.schneider-electric.com/wiser_eu/wiser-smoke-alarm-230-v_device-user-guide_wiser_se/English/Wiser%20Smoke%20Alarm%20230%20V_WSE_Device%20user%20guide_0001066064.xml/$/PairingDeviceManually_WSE_SmokeAlarm-BatteryTSK_0000854799) - or use an install code.

   **Install code**

   Did not work, see [this issue](https://github.com/Koenkk/zigbee2mqtt/discussions/19982).

   **Manual**

   - press "S/R" button thrice, within 2s
   - LED should blink yellow
   - Turn to Z2M and you should see:

   ![](.images/smokey-is-found.png)
   
   That's it!

5. Reading data

   <font color=red>tbd.</font>

<!--
   ..and whatever I do with it
   -->


<!-- tbd.
## Summary
-->

## Notes

### Remember to update!

Docker doesn't automatically pull `:latest`. Every now and then:

- `docker compose down`
- Pull new from Docker UI, or manually
- `docker pull koenkk/zigbee2mqtt:latest`
- `docker compose up`

### Better radio

- Use at least 50cm of a USB extension cable. Zigbee2MQTT docs have plenty on this.

### Quality in 🇨🇳

Sonoff leaves things lacking, in documentation and attention to (English) detail. <!-- hidden: Espressif does this great! Go learn.-->

**Driver installation**

The experience is shady, at best.
 
**Open source software**

[Firmware page](https://github.com/itead/Sonoff_Zigbee_Dongle_Firmware/tree/master/Dongle-E/Router) on GitHub:

![](.images/really.png)

>Am I being picky here?
>
>But this doesn't raise confidence a single bit. And we should be able to trust vendors on a) their hardware, b) the software, c) the documentation.

So far, giving Sonoff only ⭐️⭐️⭐️ stars out of 5.


### Flashing

See [Flashing](./Flashing.md).


<!-- tbd.
### Second dongle as repeater

https://sonoff.tech/wp-content/uploads/2023/02/SONOFF-Zigbee-3.0-USB-dongle-plus-firmware-flashing.pdf
-->


## References

- [Zigbee 3.0 USB Dongle Plus](https://sonoff.tech/product/gateway-and-sensors/sonoff-zigbee-3-0-usb-dongle-plus-e/)

   Sonoff product page. Recommended to browse through **before** starting the use!  Has nice comparison with their earlier model, etc.

- [Instructions on SparkFun](https://learn.sparkfun.com/tutorials/how-to-install-ch340-drivers/windows-710)

   ..show some screenshots and how to validate the driver has installed in Device Manager. 
