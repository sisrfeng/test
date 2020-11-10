# Antigen: https://github.com/zsh-users/antigen
ANTIGEN="$HOME/.local/bin/antigen.zsh"

#if [ -f ~/clwf/.alias ]; then
    #. ~/clwf/.alias
#fi

# Install antigen.zsh if not exist
#if [ ! -f "$ANTIGEN" ]; then
	#echo "Installing antigen ..."
	#[ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
	#[ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
	## [ ! -f "$HOME/.z" ] && touch "$HOME/.z"
	#URL="http://git.io/antigen"
	#TMPFILE="/tmp/antigen.zsh"
	#if [ -x "$(which curl)" ]; then
		#curl -L "$URL" -o "$TMPFILE" 
	#elif [ -x "$(which wget)" ]; then
		#wget "$URL" -O "$TMPFILE" 
	#else
		#echo "ERROR: please install curl or wget before installation !!"
		#exit
	#fi
	#if [ ! $? -eq 0 ]; then
		#echo ""
		#echo "ERROR: downloading antigen.zsh ($URL) failed !!"
		#exit
	#fi;
	#echo "move $TMPFILE to $ANTIGEN"
	#mv "$TMPFILE" "$ANTIGEN"
#fi


## WSL (aka Bash for Windows) doesn't work well with BG_NICE
#[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE

# Load local bash/zsh compatible settings
_INIT_SH_NOFUN=1
_INIT_SH_NOLOG=1
[ -f "$HOME/.local/etc/init.sh" ] && source "$HOME/.local/etc/init.sh"

# exit for non-interactive shell
[[ $- != *i* ]] && return


# Initialize antigen
source "$ANTIGEN"

# Setup dir stack
DIRSTACKSIZE=10
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups cdablevars
alias d='dirs -v | head -10'

# Disable correction
unsetopt correct_all
unsetopt correct
DISABLE_CORRECTION="true" 

# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"

ZSH_AUTOSUGGEST_USE_ASYNC=1

# Declare modules
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:git:alias' skip 'yes'
# zstyle ':prezto:module:prompt' theme 'sorin'
zstyle ':prezto:module:prompt' pwd-length 'long'
zstyle ':prezto:module:terminal' auto-title 'no'
zstyle ':prezto:module:autosuggestions' color 'yes'
zstyle ':prezto:module:python' autovenv 'yes'
zstyle ':prezto:load' pmodule \
	'environment' \
	'editor' \
	'history' \
	'utility' \
	'completion' \
	'autosuggestions' \
	'history-substring-search' \
#	'autosuggestions' \
	#'prompt' \

antigen use prezto


# default bundles
antigen bundle rupa/z z.sh
#antigen bundle Vifon/deer
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle willghatch/zsh-cdr
antigen bundle zsh-users/zaw

# check login shell
if [[ -o login ]]; then
	[ -f "$HOME/.local/etc/login.sh" ] && source "$HOME/.local/etc/login.sh"
	[ -f "$HOME/.local/etc/login.zsh" ] && source "$HOME/.local/etc/login.zsh"
fi

# syntax color definition
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none

# load local config
[ -f "$HOME/.local/etc/config.zsh" ] && source "$HOME/.local/etc/config.zsh" 
[ -f "$HOME/.local/etc/local.zsh" ] && source "$HOME/.local/etc/local.zsh"

antigen apply

# options
unsetopt share_history
#setopt prompt_subst

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY # Don't execute immediately upon history expansion.

# setup for deer
#autoload -U deer
#zle -N deer

# default keymap
bindkey -s '\ee' 'vim\n'
bindkey '\eh' backward-char
bindkey '\el' forward-char
bindkey '\ej' down-line-or-history
bindkey '\ek' up-line-or-history
bindkey '\eH' backward-word
bindkey '\eL' forward-word
bindkey '\eJ' beginning-of-line
bindkey '\eK' end-of-line

bindkey -s '\eo' 'cd ..\n'
bindkey -s '\e;' 'll\n'

bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word
bindkey '\e[1;3A' beginning-of-line
bindkey '\e[1;3B' end-of-line

#bindkey '\ev' deer
#bindkey -s '\eu' 'ranger_cd\n'
#bindkey -s '\eOS' 'vim '


# source function.sh if it exists
[ -f "$HOME/.local/etc/function.sh" ] && . "$HOME/.local/etc/function.sh"


# completion detail
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*.pdf|*.exe|*.dll'
zstyle ':completion:*:*sh:*:' tag-order files


bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

export ALL_PROXY=socks5://219.223.187.35:4080

setopt autocd
setopt globdots
setopt histignoredups
setopt histignorespace
setopt ignorebraces
setopt interactivecomments
export UPDATE_ZSH_DAYS=1

