# PATH
#export PATH="$HOME/.gem/ruby/2.3.0/bin:$HOME/.rbenv/bin:/Applications/MySQLWorkbench.app/Contents/MacOS:$PATH"
export PATH="$HOME/.gem/ruby/2.3.0/bin:$HOME/.rbenv/bin:$PATH"

# ADD POETRY IF INSTALLED
if [ -d $HOME/.poetry/bin ]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi
