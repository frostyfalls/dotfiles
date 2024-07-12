#!/bin/sh

# shellcheck disable=SC1091

# Startup services and programs
[ -f "$XDG_DATA_HOME/screenlayout" ] && . "$XDG_DATA_HOME/screenlayout"
[ -f "$XDG_DATA_HOME/wallpaper" ] && xwallpaper --zoom "$XDG_DATA_HOME/wallpaper"
xrdb "$HOME/.Xresources"
runsvdir "$SVDIR" &

# Input mappings
xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Profile Enabled" 0 1 0
xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Speed" 0.2
setxkbmap -option caps:escape
xsetroot -cursor_name left_ptr

# PRIME offloading
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME="nvidia"

# Desktop session
exec dbus-launch --sh-syntax --exit-with-session xmonad
