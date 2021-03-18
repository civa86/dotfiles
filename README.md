# @civa86/dotfiles

One Repo to conf them all, One Repo to find them,

One Repo to bring them all and in the MacBook bind them

## Install

Be sure that system has the recommended [software](./docs/SOFTWARE.md) installed.

Clone the repository inside the `Documents` folder

```bash
cd ~/Documents
git clone https://github.com/civa86/dotfiles.git
cd ~/Documents/dotfiles
./setup.sh
```

#### Brew Setup

```bash
~/Documents/dotfiles/brew.sh
```

## Terminal App

1. Be sure `MesloLGS NF` font family is correctly installed
2. Open `Terminal.app`
3. Menu: Terminal > Preferences (`Command` + `,`)
4. Tab: Profiles
5. Click on the Cog and then Import
6. Select `~/Documents/dotfiles/dario.mac.terminal` > Open

## Visual Studio Code

VSCode configuration is saved and versioned in a [Gist](https://gist.github.com/civa86/af53375e96402af0761d967643d8fb6e)
with [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) extension.

Install the extension and follow the instruction. Token to read/write gists is required.

## Manual Configuration

Configure things [manually](./docs/MANUAL_CONFIG.md).

## Available Shell Scrips

Read about available [Shell Scripts](./docs/SHELL_SCRIPTS.md) shipped with this repository.
