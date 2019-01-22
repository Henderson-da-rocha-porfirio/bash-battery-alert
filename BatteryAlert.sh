#!/bin/bash

BATTERY=$(upower -e | grep 'BAT')

while :
do
    BATTERY_PERCENTAGE=$(upower -i "$BATTERY"|grep percentage|awk '{ print $2 }'|sed s/'%'/''/g)
    CABLE=$(upower -d | grep -n2 line-power | grep online | awk '{ print $3 }')

    if [[ "$BATTERY_PERCENTAGE" -lt "30" && $CABLE = "no" && "$DISPLAY" ]]; then
		notify-send -u critical \
        	-i /usr/share/icons/Antu-icons-master/status/64/dialog-error.svg \
         	-t 2000 "WARNING: Battery is about to die"  "Plug in the power cable";
       	aplay '/home/adspectus/BATTERY_ALERT/127708__cydon__alarm-003.wav' &> /dev/null 
    fi

sleep 10

done
        
