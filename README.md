# matlab-gnuradio-baseband
GNU Radio SDR raw .bin format into Matlab .bb baseband format.

SSID beacon decoder from [Mathworks example](https://www.mathworks.com/help/wlan/examples/802-11-ofdm-beacon-receiver-with-live-data.html).

REQUIRES non-free Matlab toolboxes including:

* [Communications Toolbox](https://www.mathworks.com/help/comm/index.html)
* [WLAN Toolbox](https://www.mathworks.com/help/wlan/index.html)


## Usage

1. record 20 MHz wide WiFi channel with SDR and GNU Radio, save to .bin file in complex 32-bit float
2. use bin2bb.m to convert .bin to Matlab .bb
3. use decode_wifi_beacom.m to display WiFi SSID beacons


## Note

I did not yet test this because I'm waiting for WLAN Toolbox license.
