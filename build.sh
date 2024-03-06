#!/bin/bash

# cd to the directory of the script
cd "$(dirname "$0")"
cc -framework Foundation -framework IOKit reenumerate.m -o usb_refresh
sudo cp ./usb_refresh /usr/local/bin/usb_refresh
