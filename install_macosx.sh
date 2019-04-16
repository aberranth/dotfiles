#!/bin/sh
# install poweline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

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

# git clone https://github.com/soimort/translate-shell
# cd translate-shell/
# make PREFIX=~/.local install

cd
