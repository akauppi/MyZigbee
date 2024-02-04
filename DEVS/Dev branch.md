# Dev branch

To use the Zigbee2MQTT dev branch, edit `configuration.yaml` (or do a separate one with):

```
services:
  zigbee2mqtt:
    image: koenkk/zigbee2mqtt:latest-dev
    volumes:
      - ./data.z.dev:/app/data:rw
```

i.e. use a separate data folder than for the non-dev. Just in case.

Copy the `configuration.yaml` to `data.z.dev`.

>Should that work? :S

