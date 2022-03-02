# @civa86/dotfiles

One Repo to conf them all, One Repo to find them,

One Repo to bring them all and in the MacBook bind them

## Install Softwares

| SOFTWARE                                                                          | DESCRIPTION             |
| --------------------------------------------------------------------------------- | ----------------------- |
| [iTerm2](https://iterm2.com/)                                                     | MacOSX Terminal         |
| [Git](https://git-scm.com/)                                                       | Software Versioning     |
| [VSCode](https://code.visualstudio.com/)                                          | Code Editor             |
| [VirtualBox](https://www.virtualbox.org/)                                         | Virtual Machine Manager |
| [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)                     | MySQL Client            |
| [Robo 3T](https://robomongo.org/)                                                 | MondoDB Client          |
| [Postman](https://www.getpostman.com/)                                            | REST API Client         |
| [Sourcetree](https://www.sourcetreeapp.com/)                                      | Git Client              |
| [Docker](https://www.docker.com/products/docker-desktop)                          | Container Manager       |
| [awscli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html) | AWS CLI                 |

## Setup dotfiles

Clone the repository inside your `home` directory

```bash
cd ~
git clone https://github.com/civa86/dotfiles.git
./dotfiles/install.sh
```

## Terminal App

1. Be sure `MesloLGS NF` font family is correctly installed
2. Open `Terminal.app`
3. Menu: Terminal > Preferences (`Command` + `,`)
4. Tab: Profiles
5. Click on the Cog and then Import
6. Select `~/dotfiles/terminal/dario.mac.terminal` > Open

## iTerm2

1. Be sure `MesloLGS NF` font family is correctly installed
2. Open `iTerm.app`
3. Menu: iTerm2 > Preferences (`Command` + `,`)
4. Tab: Profiles
5. Button Other Actions > Import JSON Profiles...
6. Select `~/dotfiles/terminal/dario.iterm2.json` > Open

## Visual Studio Code

VSCode configuration is saved and versioned in a [Gist](https://gist.github.com/civa86/af53375e96402af0761d967643d8fb6e)
with [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) extension.

Install the extension and follow the instruction. Token to read/write gists is required.

## Available Shell Scrips

| COMMAND                 | DESCRIPTION                                             |
| ----------------------- | ------------------------------------------------------- |
| bash-completion-install | Install all the bash-completion scripts                 |
| prettier-rules-install  | Copy prettier code style rules in the current directory |
| extract-package-version | Print the version of the current directory package.json |
| release                 | Create a release of the current directory node project  |
