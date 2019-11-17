USER=naya
if [ "$(uname)" == 'Darwin' ]; then
  ROOT=Users
else
  ROOT=home
fi
ln -sf /${ROOT}/${USER}/repos/dotfiles/git/.gitconfig /${ROOT}/${USER}/.gitconfig
ln -sf /${ROOT}/${USER}/repos/dotfiles/tmux/.tmux.conf /${ROOT}/${USER}/.tmux.conf
ln -sf /${ROOT}/${USER}/repos/dotfiles/vim/.vimrc /${ROOT}/${USER}/.vimrc
ln -sf /${ROOT}/${USER}/repos/dotfiles/zsh/.zshrc /${ROOT}/${USER}/.zshrc

ln -sf /${ROOT}/${USER}/repos/dotfiles/vscode/settings.json /${ROOT}/${USER}/Library/Application\ Support/Code/User/settings.json
ln -sf /${ROOT}/${USER}/repos/dotfiles/vscode/keybindings.json /${ROOT}/${USER}/Library/Application\ Support/Code/User/keybindings.json
