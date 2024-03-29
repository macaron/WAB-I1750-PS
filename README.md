# OpenWrt WAB-I1750-PS

I tried building an OpenWrt firmware for WAB-I1750-PS using GitHub Actions.

## Disclaimer

Use at your own risk. I take no responsibility if your device explodes.

<img width="971" alt="" src="https://github.com/macaron/WAB-I1750-PS/assets/19354702/b7f19f4c-fa53-46ff-b742-cce49e7a6c6a">

## Download OpenWrt binary

https://github.com/macaron/WAB-I1750-PS/releases

## Build

### Quick build (Docker required)

```bash
docker run --rm -t -v$(pwd):/openwrt/bin rtlsdr/wab-i1750-ps
```

### Customize config

```bash
git clone https://github.com/macaron/WAB-I1750-PS && cd WAB-I1750-PS
docker run --name builder -it rtlsdr/wab-i1750-ps make menuconfig
docker cp builder:/openwrt/.config . && docker rm builder
docker run --rm -t -v$(pwd)/.config:/openwrt/.config -v$(pwd):/openwrt/bin rtlsdr/wab-i1750-ps
```

## Restore official firmware

- Download latest firmware from elecom support https://www.elecom.co.jp/support/download/network/wireless_lan/ap/wab-i1750-ps/
- `dd if=WAB-I1750-PS-FW-V1-5-10.bin of=WAB-I1750-PS-FW-V1-5-10.bin.enc bs=1 skip=128`
- Run decrypt.py
  - e.g. `python3 decrypt.py WAB-I1750-PS-FW-V1-5-10.bin.enc 8844a2d168b45a2d dec.bin`
- Confirm that the firmware is not corrupted using the "file" command.
  - `u-boot legacy uImage, Linux Kernel Image, Linux/MIPS, OS Kernel Image (lzma), 6394657 bytes, Mon Dec 28 01:40:56 2020, Load Address: 0X80002000, Entry Point: 0X802C2E90, Header CRC: 0XF8E45FC3, Data CRC: 0X2FDEDA29`
- Upload dec.bin http://192.168.1.1/cgi-bin/luci/admin/system/flash
  - :warning: **Do not turn off the power while the red LED is blinking.**
- Poweroff
- Go 192.168.3.1 ID:admin PW:admin, Don't forget change your machine ip address.(In my case, 192.168.3.2/24)

## Thanks

- https://github.com/openwrt/openwrt
- https://github.com/masebb/openwrt-WAB-I1750-PS
- https://github.com/openwrt/openwrt/pull/3661
- https://github.com/musashino205/openwrt/commit/34d77170457b714e71bcdd33b53e821494bbfd3b
