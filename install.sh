#!/bin/bash

# 実行場所のディレクトリを取得
THIS_DIR=$(cd $(dirname $0); pwd)

# ホームディレクトリにdotfileのシンボリックリンクを貼る
echo "start setup..."
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitmodules" ] && continue

    ln -snfv ~/dotfiles/"$f" ~
done


# .zshrc.local は Google Drive で管理するようにした
# 作業PC交換時にはGoogle Driveの同期ツールを導入してから本スクリプトを実行すること
SOURCE="$HOME/local_info/dotfiles/.zshrc.local"
TARGET="$HOME/.zshrc.local"
BACKUP="${TARGET}.backup"
if [[ -e "$SOURCE" ]]; then
  if [[ -e "$TARGET" || -L "$TARGET" ]]; then
    mv "$TARGET" "$BACKUP"
    echo "既存ファイルを $BACKUP に退避しました"
  fi

  # シンボリックリンクを作成（-s）、既にあった場合も置き換え（-f）
  ln -sf "$SOURCE" "$TARGET"
  echo "$TARGET → $SOURCE へリンクしました"
else
  echo "$SOURCE が存在しないため、何もしませんでした" >&2
fi
