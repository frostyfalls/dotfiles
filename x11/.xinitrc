#!/bin/sh

xrandr --dpi 96

[ -f "$XDG_DATA_HOME/screenlayout" ] && . "$XDG_DATA_HOME/screenlayout"
[ -f "$XDG_DATA_HOME/wallpaper" ] && xwallpaper --zoom "$XDG_DATA_HOME/wallpaper"
[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

if xinput | grep "SOAI USB Gaming Mouse" >/dev/null 2>&1; then
    xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Profile Enabled" 0 1 0
    xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Speed" 0
fi
if xinput | grep " USB OPTICAL MOUSE" >/dev/null 2>&1; then
    xinput set-prop " USB OPTICAL MOUSE" "libinput Accel Profile Enabled" 0 1 0
    xinput set-prop " USB OPTICAL MOUSE" "libinput Accel Speed" 0.3
fi

pipewire &
wireplumber &
pipewire-pulse &
picom &
dunst &
udiskie &
dwmblocks &

exec dbus-launch --exit-with-session dwm
