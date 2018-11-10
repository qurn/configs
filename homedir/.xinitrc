[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
setxkbmap de -option "caps:escape" &
slstatus &
dunst &
xset s noblank &
xset s off &
xset -dpms &
exec dwm
