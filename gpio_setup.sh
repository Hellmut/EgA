#!/bin/sh

echo 6 > /sys/class/gpio/export;
echo 13 > /sys/class/gpio/export;
echo 19 > /sys/class/gpio/export;
echo 26 > /sys/class/gpio/export;

echo out > /sys/class/gpio/gpio6/direction;
echo out > /sys/class/gpio/gpio13/direction;
echo out > /sys/class/gpio/gpio19/direction;
echo out > /sys/class/gpio/gpio26/direction;

chmod a+w /sys/class/gpio/gpio6/value;
chmod a+w /sys/class/gpio/gpio13/value;
chmod a+w /sys/class/gpio/gpio19/value;
chmod a+w /sys/class/gpio/gpio26/value;

exit 0;

