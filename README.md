Script to reenumerate iOS USB devices on macOS when they've lost connection to your development tooling.

The script I use to copmile this is `./build.sh`. It will ask for your password to automatically install itself into `/usr/local/bin` which typically is already in my shell `PATH`. After this I can use the shell command `usb_refresh`; it's convenient for me when iterating on something running on my phone.


You may not wish to do this, so you can just compile as follows
```
$ cc -framework Foundation -framework IOKit reenumerate.m -o usb_refresh
$ ./usb_refresh
```

----


[Docs for
USBDeviceReEnumerate](https://opensource.apple.com/source/IOUSBFamily/IOUSBFamily-281.4.1/IOUSBFamily/Headers/IOUSBLib.h.auto.html)
