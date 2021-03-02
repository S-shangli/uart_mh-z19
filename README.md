# uart_mh-z19
shell script for MH-Z19 via uart

## Usage
```
[yourmachine]% uart_mh-z19.sh /dev/ttyUSB0
524

[yourmachine]% uart_mh-z19.sh /dev/ttyUSB0 calzero
0

[yourmachine]% uart_mh-z19.sh /dev/ttyUSB0 calspan2000
0
```

## Software requirement
* zsh
* stty
* sleep
* xxd
* timeout
* dd
* tr
* sed
* bc

## Hardware requirement
* MH-Z19 / MH-Z19B
* AE-FT234X (FT234X) or similar Serial Interface

```
  AE-FT234X                  MH-Z19
+------------+             +----------+
|            |             |          |
|         5V *-------------* Vin      |
|            |             |          |
|        GND *-------------* GND      |
|            |             |          |
|         TX *-------------* Rx       |
|            |             |          |
|         RX *-------------* Tx       |
|            |             |          |
+------------+             +----------+

```


## known limitations
* Ignoring checksum of return value

