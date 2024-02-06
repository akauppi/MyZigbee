# Range / signal quality

>Disclaimer: Text herein is only the author's *current understanding based on experiments* on what the numbers mean, and how to interpret the map. Advice is welcome!

## Measuring signal quality

The `Devices` page seems to carry old LQI (signal quality) information, or refresh it really seldom. A better (real) view is gotten by the `Map` feature:

![](.images/network-map.png)

In this case, Router gets `133/226`.

### Analysis

- **Leaf nodes** only provide one number: how strong the signal they send is, from the router/controller connected to them.

   |||
   |---|---|
   |>20?|no worries, we see you|
   |0 (but line)|weird; should have a better number (maybe `0` means overwhelmingly good contact??)|
   |no line|cannot reach the node|

- **Routers** provide (normally) two numbers: incoming and outgoing (tbd. which order??)

   |||
   |---|---|
   |tuple, both values >50?|okay|
   |tuple, low values|worry|
   |single value|seeing this on low connections. Regard it as "no connection", no matter what the value|


Here are surveys I did at home. Left the router in a known place, and checked the `Map` values, in certain places around the house.

||5 dBm|20 dBm|
|---|---|---|
|eteinen|209/252, 214/255|--|
|alakerta|159/173|--|
|sivuovi|148/177|--|
|pyöräk.|<font color=red>NO</font>|<font color=red>NO</font>|
|kellari|<font color=red>84 (one way)</font>, 53/76, 48/74|<font color=red>39 (one way), 36</font>|
|käytävä|55/82|80/39|

Notes:

The second number (controller listening?) is (almost) always higher then the first (controller sending?).

Boosting to 20 dBm **does not really help** the communication! It seems that the higher transmission power reduces the fidelity of the controller in listening!

>I did also another survey, so the above conclusions are not based on just the numbers you see.


## Real life performance 🚧🧱🧱

Using Sonoff Zigbee 3.0 "dongle plus V2" (E) devices as both controller and router, I can summarize that:

- you can build a network 2..3 stories high
- the signal doesn't penetrate brick walls easily; roughly one outer wall


## Ways to improve coverage ⚗️

You've likely thought about the usual ones:

- USB extension cord
- antenna placement

### Pumping up Power

Doesn't seem to do much (see "analysis", above). 

<details border:1px,solid,blue><summary>Click to review..</summary>
The "E" sticks allow setting output power to 20 dBm (from default 5). Note that this *only affects outgoing traffic* - not listening - and therefore the conservative value may be better. 

>IF we have a way to flash the routers with 20 dBm, that may be useful. Even then, the results need to be measured.

**Controller**

Add in `configuration.yaml`: 

```yaml
advanced:
  transmit_power: 20
```

**Router**

ChatGPT (well, Bing conversation) knows to tell that the Sonoff "P" router image is set to 9dbM (instead of normal 5), but don't have info on the "E" router image.

= this **likely** requires changing the parameters before flashing the router device.

**Results**

With a simple controller <-> router in neighbouring rooms:

|dbM||
|---|---|
|5|193/232, 193/235, 193/235|
|20|189/216, 200/236, 205/224|

*Between measurements, the controller process was completely restarted. The values are from the `Map` page.*

Based on this sample, pumping up power may even have a negative effect on signal quality.

<!--
>More study needed, especially in situations where the two are father apart.
-->

<!-- tbd.
- [ ] Is the first number signal strength at router, or vice versa?
-->
</details>

### Positioning

- Use windows between controller/router (or multiple routers), to provide "line of sight" (of radio), if possible.

- Place controllers/routers on the same floors, if possible (if going between buildings): this should reduce dampening caused by the floors

### Changing channels

<font color=green>**Have not played with this!**</font>

Zigbee networks can be set to a certain channel (default is "11"). 

- [ ] How does this reflect with a potentially congested WLAN environment?
- [ ] Would some channels provide better range than "11"?

>"Generally zigbee channels 15, 20, 25, and 26 are considered the best options."

<p />

>"ZHA defaults to zigbee channel 15. Z2M defaults to zigbee channel 11." <sub>[source](https://community.home-assistant.io/t/philips-hue-or-zigbee-dongle/412033/25?page=2)</sub>


See ["Reduce Wi-Fi interference by changing the Zigbee channel"](https://www.zigbee2mqtt.io/advanced/zigbee/02_improve_network_range_and_stability.html#reduce-wi-fi-interference-by-changing-the-zigbee-channel) (Zigbee2MQTT docs)

## Ideas..? (open)

- How can an Ethernet back-bone between buildings be used to extend the reach of Zigbee; or is e.g. Matter better suited for such?


## References

- ["Improve network range and stability"](https://www.zigbee2mqtt.io/advanced/zigbee/02_improve_network_range_and_stability.html) (Zigbee2MQTT docs)
