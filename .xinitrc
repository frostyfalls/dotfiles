#!/bin/sh

# shellcheck disable=SC1091

# Startup services and programs
. "$XDG_DATA_HOME/screenlayout"
xwallpaper --zoom "$XDG_DATA_HOME/wallpaper"
xrdb "$HOME/.Xresources"
runsvdir "$SVDIR" &

# Input mappings and options
xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Profile Enabled" 0 1 0
xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Speed" 0.2
setxkbmap -option caps:escape
xsetroot -cursor_name left_ptr

# Desktop session
exec dbus-launch --sh-syntax --exit-with-session xmonad
