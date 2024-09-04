sudo apt update

sudo sed -i 's/tw.archive.ubuntu.com/free.nchc.org.tw/g' \
/etc/apt/sources.list

sudo apt update
sudo apt upgrade

# install essential packages
export ESSENTIAL_PACKAGES="curl git build-essential"
sudo apt install $ESSENTIAL_PACKAGES

mkdir ~/.local

# oh my zsh
sudo apt install zsh
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp .zshrc ~/.zshrc

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
./~/.fzf/install