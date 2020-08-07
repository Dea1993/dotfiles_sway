date_info=$(date "+%a %d %b %H:%M")

volume_level=$(exec amixer get Master -M | grep Right | grep "\[on\]" | grep -oE "[[:digit:]]*%")
if [ -z $volume_level ]; then
  volume_level="🔈"
else
  volume_level="🔊 $volume_level"
fi

brightness=$(brightnessctl i | grep -oE "[[:digit:]]*%")

# Returns the battery status: "Full" 🔹, "Discharging" 🔻, or "Charging" 🔺.
battery_status=$(cat /sys/class/power_supply/BAT0/status)
if [ $battery_status = "Discharging" ]; then
  battery_status="🔻"
else
  battery_status="🔺"
fi

battery_perc=$(cat /sys/class/power_supply/BAT0/capacity)

echo -e "$date_info $volume_level 🔆 $brightness $battery_status $battery_perc%"
