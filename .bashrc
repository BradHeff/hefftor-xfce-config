#
# ~/.bashrc
#

. /home/pheonix/.git-prompt.bash

precmd() {
    echo `git_prompt_precmd`
}
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups
# export QT_QPA_PLATFORMTHEME=qt5ct
# export ANDROID_HOME=/home/pheonix/Android/Sdk

SELECT(){
  if [ "$?" -eq 0 ]
    then
    echo ""
  else 
    echo "[X] "
fi
}

COLOR_BLACK="\[$(tput setaf 0)\]"
COLOR_RED="\[$(tput setaf 1)\]"
COLOR_GREEN="\[$(tput setaf 2)\]"
COLOR_YELLOW="\[$(tput setaf 3)\]"
COLOR_BLUE="\[$(tput setaf 4)\]"
COLOR_PURPLE="\[$(tput setaf 5)\]"
COLOR_CYAN="\[$(tput setaf 6)\]"
COLOR_WHITE="\[$(tput setaf 7)\]"
COLOR_BLUE="\[$(tput setaf 8)\]"
COLOR_RESET="\[$(tput sgr0)\]"
COLOR_BOLD="\[$(tput bold)\]"


#PS1="${COLOR_RED}\$(SELECT)${COLOR_RESET}\\h ${COLOR_YELLOW}${COLOR_BOLD}::${COLOR_RESET} ${COLOR_GREEN}\\w ${COLOR_PURPLE}\$(precmd) ${COLOR_B}${COLOR_BOLD}>>${COLOR_RESET} "
PS1="${COLOR_RED}\$(SELECT)${COLOR_GREEN}\\w ${COLOR_PURPLE}\$(precmd)${COLOR_RESET}
${COLOR_GREEN}${COLOR_BOLD}::${COLOR_RESET} "

