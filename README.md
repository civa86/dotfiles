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
4. Click the `gear` > Import
5. Select `<dotfiles>/dario.mac.terminal` > Open

### Bash

```bash
ln -s <dotfiles>/.bash_profile ~/.bash_profile
source ~/.bash_profile
```

[Scripts Documentation](./SCRIPTS.md)

### Bash Completion

```bash
<dotfiles>/bash_scripts/bin/bash-completion-install
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

### Vhost

...
