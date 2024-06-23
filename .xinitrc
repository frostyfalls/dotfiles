#!/bin/sh

. "$XDG_DATA_HOME/screenlayout" &
xwallpaper --zoom "$XDG_DATA_HOME/wallpaper" &
xrdb "$HOME/.Xresources" &
runsvdir "$SVDIR" &

xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Profile Enabled" 0 1 0 &
xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Speed" 0.5 &
setxkbmap -option caps:escape &

export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME="nvidia"

exec dbus-launch --sh-syntax --exit-with-session xmonad
