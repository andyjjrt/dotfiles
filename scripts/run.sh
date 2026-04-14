touch ~/.hushlogin

sudo sed -i 's|http://\(tw\.\)\?archive.ubuntu.com/ubuntu|http://free.nchc.org.tw/ubuntu|g' /etc/apt/sources.list.d/ubuntu.sources
sudo apt update
# sudo apt upgrade -y

# install essential packages
export ESSENTIAL_PACKAGES="curl git build-essential vim zsh bfs bat tree tmux"
sudo apt install -y $ESSENTIAL_PACKAGES

mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# oh my zsh
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/wfxr/forgit.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/forgit

# asdf
curl -L https://github.com/asdf-vm/asdf/releases/download/v0.18.1/asdf-v0.18.1-linux-amd64.tar.gz | tar -xz -C ~/.local/bin

# p10k
cp .p10k.zsh ~/.p10k.zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# tpm
tmux new-session -d
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# fzf
curl -L https://github.com/junegunn/fzf/releases/download/v0.71.0/fzf-0.71.0-linux_amd64.tar.gz | tar -xz -C ~/.local/bin

# Docker
INSTALL_DOCKER=${INSTALL_DOCKER:-1}
if [ "$INSTALL_DOCKER" != "0" ]; then
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  sudo groupadd docker
  sudo usermod -aG docker $USER

  # lazydocker
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# asdf
export PATH="$HOME/.local/bin:$PATH"
asdf plugin add nodejs
asdf install nodejs latest:22
asdf set -u nodejs latest:22

echo "Use ':PlugInstall' to install plugin in vim"