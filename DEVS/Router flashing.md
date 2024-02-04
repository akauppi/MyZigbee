# Router flashing

By flashing a router firmware, the stick (perhaps a second one?) will work as a replicator/extender for the Zigbee network.

This page includes information on router firmware selection, flashing and router setup.


## Prep

First, read [Flashing](../Flashing.md) and set up the `unversal-silabs-flasher` as explained there.


## Firmware options

- Zigbee2MQTT > ... > ["How to create a SONOFF ZBDongle-E Router"](https://www.zigbee2mqtt.io/devices/ZBDongle-E.html#how-to-create-a-sonoff-zbdongle-e-router) leads to..

   >Note: None of the physical disassembly and button-pressing is needed, using `universal-silabs-flasher`. :)

   - ..via an interim page, to..

      - [itead/Sonoff_Zigbee_Dongle_Firmware](https://github.com/itead/Sonoff_Zigbee_Dongle_Firmware/tree/master/Dongle-E/Router) (GitHub)

         Has `Z3RouterUSBDonlge_EZNet6.10.3_V1.0.0.gbl`

         <!-- Note and ignore the typo. Oh well.. -->

- Anything... more recent?

   The issue ["\[REQUEST\] Silabs Zigbee EmberZNet 6.10.7.0 NCP firmware image ..."](https://github.com/itead/Sonoff_Zigbee_Dongle_Firmware/issues/23) (Aug'23) implies that:

   - ..there's a version 7 upcoming, one day?
   - ..that ITead could provide a later-than-2-years-old image on their repo

      At the least, we can keep that page as a list of "known bugs" in the 6.10.3 release.

### Flashing

```
$ universal-silabs-flasher --device /dev/ttyACM0 flash --firmware Z3Router*.gbl
```

### Pairing

There's nothing much to do about this.

- detach the router device
- set up your normal controller (unless it already was up)

You should see under `Devices`:

![](.images/router-paired.png)

### Troubleshooting

If the router isn't paired, check whether you can see blinking from near its antenna base. Blinking green means "ready to pair". Once paired, the blinking stops.


## References

- [universal-silabs-flasher](https://pypi.org/project/universal-silabs-flasher/) (pypi.org)

- [`SONOFF-Zigbee-3.0-USB-dongle-plus-firmware-flashing-.pdf`](https://sonoff.tech/wp-content/uploads/2022/07/SONOFF-Zigbee-3.0-USB-dongle-plus-firmware-flashing-.pdf) (PDF, xx pp., Jul'22)

   Sonoff official(?) advice on firmware flashing.

   On controller, [points to here](https://github.com/itead/Sonoff_Zigbee_Dongle_Firmware/tree/master/Dongle-E/NCP)

   "[..] with Silicon Labs standard EZSP (EmberZNet Serial Protocol) interface."

   <!-- 
   This looks interesting.. Much better than the other (ITead/Sonoff) page that just has a `.gbl` - and a typo. :]
   -->
