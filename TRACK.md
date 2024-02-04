# Track

## `start_interval` etc.

- [health check with higher rate during start_period](https://github.com/docker/compose/issues/10461) (GitHub Issues; `docker/compose`)

   Going to be implemented in "25.0.0". 

   >new parameter like start_interval to override the interval period during the start_period


## Install codes with zigbee2mqtt

- [Unsupported install code](https://github.com/Koenkk/zigbee2mqtt/discussions/19982)

   Pairing with install code seems to be .. in the works?


## EmberZNet 7.2.x (or 7.3.x) router firmware?

- ["[REQUEST] Silabs Zigbee EmberZNet 6.10.7.0 NCP firmware image for Sonoff ZBDongle-E by ITead"](https://github.com/itead/Sonoff_Zigbee_Dongle_Firmware/issues/23)
- ["[REQUEST] Alpha and/or Beta release versions of latest EmberZNet 7.2.x (7.2.x.x) Zigbee Coordinator NCP firmware images for testers to test on Sonoff ZBDongle-E"](https://github.com/itead/Sonoff_Zigbee_Dongle_Firmware/issues/21)

   It's not exactly this issue, but *somewhere* (in 2024) there should be an EmberZNet 7.x <u>router</u> firmware to try. 
   
   Why does it matter?

   - having only one image (6.10.3.0) available, two years old and counting, does not raise confidence. It's not the lack of features. It's knowing that the hw vendor can provide updates. (Also, they have provided zero replies to the 20 issues on the site. *sigh*)
