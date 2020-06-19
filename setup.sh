#!/usr/bin/env sh

source "`dirname $0`"/shell_scripts/utils.sh

DOTFILES_PATH=~/Documents/dotfiles

echo $CYAN"[ WORKSPACE ]"$COLOR_RESET
read -p "Setup Workspace? [Y/n] " SETUP_WORKSPACE
SETUP_WORKSPACE=${SETUP_WORKSPACE:-Y}
case "$SETUP_WORKSPACE" in
    [yY])
        if [ ! -d ~/Workspace ]
        then
            echo $GREEN"Setup Workspace and subfolders"$COLOR_RESET
            mkdir -p ~/Workspace
            mkdir -p ~/Workspace/reply ~/Workspace/civa86
        else
            echo $GREEN"Setup Workspace subfolders"$COLOR_RESET
            if [ ! -d ~/Workspace/reply ]
            then
                mkdir -p ~/Workspace/reply
            fi

            if [ ! -d ~/Workspace/civa86 ]
            then
                mkdir -p ~/Workspace/civa86
            fi
        fi
        ;;
    *) echo $RED"Skipping Workspace setup"$COLOR_RESET;;
esac

echo $CYAN"[ GIT ]"$COLOR_RESET
read -p "Setup GIT with .gitconfig files? [Y/n] " SETUP_GIT
SETUP_GIT=${SETUP_GIT:-Y}
case "$SETUP_GIT" in
    [yY])
        echo $GREEN""Copying GIT configuratiion""$COLOR_RESET
        rm -rf ~/.gitconfig ~/.gitconfig-personal ~/.gitconfig-work ~/.gitignore_global
        ln -s $DOTFILES_PATH/.gitconfig ~/.gitconfig
        ln -s $DOTFILES_PATH/.gitconfig-personal ~/.gitconfig-personal
        ln -s $DOTFILES_PATH/.gitconfig-work ~/.gitconfig-work
        ln -s $DOTFILES_PATH/.gitignore_global ~/.gitignore_global
        ;;
    *) echo $RED"Skipping GIT setup"$COLOR_RESET;;
esac

echo $CYAN"[ FONTS ]"$COLOR_RESET
echo $GREEN"Installing Shell Font"$COLOR_RESET
cp $DOTFILES_PATH/font/* ~/Library/Fonts/

echo $CYAN"[ ZSH SHELL ]"$COLOR_RESET
read -p "Setup ZSH Shell? [Y/n] " SETUP_ZSH
SETUP_ZSH=${SETUP_ZSH:-Y}
case "$SETUP_ZSH" in
    [yY])
        echo $GREEN"Setup ZSH"$COLOR_RESET
        if [ ! -d ~/.oh-my-zsh ]
        then
            echo "Install Oh-My-Zsh"
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        else
            echo "Oh-My-Zsh already installed!"
        fi

        if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]
        then
            echo "Install Syntax Highlighting Plugin"
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        else
            echo "Syntax Highlighting Plugin already installed!"
        fi

        if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k ]
        then
            echo "Install PowerLevel10k Theme"
            git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
        else
            echo "PowerLevel10k Theme already installed!"
        fi

        rm -rf ~/.p10k.zsh
        ln -s $DOTFILES_PATH/.p10k.zsh ~/.p10k.zsh
        rm -rf ~/.zshrc.pre*
        rm -rf ~/.zshrc
        ln -s $DOTFILES_PATH/.zshrc ~/.zshrc
        ;;
    *) echo $RED"Skipping ZSH setup"$COLOR_RESET;;
esac

echo $CYAN"[ BASH SHELL ]"$COLOR_RESET
read -p "Setup BASH Shell? [Y/n] " SETUP_BASH
SETUP_BASH=${SETUP_BASH:-Y}
case "$SETUP_BASH" in
    [yY])
        echo $GREEN"Setup BASH"$COLOR_RESET
        rm -rf ~/.bash_profile
        ln -s $DOTFILES_PATH/.bash_profile ~/.bash_profile
        $DOTFILES_PATH/shell_scripts/bin/bash-completion-install
        ;;
    *) echo $RED"Skipping BASH setup"$COLOR_RESET;;
esac

echo $CYAN"[ FINISH ]"$COLOR_RESET
echo "Reboot your Shell to apply changes!"