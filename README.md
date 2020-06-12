# @civa86/dotfiles

[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

One Repo to conf them all, One Repo to find them,

One Repo to bring them all and in the MacBook bind them

## Install

[Software List](./INSTALLME.md)

## Configure

### Git

```bash
ln -s <dotfiles>/.gitconfig ~/.gitconfig
ln -s <dotfiles>/.gitconfig-personal ~/.gitconfig-personal
ln -s <dotfiles>/.gitconfig-work ~/.gitconfig-work
ln -s <dotfiles>/.gitignore_global ~/.gitignore_global
```

### Terminal

1. Open `Terminal.app`
2. Menu: Terminal > Preferences (`Command` + `,`)
3. Tab: Profiles
4. Click `⚙` > Import
5. Select `<dotfiles>/dario.mac.terminal` > Open

### Bash

```bash
ln -s <dotfiles>/.bash_profile ~/.bash_profile
source ~/.bash_profile
```

##### Utilities

[Scripts Documentation](./SCRIPTS.md)

##### Bash Completion

```bash
<dotfiles>/shell_scripts/bin/bash-completion-install
```

#### ZSH

```bash
ln -s <dotfiles>/.zshrc ~/.zshrc
source ~/.zshrc

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Visual Studio Code

VSCode configuration is saved and versioned in a [Gist](https://gist.github.com/civa86/af53375e96402af0761d967643d8fb6e)
with [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) extension.

Install the extension and follow the instruction. Token to read/write gists is required.

### Vim

```bash
ln -s <dotfiles>/.vimrc ~/.vimrc
source ~/.vimrc
```

### Prettier

Code Style Rules.

Code formatting with [prettier](https://prettier.io/) and VSCode prettier extension.

```bash
cp <dotfiles>/.prettierrc <your_project_root_folder>
```

### Apache Webserver

##### /etc/apache2/httpd.conf

```bash
### Uncomment PHP LoadModule
LoadModule proxy_http_module libexec/apache2/mod_proxy_http.so
LoadModule rewrite_module libexec/apache2/mod_rewrite.so
LoadModule php7_module libexec/apache2/libphp7.so

### Setup DocumentRoot
DocumentRoot "/your/document/root/path"
<Directory "/your/document/root/path">
    Options Indexes FollowSymLinks Multiviews
    MultiviewsMatch Any
    AllowOverride All
    Require all granted
</Directory>

### Append to the bottom of the file and save
Include <vhost_path>/vhosts/*.conf
```

##### <vhost_path>/vhosts/000-default.conf

```bash
<VirtualHost *:80>
	DocumentRoot "/your/document/root/path" # Default has the same DocumentRoot of httpd.conf
</VirtualHost>
```

##### <vhost_path>/vhosts/template.info.conf

```bash
<VirtualHost *:80>
    SetEnv APPLICATION_ENV development  # Zend Framework env

    ServerName template.info              # Main domain
    ServerAlias www.template.info         # Alias
    ServerAlias admin.template.info       # Alias
    # ServerAlias ...

    DocumentRoot "/project/path"        # DocumentRoot path
    <Directory "/project/path">         # DocumentRoot directory configuration
        # Options...
    </Directory>
</VirtualHost>
```

##### Commands

```bash
sudo apachectl start    # Start webserver
sudo apachectl stop     # Stop webserver
sudo apachectl restart  # Restart webserver
sudo apachectl reload   # Reload Configuration
```
