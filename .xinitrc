export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export DefaultIMModule=fcitx

xsetroot -cursor_name left_ptr
synclient TouchpadOff=1

#evel $(/usr/bin/gome-keyring-daemon --components=pskcs11,secrets,ssh)

#nm-applet &
nitrogen --restore &
compton --xrender-sync --xrender-sync-fence &
#urxvt &
fcitx-autostart &

#exec awesome
exec xmonad
