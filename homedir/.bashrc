# ~/.bashrc
[[ $- != *i* ]] && return # If not running interactively, don't do anything
set -o vi
complete -cf sudo
export GOPATH=~/build/go
export HISTSIZE=5000
export HISTCONTROL=ignoredups
source /usr/share/doc/pkgfile/command-not-found.bash
PS1='\[\e[0;32m\][\W]\[\033[0m\]'
bind '"\e[13~": "( urxvt & ) &>/dev/null &\n"'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
alias ls='ls --color=auto'
alias la='ls -a'
alias r='ranger-cd'
alias octave='octave-cli'
alias setxkbmapde='setxkbmap de -option "caps:escape"'
alias whatismyip='ip addr show'
alias up='sudo pacman -Syu'
alias aurup='pacaur -Syu --noconfirm'
k(){
    killall -9 $1
}
f(){ # Dateinamen suchen in diesem DIR
    find . -name $1
}
function h() {
    $1 --help | less
}
g(){ #grep 
    grep -R $1 --color=always
}
grepl(){ #grep langsam
    grep -R $1 | less -R
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
remove(){
    sudo pacman -Rs $1
}
addkey(){
    gpg --recv-key $1
}
youtube-dlmp3(){
    youtube-dl --extract-audio --audio-format mp3 $1
}
#youtube-dl(){
#    youtube-dl --external-downloader aria2c --external-downloader-args '-c -x 5 -k 2M' $1
#}
bluetoothStart(){
    sudo systemctl start bluetooth.service
    blueman-applet &
    xset m 3/2 0
}
extract(){      # Entpackt alles
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
source /usr/share/doc/ranger/examples/bash_automatic_cd.sh

function vga() {
    xrandr --output DP1 --auto --left-of  eDP1 --auto
    xrandr --output DP1 --auto --right-of  eDP1 --transform 0.836601,0.000000,0.000000,-0.091867,1.000000,0.000000,-0.000120,-0.000000,1.000000
}

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
