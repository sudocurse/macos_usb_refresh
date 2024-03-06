#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>
#include <IOKit/IOCFPlugIn.h>
#import <IOKit/usb/IOUSBLib.h>

int main() {
    NSMutableDictionary *match = (__bridge NSMutableDictionary *)IOServiceMatching("IOUSBDevice");
    if (match == nil) { return -1; }
    match[@"IOPropertyMatch"] = @{@"SupportsIPhoneOS": @YES};
    
    io_iterator_t iterator = 0;
    kern_return_t status = IOServiceGetMatchingServices(kIOMainPortDefault, (__bridge CFDictionaryRef)(match), &iterator);
    if (status != KERN_SUCCESS) { return -1; }
    
    io_object_t next = IOIteratorNext(iterator);
    while (next != IO_OBJECT_NULL) {
        IOCFPlugInInterface **interface = NULL;
        IOUSBDeviceInterface187 **dev = NULL;
        SInt32 theScore = 0;
        status = IOCreatePlugInInterfaceForService(next, kIOUSBDeviceUserClientTypeID, kIOCFPlugInInterfaceID, &interface, &theScore);
        if (status == KERN_SUCCESS && interface != NULL) {
            status = (*((*interface)->QueryInterface))(interface, CFUUIDGetUUIDBytes(kIOUSBDeviceInterfaceID187), (LPVOID *)&dev);
            if (status == KERN_SUCCESS) {
                if ((*((*dev)->USBDeviceOpen))(dev) == KERN_SUCCESS) {
                    (*((*dev)->USBDeviceReEnumerate))(dev, 0);
                }
            } else {
                fprintf(stderr, "QueryInterface returned %d.\n", status);
            }
            
        } else {
            fprintf(stderr, "IOCreatePlugInInterfaceForService returned 0x%08x\n", status);
        }
        
        if (dev != NULL) {
            (*((*dev)->USBDeviceClose))(dev);
            (*((*dev)->Release))(dev);
        }
        if (interface != NULL) {
            (*((*interface)->Release))(interface);
        }
        IOObjectRelease(next);
        next = IOIteratorNext(iterator);
    };
    
    
    if (iterator != IO_OBJECT_NULL) {
        IOObjectRelease(iterator);
    }
    return 0;
}
