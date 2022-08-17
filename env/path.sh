# PATH
#export PATH="$HOME/.gem/ruby/2.3.0/bin:$HOME/.rbenv/bin:/Applications/MySQLWorkbench.app/Contents/MacOS:$PATH"
EXPORT_PATH="$HOME/.gem/ruby/2.3.0/bin:$HOME/.rbenv/bin"

# HOMEBREW MAC ARM
if [ -d /opt/homebrew/bin ]; then
  EXPORT_PATH="$EXPORT_PATH:/opt/homebrew/bin"
fi

# ADD POETRY IF INSTALLED
if [ -d $HOME/.poetry/bin ]; then
  EXPORT_PATH="$EXPORT_PATH:$HOME/.poetry/bin"
fi

# PYENV
if [ -d $HOME/.pyenv ]; then
  EXPORT_PATH="$EXPORT_PATH:$HOME/.pyenv"
fi

export PATH="$EXPORT_PATH:$PATH"
