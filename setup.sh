USER=hiroto.naya
if [ "$(uname)" == 'Darwin' ]; then
  ROOT=Users
else
  ROOT=home
fi
ln -sf /${ROOT}/${USER}/repos/dotfiles/git/.gitconfig /${ROOT}/${USER}/.gitconfig
ln -sf /${ROOT}/${USER}/repos/dotfiles/tmux/.tmux.conf /${ROOT}/${USER}/.tmux.conf
ln -sf /${ROOT}/${USER}/repos/dotfiles/nvim/dein.toml /${ROOT}/${USER}/.config/nvim/dein.tom
ln -sf /${ROOT}/${USER}/repos/dotfiles/nvim/init.vim /${ROOT}/${USER}/.config/nvim/init.vim
ln -sf /${ROOT}/${USER}/repos/dotfiles/nvim/init /${ROOT}/${USER}/.config/nvim/init
ln -sf /${ROOT}/${USER}/repos/dotfiles/nvim/ftplugin /${ROOT}/${USER}/.config/nvim/ftplugin
ln -sf /${ROOT}/${USER}/repos/dotfiles/zsh/.zshrc /${ROOT}/${USER}/.zshrc
ln -sf /${ROOT}/${USER}/repos/dotfiles/zsh/.zshlib /${ROOT}/${USER}/.zshlib
ln -sf /${ROOT}/${USER}/repos/dotfiles/vscode/settings.json /${ROOT}/${USER}/Library/Application\ Support/Code/User/settings.json
ln -sf /${ROOT}/${USER}/repos/dotfiles/vscode/keybindings.json /${ROOT}/${USER}/Library/Application\ Support/Code/User/keybindings.json
