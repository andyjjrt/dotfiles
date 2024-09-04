sudo apt update

sudo sed -i 's/tw.archive.ubuntu.com/free.nchc.org.tw/g' \
/etc/apt/sources.list

sudo apt update
sudo apt upgrade

# install essential packages
export ESSENTIAL_PACKAGES="curl git build-essential vim"
sudo apt install $ESSENTIAL_PACKAGES

mkdir ~/.local

# oh my zsh
sudo apt install zsh
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp .zshrc ~/.zshrc

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
git clone https://github.com/wfxr/forgit.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/forgit

# p10k
cp .p10k.zsh ~/.p10k.zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# tmux
sudo apt install tmux
cp .tmux.conf ~/.tmux.conf

# tpm
mkair -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
cp .fzf.zsh ~/.fzf.zsh