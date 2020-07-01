# Manual Configuration

## Fonts

```bash
cp ~/Documents/dotfiles/font/* ~/Library/Fonts/
```

## Git

```bash
ln -s ~/Documents/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Documents/dotfiles/.gitconfig-personal ~/.gitconfig-personal
ln -s ~/Documents/dotfiles/.gitconfig-work ~/.gitconfig-work
ln -s ~/Documents/dotfiles/.gitignore_global ~/.gitignore_global
```

## ZSH

```bash
ln -s ~/Documents/dotfiles/.zshrc ~/.zshrc
source ~/.zshrc

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/lukechilds/zsh-better-npm-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-better-npm-completion

# Theme
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
ln -s ~/Documents/dotfiles/.p10k.zsh ~/.p10k.zsh
```

## Bash

```bash
ln -s ~/Documents/dotfiles/.bash_profile ~/.bash_profile
source ~/.bash_profile
```

##### Bash Completion Scripts

```bash
~/Documents/dotfiles/shell_scripts/bin/bash-completion-install
```

## Vim

```bash
ln -s ~/Documents/dotfiles/.vimrc ~/.vimrc
source ~/.vimrc
```

## Apache

```bash
# Create Vhosts and copy default one
mkdir -p ~/Workspace/vhosts
cp ~/Documents/dotfiles/vhosts/000-default.conf ~/Workspace/vhosts/000-default.conf
sed -i '' "s/HOME/$(echo $HOME | sed 's_/_\\/_g')/g" ~/Workspace/vhosts/000-default.conf

# Copy Apache configuration file (sudo required)
sudo cp ~/Documents/dotfiles/httpd.conf /etc/apache2/httpd.conf
sudo sed -i '' "s/HOME/$(echo $HOME | sed 's_/_\\/_g')/g" /etc/apache2/httpd.conf

# Check Apache configuration
apachectl configtest
# reboot Apache
sudo apachectl restart
```
