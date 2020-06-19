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
            mkdir -p ~/Workspace
            mkdir -p ~/Workspace/reply ~/Workspace/civa86
            echo $GREEN"\t[OK] workspace and subfolders created correctly."$COLOR_RESET
        else
            if [ ! -d ~/Workspace/reply ]
            then
                mkdir -p ~/Workspace/reply
            fi

            if [ ! -d ~/Workspace/civa86 ]
            then
                mkdir -p ~/Workspace/civa86
            fi
            echo $GREEN"\t[OK] workspace subfolders created correctly."$COLOR_RESET
        fi
        ;;
    *) echo $YELLOW"[SKIP] Workspace setup"$COLOR_RESET;;
esac

echo ""
echo $CYAN"[ GIT ]"$COLOR_RESET
read -p "Configure GIT with .gitconfig files? [Y/n] " SETUP_GIT
SETUP_GIT=${SETUP_GIT:-Y}
case "$SETUP_GIT" in
    [yY])
        rm -rf ~/.gitconfig ~/.gitconfig-personal ~/.gitconfig-work ~/.gitignore_global
        ln -s $DOTFILES_PATH/.gitconfig ~/.gitconfig
        ln -s $DOTFILES_PATH/.gitconfig-personal ~/.gitconfig-personal
        ln -s $DOTFILES_PATH/.gitconfig-work ~/.gitconfig-work
        ln -s $DOTFILES_PATH/.gitignore_global ~/.gitignore_global
        echo $GREEN"\t[OK] GIT configuration applied correctly."$COLOR_RESET
        ;;
    *) echo $YELLOW"[SKIP] GIT configuration"$COLOR_RESET;;
esac

echo ""
echo $CYAN"[ FONTS ]"$COLOR_RESET
read -p "Install additional fonts? [Y/n] " SETUP_FONTS
SETUP_FONTS=${SETUP_FONTS:-Y}
case "$SETUP_FONTS" in
    [yY])
        cp $DOTFILES_PATH/font/* ~/Library/Fonts/
        echo $GREEN"\t[OK] fonts installed correctly."$COLOR_RESET
        ;;
    *) echo $YELLOW"[SKIP] Fonts"$COLOR_RESET;;
esac

echo ""
echo $CYAN"[ ZSH SHELL ]"$COLOR_RESET
read -p "Setup ZSH Shell? [Y/n] " SETUP_ZSH
SETUP_ZSH=${SETUP_ZSH:-Y}
case "$SETUP_ZSH" in
    [yY])
        echo $GREEN"Setup ZSH"$COLOR_RESET
        if [ ! -d ~/.oh-my-zsh ]
        then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            echo $GREEN"\t[OK] Oh-My-Zsh installed correctly."$COLOR_RESET
        else
            echo $YELLOW"\t[SKIP] Oh-My-Zsh already installed!"$COLOR_RESET
        fi

        if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]
        then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
            echo $GREEN"\t[OK] Syntax Highlighting Plugin installed correctly."$COLOR_RESET
        else
            echo $YELLOW"\t[SKIP] Syntax Highlighting Plugin already installed!"$COLOR_RESET
        fi

        if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k ]
        then
            git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
            echo $GREEN"\t[OK] PowerLevel10k Theme installed correctly."$COLOR_RESET
        else
            echo $YELLOW"\t[SKIP] PowerLevel10k Theme already installed!"$COLOR_RESET
        fi

        rm -rf ~/.p10k.zsh
        ln -s $DOTFILES_PATH/.p10k.zsh ~/.p10k.zsh
        rm -rf ~/.zshrc.pre*
        rm -rf ~/.zshrc
        ln -s $DOTFILES_PATH/.zshrc ~/.zshrc
        echo $GREEN"\t[OK] ZSH configuration applied correctly."$COLOR_RESET
        ;;
    *) echo $YELLOW"[SKIP] ZSH setup"$COLOR_RESET;;
esac

echo ""
echo $CYAN"[ BASH SHELL ]"$COLOR_RESET
read -p "Setup BASH Shell? [Y/n] " SETUP_BASH
SETUP_BASH=${SETUP_BASH:-Y}
case "$SETUP_BASH" in
    [yY])
        rm -rf ~/.bash_profile
        ln -s $DOTFILES_PATH/.bash_profile ~/.bash_profile
        $DOTFILES_PATH/shell_scripts/bin/bash-completion-install
        echo $GREEN"\t[OK] BASH configuration applied correctly."$COLOR_RESET
        ;;
    *) echo $YELLOW"[SKIP] BASH setup"$COLOR_RESET;;
esac

echo ""
echo $CYAN"[ VIM ]"$COLOR_RESET
read -p "Configure VIM with .vimrc file? [Y/n] " SETUP_VIM
SETUP_VIM=${SETUP_VIM:-Y}
case "$SETUP_VIM" in
    [yY])
        rm -rf ~/.vimrc
        ln -s $DOTFILES_PATH/.vimrc ~/.vimrc
        echo $GREEN"\t[OK] VIM configuration applied correctly."$COLOR_RESET
        ;;
    *) echo $YELLOW"[SKIP] VIM configuration"$COLOR_RESET;;
esac

echo ""
echo $CYAN"[ APACHE ]"$COLOR_RESET
read -p "Configure Apache Webserver? [Y/n] " SETUP_APACHE
SETUP_APACHE=${SETUP_APACHE:-Y}
case "$SETUP_APACHE" in
    [yY])
        mkdir -p ~/Workspace/vhosts
        cp $DOTFILES_PATH/vhosts/000-default.conf ~/Workspace/vhosts/000-default.conf
        sed -i '' "s/HOME/$(echo $HOME | sed 's_/_\\/_g')/g" ~/Workspace/vhosts/000-default.conf
        echo $YELLOW"\t[WARN] Super User required!"$COLOR_RESET
        sudo cp $DOTFILES_PATH/httpd.conf /etc/apache2/httpd.conf
        sudo sed -i '' "s/HOME/$(echo $HOME | sed 's_/_\\/_g')/g" /etc/apache2/httpd.conf
        apachectl configtest
        if [ $? -eq 0 ]
        then
            sudo apachectl restart
            echo $GREEN"\t[OK] APACHE configuration applied correctly."$COLOR_RESET
        else
            echo $RED"\t[ERROR] APACHE configuration seems wrong, check it and re-run."$COLOR_RESET
        fi
        ;;
    *) echo $YELLOW"[SKIP] APACHE configuration"$COLOR_RESET;;
esac

echo ""
echo $CYAN"[ FINISH ]"$COLOR_RESET
echo "Reboot your Shell to apply changes!"
echo ""



