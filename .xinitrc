export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export DefaultIMModule=fcitx

xsetroot -cursor_name left_ptr
xset b off

synclient TouchpadOff=1
#X1 Carbon 2018 6th trackpoint speed
xinput set-prop 12 152 1 0 0 0 1 0 0 0 0.2

#evel $(/usr/bin/gome-keyring-daemon --components=pskcs11,secrets,ssh)
#export SSH_AUTH_SOCK

fcitx-autostart &

#exec awesome
exec xmonad
