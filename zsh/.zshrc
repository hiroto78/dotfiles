export NODE_PATH=/usr/local/lib/node_modules
#export PATH=/usr/local/bin:$PATH
NPM_PATH=/usr/local/bin/npm/bin
#export PATH=/usr/local/bin:~/bin:$NPM_PATH:$NODE_PATH:$PATH
#export RBENV_ROOT=/usr/local/var/rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
export EDITOR="vim"
export CC=/usr/bin/gcc
# export LS_COLORS='di=36'
export LSCOLORS=ExFxCxDxBxegedabagacad

# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# 1行表示
case ${OSTYPE} in
  darwin*)
    PROMPT="%{${fg[green]}%}[%n@linux]%{${reset_color}%} %~ %# "
    # PROMPT="%K{24}%~ : $%K"
    ;;
  linux*)
    PROMPT="%{${fg[green]}%}[%n@linux]%{${reset_color}%} %~ %# "
    ;;
esac

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
	LANG=en_US.UTF-8 vcs_info
	RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias aa='cd /Users/hiroto.naya/repos/ride-server'
alias la='ls -a'
alias ll='ls -l'
alias vag='vagrant'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
# Mac
alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
# Linux
alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
# Cygwin
alias -g C='| putclip'
fi

########################################
# OS 別の設定
case ${OSTYPE} in
darwin*)
#Mac用の設定
export CLICOLOR=1
alias ls='ls -G -F'
;;
linux*)
#Linux用の設定
alias ls='ls -F --color=auto'
;;
esac

# vim:set ft=zsh:
#############################################
function agvim() {
    if [ "$1" = "" ]
    then
        echo 'no arguments';
        return;
    fi
    vim -p `ag -lr $1 $2 | perl -pe 's/\n/ /g'`;
}

alias sl='ls'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm

# if [[ $TERM != "screen" ]] exec screen -D -RR
###########################################
# nvm
###########################################
[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
nvm use default
npm_dir=${NVM_PATH}_modules
export NODE_PATH=$npm_dir

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

function peco-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh
}
zle -N peco-select-history
bindkey '^R' peco-select-history

# android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# pyenv virtualenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# pip install flake8
source /Users/hiroto.naya/repos/ride-Android/app/keystore/release.rc
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias ssh='~/ssh-with-changing-profile.sh'

# go lang
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

alias vim='nvim  $(fzf --height 40% --reverse)'
alias vi='nvim'

function history-fzf() {
  local tac

  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval $tac | fzf --layout=reverse --query "$LBUFFER")
  CURSOR=$#BUFFER

  zle reset-prompt
}

zle -N history-fzf
bindkey '^r' history-fzf
