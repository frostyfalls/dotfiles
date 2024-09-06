#!/bin/sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96
xrandr \
    --output eDP-1 --off \
    --output HDMI-2 --primary --mode 1280x1024 --pos 0x0 --rate 75

export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME="nvidia"

[ -f "$XDG_DATA_HOME/wallpaper" ] && xwallpaper --zoom "$XDG_DATA_HOME/wallpaper" &
xrdb -merge "$HOME/.Xresources"

pipewire &
pipewire-pulse &
wireplumber &

dunst &
picom &
udiskie &
mpd --no-daemon &

modbot -x &

while :; do
    dbus-launch --sh-syntax --exit-with-session dwm
done
