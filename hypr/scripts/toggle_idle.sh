#!/bin/sh

if pgrep -x "hypridle" > /dev/null
then
    pkill hypridle
    notify-send "Hypridle Disabled" -t 2000
else
    hypridle &
    notify-send "Hypridle Enabled" -t 2000
fi
