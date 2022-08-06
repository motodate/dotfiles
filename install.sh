#!/bin/bash

# 実行場所のディレクトリを取得
THIS_DIR=$(cd $(dirname $0); pwd)

# ホームディレクトリにdotfileのシンボリックリンクを貼る
echo "start setup..."
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = ".zshrc.local" ] && continue

    ln -snfv ~/dotfiles/"$f" ~
done
