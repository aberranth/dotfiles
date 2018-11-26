#!/bin/sh
sudo dnf install -y vim tmux emacs wmctrl xdotool xclip exa ripgrep direnv mc yakuake
sudo dnf group install "Development Tools"

# install poweline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# install Yarn and Node.js
sudo dnf module install nodejs:8
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo dnf install yarn

# rpm-fusion packages
sudo dnf install telegram-desktop

cd ~/dotfiles
if [[ ! $(pwd) =~ "dotfiles" ]]; then exit; fi;

ln -sf dotfiles/vimrc ~/.vimrc

ln -sf dotfiles/_spacemacs ~/.spacemacs
ln -sf dotfiles/spacemacs  ~/spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
git clone https://github.com/artempyanykh/evil-russian.git ~/.emacs.d/layers/private/evil-russian

ln -sf dotfiles/vimperatorrc ~/.vimperatorrc

ln -sf dotfiles/bash_profile ~/.bash_profile
ln -sf dotfiles/bash_aliases ~/.bash_aliases
ln -sf dotfiles/bashrc ~/.bashrc
ln -sf dotfiles/inputrc ~/.inputrc

ln -sf dotfiles/tmux.conf ~/.tmux.conf
ln -sf dotfiles/ctags ~/.ctags

ln -sf dotfiles/gitconfig ~/.gitconfig
ln -sf dotfiles/global-gitignore ~/.gitignore

ln -sf dotfiles/bin  ~/.bin

ln -sf dotfiles/pryrc ~/.pryrc

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim -c "VundleInstall"

git submodule update --init

ln -sf ~/dotfiles/colorschemes/gruvbox-contrib/konsole/Gruvbox_dark.colorscheme ~/.local/share/konsole/Gruvbox_dark.colorscheme
ln -sf ~/dotfiles/colorschemes/gruvbox-contrib/xresources/gruvbox-dark.xresources ~/.Xresources

# git clone https://github.com/soimort/translate-shell
# cd translate-shell/
# make PREFIX=~/.local install


# install winescript to be able to run Windows .bat files
# curl http://dcjtech.info/wp-content/uploads/2015/02/winescript-v2015.02.08.zip --output winescript.zip
# sudo unzip winescript.zip -d /usr/local/bin/
# chmod +x /usr/local/bin/winescript
# rm winescript.zip

cd
