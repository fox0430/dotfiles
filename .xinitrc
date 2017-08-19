export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=”@im=fcitx”

xsetroot -cursor_name left_ptr
synclient TouchpadOff=1

evel $(/usr/bin/gome-keyring-daemon --components=pskcs11,secrets,ssh)

nm-applet &
nitrogen --restore &
compton &
fcitx &
terminology &

#exec awesome
exec xmonad
