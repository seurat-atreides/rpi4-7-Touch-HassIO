#!/bin/bash
xset s noblank
xset s off
xset -dpms

unclutter -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

i=0
until nc -z 127.0.0.1 8123
do
    sleep 1
    ((i++))

    if [ "${i}" -gt 120 ]; then
        echo "Port 8123 not reachable, aborting due to timeout!"
        exit 1
    fi
done

/usr/bin/chromium-browser --noerrdialogs --disable-infobars --kiosk http://127.0.0.1:8123 &

while true; do
#   xdotool keydown ctrl+Tab; xdotool keyup ctrl+Tab;
   sleep 10
done
