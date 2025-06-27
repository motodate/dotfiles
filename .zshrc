## 全OS
### 基本設定
setopt print_eight_bit # 日本語ファイル名を表示可能にする
setopt correct # コマンドのスペルを訂正
setopt no_beep # ビープ音を鳴らさない

### 履歴設定
HISTFILE=~/.zsh_history #履歴ファイルの設定
HISTSIZE=1000000 # メモリに保存される履歴の件数。(保存数だけ履歴を検索できる)
SAVEHIST=1000000 # ファイルに何件保存するか
setopt extended_history # 実行時間とかも保存する
setopt share_history # 別のターミナルでも履歴を参照できるようにする
setopt hist_ignore_all_dups # 過去に同じ履歴が存在する場合、古い履歴を削除し重複しない
setopt hist_ignore_space # コマンド先頭スペースの場合保存しない
setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_reduce_blanks #余分なスペースを削除してヒストリに記録する
setopt hist_save_no_dups # histryコマンドは残さない
setopt hist_expire_dups_first # 古い履歴を削除する必要がある場合、まず重複しているものから削除
setopt hist_expand # 補完時にヒストリを自動的に展開する
setopt inc_append_history # 履歴をインクリメンタルに追加
export LANG=ja_JP.UTF-8 # 文字コード

### Alias
if which colordiff > /dev/null 2>&1; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi
alias d='diff'
alias cp='cp -i'
# for code grep
alias cg='find . -path ./.git -prune -o -path ./log -prune -o -type f -print0 | xargs -0 grep -n -E $1'
alias dw='cd ~/work/'
alias dd='cd ~/Downloads/'
# for file grep
alias fg="find . -type f | xargs grep $1"
alias fgrep='/bin/fgrep --color=auto --exclude='\''*.svn*'\'' --exclude=tags'
alias g='git'
alias grep='grep -E --color=auto --exclude='\''*.svn*'\'' --exclude=tags'
alias ls='ls -aF'
alias ll='ls -lh'
alias l='less'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias now='date +%Y%m%d_%H%M%S'
alias now_iso8601='date --iso-8601=seconds'
alias rgrep='grep -nIr'
alias rm='rm -i'
alias vi='vim'
alias zshrc='vi ~/.zshrc'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ssh="TERM=xterm /usr/bin/ssh"

### その他
# tmux
if which tmux > /dev/null 2>&1; then
    alias tmux='tmux -2'
    alias tmls='tmux ls'
    alias tmatc='tmux attach -t'
    alias tmcs='tmux choose-session'
fi

# etckeeper
if which etckeeper > /dev/null 2>&1; then
    alias sekc='sudo -E etckeeper commit'
fi

# cdしてからlsするやつ
chpwd() {
    ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
}
ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}



## 環境固有設定
### 環境変数 (ここによく使うディレクトリのパスととか書く)

### load local functions
### .zshrc.local は Google Drive で管理するようにした
[ -r ~/.zshrc.local ] && source ~/.zshrc.local
