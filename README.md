Script to reenumerate iOS USB devices on macOS when they've lost connection to your development tooling.

To compile, all you need to do is run `./build.sh`. It will ask for your password to automatically install itself into `/usr/local/bin` which should already be in your path. 

Once it's in place, to run, simply type:
```
usb_refresh
```


Docs for USBDeviceReEnumerate:

 ```
  /*!
    @function USBDeviceReEnumerate
    @abstract   Tells the IOUSBFamily to reenumerate the device.
    @discussion This function will send a terminate message to all clients of the IOUSBDevice (such as 
                IOUSBInterfaces and their drivers, as well as the current User Client), emulating an unplug 
                of the device. The IOUSBFamily will then enumerate the device as if it had just 
                been plugged in. This call should be used by clients wishing to take advantage 
                of the Device Firmware Update Class specification.  The device must be open to use this function, except when you are passing the kUSBReEnumerateCaptureDeviceBit or 
                kUSBReEnumerateReleaseDeviceBit options.  In those cases you either need to (1) have the "com.apple.vm.device-access" entitlement set and the IOUSBDevice needs to have successfully been authorized by
                the IOKit's IOServiceAuthorize() APIs or (2) run with root privileges. 
    @availability This function is only available with IOUSBDeviceInterface187 and above.
    @param      self Pointer to the IOUSBDeviceInterface.
    @param      options A UInt32 with a bit mask of options.  See USB.h and the USBReEnumerateOptions enum.  If the kUSBReEnumerateCaptureDeviceBit is used
                the client needs to either (1) have the "com.apple.vm.device-access" entitlement set and the IOUSBDevice needs to have successfully been authorized by
                the IOKit's IOServiceAuthorize() APIs or (2) run with root privileges.  Using that bit will terminate any kernel drivers for all non-mass storage interfaces
                attached to the device, as well as for any kernel driver that is attached to the device.  Specifying the kUSBReEnumerateReleaseDeviceBit will cause the IOUSBDevice to
                be returned to the OS and the driver for that device to be reloaded.
    @result     Returns kIOReturnSuccess if successful, kIOReturnNoDevice if there is no connection to an IOService,
                or kIOReturnNotOpen if the device is not open for exclusive access.
    */

```
