[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xmodmap .xmodmap.conf
setxkbmap de -option "caps:escape" &
slstatus &
dunst &
xbanish &
xset s noblank &
xset s off &
xset -dpms &
exec dwm
