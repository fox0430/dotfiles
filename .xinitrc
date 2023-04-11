export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx5"
export DefaultIMModule=fcitx5

xsetroot -cursor_name left_ptr
xset b off

#evel $(/usr/bin/gome-keyring-daemon --components=pskcs11,secrets,ssh)
#export SSH_AUTH_SOCK

fcitx5 &

#exec awesome
exec xmonad
