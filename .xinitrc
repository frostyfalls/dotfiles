#!/bin/sh

# shellcheck disable=SC1091

[ -f "$XDG_DATA_HOME/screenlayout" ] && . "$XDG_DATA_HOME/screenlayout"
[ -f "$XDG_DATA_HOME/wallpaper" ] && xwallpaper --zoom "$XDG_DATA_HOME/wallpaper"
xrdb "$HOME/.Xresources"
runsvdir "$SVDIR" &

xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Profile Enabled" 0 1 0
xinput set-prop "SOAI USB Gaming Mouse" "libinput Accel Speed" 0.2
setxkbmap -option caps:escape
xsetroot -cursor_name left_ptr

exec dbus-launch --sh-syntax --exit-with-session xmonad