alias r='tldr'
# Peco history selection
function peco-history-selection() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(history -1000 | eval $tac | cut -c 8- | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection
export PATH=$PATH:$HOME/usr/local/bin:/root/.cargo/bin
#export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
#export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'


alias s='vi ~/.zshrc'
alias sr='zsh'
alias tm='tmux a -d'
alias ts='tmux new -s jiqun'
alias t='mv -ft /opt/data/private/trash'
alias v='vim'
alias vi='vim'
alias vr='vi ~/.SpaceVim/vimrc'

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias -s py=vi
alias -s html=cat
##加了这行导致./build_ops.sh等执行不了
#alias -s sh=vi
alias -s py=vi
alias -s toml=vi
alias -s md=cat
alias m=mv
alias c=cp


alias rm='rm -Ir --preserve-root'
alias cp='cp -ir'
alias ta='tail -fn 50 nohup.out'
alias ut='ntat'
alias uz='unzip'
alias sc='source'
alias vi='vim'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

alias db='pudb3'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cman='man -M /usr/local/zhman/share/man/zh_CN'
alias dkg='docker exec -it 1ee575b28c9f /bin/bash'
alias egrep='egrep --color=auto'
alias fd='f(){ find "$1" -path "*$2*"; }; f'
alias ht='houtai(){ nohup '$2' >$1 2>&1 &; }; houtai'
alias fdroot='f(){ find / -path "*$1*"; }; f'

alias pip='wfpip(){ nopro && pip $* && pro; }; wfpip'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias hl='f(){ du -sh $1* | sort -hr; }; f'
alias k9='kill -9'
#alias l='ls -CF1GhFBtr --color=alway'
alias l='ls -1htr --color=alway'
alias l.='ls -d .* --color=auto'
alias la='ls -ACF1GhFBtr --color=alway'
alias ll='ls -gGhtrFB --color=auto'
alias lr='ls -gGhtFB --color=auto'
alias ls='ls -hrt --color=auto'
alias man='man -M /usr/local/zhman/share/man/zh_CN'
alias md='mkdir -p'
alias mcd='mcd(){ mkdir $1 && cd $1; }; mcd'
alias mt='mv -t ~/Trash'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'
alias wfpid='ps -aux |grep -v grep|grep'
alias myip='curl cip.cc'
alias nau='nohup nautilus &'
alias nopro='export ALL_PROXY= '
alias ntar='tar -zxvf '
alias pro='export ALL_PROXY=socks5://219.223.187.35:1080'
alias py='/usr/bin/python3.7'
alias rm='rm -Ir --preserve-root'
alias sc='source'
alias srm='rm -Irf --preserve-root'
alias ta='tail -fn 50 nohup.out'
alias ut='ntat'
alias uz='unzip'
alias vi='vim'
alias wg='wget -c'
alias wgname='wget -c -O "change_name"'
alias ns='nvidia-smi'
alias cen='docker exec -it cen /bin/zsh'
alias his='history | grep'
alias h='history | grep'
alias mcd='mcd(){ mkdir $1 && cd $1; }; mcd'
#alias git='pro &&  git'
alias top='htop'
alias zs='~/Applications/zsh/bin/zsh'
alias top2='htop'

#autoload -U wf_
#wf_ -Uz chpwd (){ ls -1GhtrFB; }
#cl() { cd "$@" && ls -1GhtrFB; }
function list_all() {
    emulate -L zsh
    ls -1GhtrFB --color=alway
}
function wf_print() {
    emulate -L zsh
    echo "----------------split--line---------------------"
}
chpwd_functions=(${chpwd_functions[@]} "list_all" "wf_print")


# alias gcid="git log | head -1 | awk '{print substr(\$2,1,7)}' | pbcopy"
# # string consists of one or more of the following numeric codes:
#  Attribute codes:
# # 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# # Text color codes:
# # 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# # Background color codes:
# # 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
# #NORMAL 00 # no color code at all
# #FILE 00 # regular file: use no color at all
# RESET 0 # reset to "normal" color
#  MULTIHARDLINK 00 # regular file with more than one link
#  FIFO 40;33 # pipe
#  SOCK 01;35 # socket
#  DOOR 01;35 # door
#  BLK 40;33;01 # block device driver
#  CHR 40;33;01 # character device driver
#  ORPHAN 40;31;01 # symlink to nonexistent file, or non-stat'able file ...
#  MISSING 00 # ... and the files they point to
#  SETUID 37;41 # file that is setuid (u+s)
#  SETGID 30;43 # file that is setgid (g+s)
#  CAPABILITY 30;41 # file with capability
#  STICKY_OTHER_WRITABLE 30;42 # dir that is sticky and other-writable (+t,o+w)
#  OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
#  STICKY 37;44 # dir with the sticky bit set (+t) and not other-writable
#  # This is for files with execute permission:
#  EXEC 01;32

LS_COLORS=''
LS_COLORS=$LS_COLORS:'no=36'           # Normal text       = Default foreground
LS_COLORS=$LS_COLORS:'fi=35'           # Regular file      = Default foreground
LS_COLORS=$LS_COLORS:'di=34;4'       # Directory         = Bold, Blue

#stiky
LS_COLORS=$LS_COLORS:'tw=34;4'
LS_COLORS=$LS_COLORS:'ow=34;4'


LS_COLORS=$LS_COLORS:'ln=34;4'       # Symbolic link     = Bold, Cyan
LS_COLORS=$LS_COLORS:'or=01;05;31'    # broken  link     = Bold, Red, Flashing
LS_COLORS=$LS_COLORS:'pi=34;4'          # Named pipe        = Yellow
LS_COLORS=$LS_COLORS:'so=34;4'       # Socket            = Bold, Magenta
LS_COLORS=$LS_COLORS:'do=34;4'       # DO                = Bold, Magenta
LS_COLORS=$LS_COLORS:'bd=34;4'       # Block device      = Bold, Grey
LS_COLORS=$LS_COLORS:'cd=34;4'       # Character device  = Bold, Grey
LS_COLORS=$LS_COLORS:'ex=35'          # Executable file   = Light, Blue
LS_COLORS=$LS_COLORS:'*.sh=47;31'     # Shell-Scripts     = Foreground White, Background Red
LS_COLORS=$LS_COLORS:'*.vim=34'       # Vim-"Scripts"     = Purple
LS_COLORS=$LS_COLORS:'*.swp=00;44;37' # Swapfiles (Vim)   = Foreground Blue, Background White
LS_COLORS=$LS_COLORS:'*,v=5;34;93'    # Versioncontrols   = Bold, Yellow
LS_COLORS=$LS_COLORS:'*.c=1;33'       # Sources           = Bold, Yellow
LS_COLORS=$LS_COLORS:'*.C=1;33'       # Sources           = Bold, Yellow
LS_COLORS=$LS_COLORS:'*.h=1;33'       # Sources           = Bold, Yellow
LS_COLORS=$LS_COLORS:'*.jpg=1;32'     # Images            = Bold, Green
LS_COLORS=$LS_COLORS:'*.jpeg=1;32'    # Images            = Bold, Green
LS_COLORS=$LS_COLORS:'*.JPG=1;32'     # Images            = Bold, Green
LS_COLORS=$LS_COLORS:'*.gif=1;32'     # Images            = Bold, Green
LS_COLORS=$LS_COLORS:'*.png=1;32'     # Images            = Bold, Green
LS_COLORS=$LS_COLORS:'*.jpeg=1;32'    # Images            = Bold, Green
LS_COLORS=$LS_COLORS:'*.tar=31'       # Archive           = Red
LS_COLORS=$LS_COLORS:'*.tgz=1;31'       # Archive           = Red
LS_COLORS=$LS_COLORS:'*.gz=1;31'        # Archive           = Red
LS_COLORS=$LS_COLORS:'*.xz=1;31'        # Archive           = Red
LS_COLORS=$LS_COLORS:'*.zip=31'       # Archive           = Red
LS_COLORS=$LS_COLORS:'*.bz2=1;31'       # Archive           = Red
LS_COLORS=$LS_COLORS:'*.jpeg=1;32'    # Images            = Bold, Green
LS_COLORS=$LS_COLORS:'*.tar=31'       # Archive           = Red
LS_COLORS=$LS_COLORS:'*.tgz=1;31'       # Archive           = Red
LS_COLORS=$LS_COLORS:'*.gz=1;31'        # Archive           = Red
LS_COLORS=$LS_COLORS:'*.xz=1;31'        # Archive           = Red
LS_COLORS=$LS_COLORS:'*.zip=31'       # Archive           = Red
LS_COLORS=$LS_COLORS:'*.bz2=1;31'       # Archive           = Red
LS_COLORS=$LS_COLORS:'*.html=36'      # HTML              = Cyan
LS_COLORS=$LS_COLORS:'*.htm=1;34'     # HTML              = Bold, Blue
LS_COLORS=$LS_COLORS:'*.txt=0'        # Plain/Text        = Default Foreground
LS_COLORS=$LS_COLORS:'*.n=43;37'        # Plain/Text        = Default Foreground
export LS_COLORS

alias vd='vim -d'


# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
export LC_ALL=zh_CN.UTF-8
alias vt='vim ~/.tmux.conf'

alias x='extract'

##oh-my-zsh:
#export ZSH=$HOME/.oh-my-zsh
##plugins=(git extract)
#ZSH_THEME="robbyrussell"
##source $ZSH/oh-my-zsh.sh
##oh-my-zsh:
alias pi='pip install'
alias pip3='pip'
alias g='gpustat -p -u -c --debug --no-header'
alias ai='aptitude install'
alias wget='wget -c'

##cd /

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/root/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/root/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/root/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/root/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
alias help=run-help
alias python3='python'


#autoload -U promptinit
#promptinit
autoload -U colors && colors
#export PS1="%S %F%d%f %s num_of_job:%j  
#export PS1="%S %F%d%f %s  "$'\n'" >"
export PS1="@%{$fg[cyan]$bg[white]%}%~ "$'\n'">%{$reset_color%}"
#Red, Blue, Green, Cyan, Yellow, Magenta, Black & White
#conda activate caffe
#conda deactivate 
#
alias h='history | grep '
