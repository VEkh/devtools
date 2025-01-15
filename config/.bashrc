#!/usr/bin/env bash

# shellcheck disable=1090,1091

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [ -n "$ZSH_VERSION" ]; then
  bindkey -e # Emacs key bindings (ctrl+p, ctrl+n)
  setopt prompt_subst # Prompt expression and parameter expansion
  setopt nonomatch # zsh passes original glob upon fail
fi

# Global env vars
export EDITOR=$(which vim)
export ERL_AFLAGS="-kernel shell_history enabled"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export TZ=UTC # Set time zone to UTC

# App settings
export HACKTIVE_DIR=`echo ~/apps/hacktive`
export HOTTSPOT_DIR=`echo ~/apps/hottspot`
export HOTTSPOT_TAOBOT_REMOTE_HOST="red.vidalekechukwu.com"
export RAILS_ENV="development"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
[ -n "$BASH_VERSION" ] && shopt -s histappend
[ -n "$ZSH_VERSION" ] && setopt APPEND_HISTORY

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
[ -n "$BASH_VERSION" ] && shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_functions ] && source ~/.bash_functions
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -n "$BASH_VERSION" -a -f ~/.bash_prompt ] && source ~/.bash_prompt
[ -n "$ZSH_VERSION" -a -f ~/.zsh_prompt ] && source ~/.zsh_prompt

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi
[ -f ~/.bundler-exec.sh ] && source ~/.bundler-exec.sh

if [ -f ~/.completions/exercism/exercism_completion.bash ]; then
  source ~/.completions/exercism/exercism_completion.bash
fi

# if [[ -f ~/.linux_init/init ]]; then ~/.linux_init/init; fi

# phusion passenger settings
export PATH=/usr/local/bin:$PATH

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# RVM settings
export rvmsudo_secure_path=1
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# asdf Version Manager
source $HOME/.asdf/asdf.sh

[ -n "$BASH_VERSION" ] && source "$HOME/.asdf/completions/asdf.bash"

if [ -n "$ZSH_VERSION" ]; then
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)

  # # initialise completions with ZSH's compinit
  autoload -Uz compinit && compinit
fi

# Yarn (Must come after asdf)
export PATH="$PATH:`yarn global bin`"

# Install gems without sudo on Mac OSX
if [ -d "$HOME/.gem" ]; then
  export GEM_HOME="$HOME/.gem"
  export PATH="$PATH:$GEM_HOME/bin"
fi

. $HOME/.asdf/completions/asdf.bash

export PYTHONSTARTUP="${HOME}/.pythonstartup"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/vekh/.miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/vekh/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/vekh/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/vekh/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
