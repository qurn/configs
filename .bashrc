# ~/.bashrc

[[ $- != *i* ]] && return # If not running interactively, don't do anything

alias ls='ls --color=auto'
alias la='ls -a'

function F() {    # Dateinamen suchen in diesem DIR
    find . -name $1
}

source /usr/share/doc/ranger/examples/bash_automatic_cd.sh
alias r='ranger-cd'

function h() {
    $1 --help | less
}

function k() {
    killall -9 $1
}
# F1 new terminal in same folder
bind '"\e[11~": "( urxvt & ) &>/dev/null &\n"'

extract () {      # Entpackt alles
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.tar.xz)    xz -cd $1 | tar xvf - ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

#copy/move/make and change to dir
cpc(){
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}
mvc(){
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}
mkdirc(){
    mkdir $1
    cd $1
}

alias grep='grep --color=always' #grep color
grepl(){ #grep langsam
    grep -R $1 | less -R
}

alias up='sudo pacman -Syu'

function remove() {
    sudo pacman -Rs $1
}

alias octave='octave-cli'

alias restartnet='sudo /usr/bin/systemctl restart netctl-auto@wlp2s0.service'
alias stopnet='   sudo /usr/bin/systemctl stop    netctl-auto@wlp2s0.service'
alias startnet='  sudo /usr/bin/systemctl start   netctl-auto@wlp2s0.service'

#Monitor
internMon=eDP1
externMon=HDMI1
alias xrandrNoHDMI='xrandr --output eDP1 --auto --output HDMI1 --off'
alias xrandrALL='xrandr --output eDP1 --auto --output HDMI1 --auto'

xrandrToggleOne(){
    if xrandr | grep "$externMon disconnected"; then
        xrandr --output "$externMon" --off --output "$internMon" --auto
    else
        xrandr --output "$internMon" --off --output "$externMon" --auto
    fi
}
xrandrExtRight(){
    if xrandr | grep "$externMon disconnected"; then
        xrandr --output "$externMon" --off --output "$internMon" --auto
    else
        xrandr --output "$internMon" --primary --auto --output "$externMon" --right-of "$internMon" --auto
    fi
}

bluetoothStart(){
    sudo systemctl start bluetooth.service
    blueman-applet &
    xset m 3/2 0
}

export HISTSIZE=5000
PS1='\[\e[0;32m\][\W]\[\033[0m\]'

alias whatismyip='ip addr show'

export GOPATH=~/build/go
alias setxkbmapde='setxkbmap de -option "caps:escape"'
