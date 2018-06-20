export LANG=ja_JP.UTF-8

case $OSTYPE in
  darwin*)
    export HOMEBREW_CASK_OPTS='--appdir=/Applications'
    ;;
  linux*)
esac

export EDITOR=/usr/local/bin/vim

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/openssl/bin:$PATH

if which nodebrew &> /dev/null; then
  if [ ! -e $HOME/.nodebrew ]; then
    nodebrew setup
  fi
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi
if which rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi
if [ -e $HOME/.pyenv ]; then
  export PATH=$HOME/.pyenv/bin:$PATH
  eval "$(pyenv init - zsh)"
fi


########################
# autoload
########################
autoload -Uz colors
autoload -Uz vcs_info
autoload -U compinit
compinit -u


#########################
# エイリアス
#########################
alias -g G='| grep'
alias -g L='| less'
alias -g X='| xargs'
alias -g J='| jq .'
alias -g P='| peco'

alias ls="ls -GF"
alias gls="gls --color"
alias la='ls -la'
alias grep='grep --color --exclude-dir={node_modules,vendor,.git} -in'

function find_cd() {
  cd "$(find . -type d P)"
}
alias fc='find_cd'

alias sp='spring'
alias bsp='bin/spring'
alias be='bundle exec'
alias bi='bundle install --path vendor/bundle --jobs=4'
alias rake='rake'
alias rr='rake routes'
alias rdc='rake db:create'
alias rdm='rake db:migrate'
alias rdmt='rake db:migrate RAILS_ENV=test'
alias rdd='rake db:drop'
alias rds='rake db:seed'
alias rdr='rake db:reset'
alias rdmr='rake db:migrate:reset'
alias rails='rails'
alias rs='rails s'
alias rc='rails c'
alias rspec='rspec'

# カレントブランチ名を表示
function git_current_branch_name() { git rev-parse --abbrev-ref HEAD }
alias -g B='"$(git_current_branch_name)"'

alias g='git'
alias gi='git init'
alias gd='git diff'
alias gst='git status -b'
alias gb='git branch'
alias gbd='git branch -d'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcm='git checkout master'
alias glg='git log --pretty=format:"%C(yellow)%H%Creset %C(green reverse) %an %Creset [%cd] %C(blue)%ar%Creset %s %C(red)%d%Creset" --date=format:"%Y/%m/%d %H:%M:%S" --graph'
alias gsta='git stash'
alias gstal='git stash list'
alias rgsta='git stash apply'
alias gr='git reset HEAD'
alias grhch='git reset --hard HEAD^'
alias grhih='git reset --hard HEAD'
alias grsch='git reset --soft HEAD^'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcmsg='git commit -m'
alias gcam='git commit --amend'
alias gfm='git pull origin B'
alias gfmr='git pull --rebase origin B'
alias gp='git push origin B'
alias gpom='git push origin master'
alias gphm='git push heroku master'
alias glom='git pull origin master'
alias gf='git fetch --prune'

alias t='tmux'
alias tl='tmux ls'
alias ta='tmux a -t'
alias tre='tmux rename -t'
alias tk='tmux kill-session -t'

alias dk='docker'
alias dkc='docker-compose'

alias phis='percol_insert_history'

alias deleteallswaps='find . -name ".*.sw*"|xargs rm'


##################
# ^Rをpecoでhistory検索
##################
HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt share_history
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

##################
# autojump
##################
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

#################
# direnv
#################
if which direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi


#################
# pure
#################
autoload -U promptinit; promptinit
prompt pure
