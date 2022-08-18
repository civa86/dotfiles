# PATH
#export PATH="$HOME/.gem/ruby/2.3.0/bin:$HOME/.rbenv/bin:/Applications/MySQLWorkbench.app/Contents/MacOS:$PATH"
EXPORT_PATH="$HOME/.gem/ruby/2.3.0/bin:$HOME/.rbenv/bin"

# HOMEBREW APPLE SILICON
if [ -d /opt/homebrew/bin ]; then
  EXPORT_PATH="$EXPORT_PATH:/opt/homebrew/bin"
fi
if [ -d /opt/homebrew/opt/jpeg ]; then
  EXPORT_PATH="$EXPORT_PATH:/opt/homebrew/opt/jpeg/bin"
fi

# POETRY
if [ -d $HOME/.poetry/bin ]; then
  EXPORT_PATH="$EXPORT_PATH:$HOME/.poetry/bin"
fi

# PYENV
if [ -d $HOME/.pyenv ]; then
  EXPORT_PATH="$EXPORT_PATH:$HOME/.pyenv"
fi

export PATH="$EXPORT_PATH:$PATH"