mkcd() {
        if [ $# != 1 ]; then
                echo "Usage: mkcd <dir>"
        else
                mkdir -p $1 && cd $1
        fi
}
cdls() { 
  cd "$@" && l; 
}

rd(){
    pwd > "$HOME/.lastdir_$1"
}

crd(){
        lastdir="$(cat "$HOME/.lastdir_$1")">/dev/null 2>&1
        if [ -d "$lastdir" ]; then
                cd "$lastdir"
        else
                echo "no existing directory stored in buffer $1">&2
        fi
}
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
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

youtube() {
    if [ $# -eq 1 ]
    then  
        youtube-dl -q "$1"
    elif [ $# -eq 2 ]
    then
        if [ "$1" == "mp4" ]
        then
          youtube-dl -q --recode-video mp4 "$2"
        else
          youtube-dl -q -x --audio-format mp3 "$2" 
        fi
    else
        echo "No arguments supplied"
    fi
}

deps() {
  if [[ "$1" -eq "p" ]]
  then
    sudo pacman -Si "$2" |sed -n '/Depends\ On/,/:/p'|sed '$d'|cut -d: -f2
  elif [[ "$1" -eq "y" ]]
  then
    yay -Si "$2" |sed -n '/Depends\ On/,/:/p'|sed '$d'|cut -d: -f2
  fi  
}
gitclone() {
  if (( $# == 2 )); then
    if [[ "$1" -eq "gh" ]]
    then
      git clone https://BradHeff:PASS@github.com/BradHeff/"$2".git
    elif [[ "$1" -eq "gl" ]]
    then
      git clone https://BradHeff83:PASS@gitlab.com/BradHeff83/"$2".git
    fi
  elif (( $# == 1 )); then
  fpath=$(echo "$1" | awk '{print $NF}' FS=/ | awk '{print $1}' FS=.)
  git clone "$1" && cd "$fpath"
  fi
}
gitremote() {
  if [[ "$1" -eq "gh" ]]
  then
    git remote add origin https://BradHeff:PASS@github.com/BradHeff/"$2".git
  elif [[ "$1" -eq "gl" ]]
  then
    git remote add origin https://BradHeff83:PASS@gitlab.com/BradHeff83/"$2".git
  fi
}
dd() {
  if [ $# -eq 2 ]; then
    sudo dd status=progress if="$1" of="$2"
  else
    echo "Must take only 2 arguments"
    echo "EXAMPLE:"
    echo "dd /path/iso /dev/sd?"
  fi
}
if [ -d "$HOME/.bin" ];
then
  PATH="$HOME/.bin:$HOME/.local/bin:$PATH"
fi

. "${HOME}/.cache/wal/colors.sh"
  
alias dmen='dmenu_run -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn 'NotoMonoRegular:bold:pixelsize=14''
    
#list
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -la'
alias l='ls'          
alias l.="ls -A | egrep '^\.'"      

alias vtop='vtop -t wizard'

#fix obvious typo's
alias cd..="cd .."
alias pdw="pwd"

## Colorize the grep command output for ease of use (good for log files)##
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

#readable output
alias df='df -h'

#pacman unlock
alias unlock="sudo rm /var/lib/pacman/db.lck"

#free
alias free="free -mt"

#continue download
alias wget="wget -c"

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#merge new settings
alias merge="xrdb -merge ~/.Xresources"

# Aliases for software managment
# pacman or pm
#alias pacman="sudo pacman --color auto"
alias update="sudo pacman -Syyu"
alias prm="sudo pacman -Rs --color auto"
alias pins="sudo pacman -S --color auto"
alias psr="sudo pacman -Ss --color auto"
alias pdep="deps p"
alias pclean="sudo pacman -Rns \$(pacman -Qtdq)"

# yay as aur helper - updates everything
alias pksyua="yay -Syu --noconfirm"
alias upall="yay -Syu --noconfirm"
alias yins="yay -S --color auto"
alias yrm="yay -R --color auto"
alias ysr="yay -Ss --color auto"
alias ydep="deps y"

#ps
alias ps="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#improve png
alias fixpng="find . -type f -name "*.png" -exec convert {} -strip {} \;"

#add new fonts
alias fc="sudo fc-cache -fv"

#copy/paste all content of /etc/skel over to home folder - Beware
alias skel='cp -rf /etc/skel/* ~'
#backup contents of /etc/skel to hidden backup folder in home/user
alias bupskel='cp -Rf /etc/skel ~/.skel-backup-$(date +%Y.%m.%d-%H.%M.%S)'


#get fastest mirrors in your neighborhood 
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"


#copy bashrc-latest over on bashrc - cb= copy bashrc
alias cb="cp ~/.bashrc-latest ~/.bashrc && source ~/.bashrc && sudo cp /etc/skel/.bashrc-latest /etc/skel/.bashrc"

#quickly kill conkies
alias kc='killall conky'

#mounting the folder Public for exchange between host and guest on virtualbox
alias vbm="sudo mount -t vboxsf -o rw,uid=1000,gid=1000 Public /home/$USER/Public"

alias gpl="git pull"
alias gcl="git clone"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push -u origin master"
alias gr="git rm"
alias grd="git rm -r"
alias gra="gitremote"
alias gcln="gitclone"

alias serv="ssh brad@192.168.1.2"

#hardware info --short
alias hw="hwinfo --short"

alias sZ="source ~/.bashrc"
alias eZ="vim ~/.bashrc"

alias ~="cd ~ && source ~/.bashrc"

alias yt='youtube'
alias ytm='youtube mp3'
alias ytr='youtube mp4'

alias rmd='rm -r'
alias srm='sudo rm'
alias srmd='sudo rm -r'
alias cpd='cp -R'
alias scp='sudo cp'
alias scpd='sudo cp -R'

alias slin='sudo ln -s'
alias lin='ln -s'

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -100"

#Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#nano
alias nlightdm="sudo vim /etc/lightdm/lightdm.conf"
alias npacman="sudo vim /etc/pacman.conf"
alias ngrub="sudo vim /etc/default/grub"
alias nmkinitcpio="sudo vim /etc/mkinitcpio.conf"
alias noblogout="sudo vim /etc/oblogout.conf"

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

# (cat ~/.cache/wal/sequences &)
# export _JAVA_AWT_WM_NONREPARENTING=1
clear && hfetch
EDITOR=vim

