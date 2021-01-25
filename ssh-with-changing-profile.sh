#!/bin/bash
echo $@
pane_id=$(tmux display -p '#{pane_id}')
if [[ "$@" == "gateway1.dena.local" ]]; then
  echo -ne "\033]1337;SetProfile=prod\a"     # tmux 未起動時は iterm のプロファイルごと変更
  tmux select-pane -P 'bg=colour52,fg=white' # tmux 起動時は tmux の背景色を変更
else
  echo -ne "\033]1337;SetProfile=develop\a"   # tmux 未起動時は iterm のプロファイルごと変更
  tmux select-pane -P 'bg=colour238,fg=white' # tmux 起動時は tmux の背景色を変更
fi
# iterm, tmux ともに ssh から戻ったら設定をデフォルトにする
trap 'echo -ne "\033]1337;SetProfile=Default\a" && tmux select-pane -t $pane_id -P "default"' ERR EXIT
# tmux select-pane -t $pane_id -P 'default'
/usr/bin/ssh "$@"
