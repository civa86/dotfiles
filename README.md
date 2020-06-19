# @civa86/dotfiles

One Repo to conf them all, One Repo to find them,

One Repo to bring them all and in the MacBook bind them

## Install

Be sure that system has the recommended [software](./docs/SOFTWARE.md) installed.

Clone the repository inside the `Documents` folder

```bash
cd ~/Documents
git clone https://github.com/civa86/dotfiles.git
cd ~/Documents
./setup.sh
```

## Manual Configuration

### Fonts

```bash
cp ~/Documents/dotfiles/font/* ~/Library/Fonts/
```

### Git

```bash
ln -s ~/Documents/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Documents/dotfiles/.gitconfig-personal ~/.gitconfig-personal
ln -s ~/Documents/dotfiles/.gitconfig-work ~/.gitconfig-work
ln -s ~/Documents/dotfiles/.gitignore_global ~/.gitignore_global
```

### Terminal

1. Be sure `MesloLGS NF` font family is correctly installed
2. Open `Terminal.app`
3. Menu: Terminal > Preferences (`Command` + `,`)
4. Tab: Profiles
5. Click on the Cog and then Import
6. Select `~/Documents/dotfiles/dario.mac.terminal` > Open

### ZSH

```bash
ln -s ~/Documents/dotfiles/.zshrc ~/.zshrc
source ~/.zshrc

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Syntax Higlihting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# powerlevel10k Theme
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
ln -s ~/Documents/dotfiles/.p10k.zsh ~/.p10k.zsh
```

### Bash

```bash
ln -s ~/Documents/dotfiles/.bash_profile ~/.bash_profile
source ~/.bash_profile
```

##### Bash Completion Scripts

```bash
~/Documents/dotfiles/shell_scripts/bin/bash-completion-install
```

### Visual Studio Code

VSCode configuration is saved and versioned in a [Gist](https://gist.github.com/civa86/af53375e96402af0761d967643d8fb6e)
with [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) extension.

Install the extension and follow the instruction. Token to read/write gists is required.

### Vim

```bash
ln -s ~/Documents/dotfiles/.vimrc ~/.vimrc
source ~/.vimrc
```

## Other Resources

- [Local HTTP + PHP](./docs/APACHE.md)
- [Available Shell Scripts](./docs/SHELL_SCRIPTS.md)
