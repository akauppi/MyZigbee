#!/bin/sh
#
# Ad-hoc helper for reading a stick (Sonoff E).
#

universal-silabs-flasher --device /dev/ttyACM0  --probe-method ezsp --ezsp-baudrate 115200 probe