#!/bin/sh

xrandr --dpi 96
# shellcheck disable=SC1091
. "$XDG_DATA_HOME/screenlayout"
xwallpaper --zoom "$XDG_DATA_HOME/wallpaper"
xrdb -merge "$HOME/.Xresources"

xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Profile Enabled" 0 1 0
xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Speed" 0

pipewire &
wireplumber &
pipewire-pulse &
udiskie &
dunst &
picom &
sxhkd &
dwmblocks &

exec dbus-launch dwm
