# .bash_profile is executed to configure your shell
# before the initial command prompt.

# User specific environment and startup programs
export EDITOR='vim'
export PATH=$PATH:$HOME/.bin:$HOME/bin:$HOME/.local/bin:/usr/local/heroku/bin
if [ "$(uname)" == "Darwin" ]; then
  # FUCKING macosx
  export BASH_SILENCE_DEPRECATION_WARNING=1
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# if [ "$(uname)" == "Darwin" ]; then
#     # Do something under Mac OS X platform
#     if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#         __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
#         GIT_PROMPT_ONLY_IN_REPO=1
#         source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
#     fi
# elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
#     # Do something under GNU/Linux platform
#     if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
#         GIT_PROMPT_ONLY_IN_REPO=1
#         source $HOME/.bash-git-prompt/gitprompt.sh
#     fi
# elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
#     # Do something under 32 bits Windows NT platform
#     :
# elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
#     # Do something under 64 bits Windows NT platform
#     :
# fi

# brew install git bash-completion
if [ "$(uname)" == "Darwin" ]; then
    [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
        # if not found in /usr/local/etc, try the brew --prefix location
        [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
            . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
    }
fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
#ADDED BY 010 EDITOR
export PATH="$PATH:/Applications/010 Editor.app/Contents/CmdLine"
