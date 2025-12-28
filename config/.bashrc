#!/usr/bin/env bash

# shellcheck disable=1090,1091

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Global env vars
export EDITOR=$(which vim)
export ERL_AFLAGS="-kernel shell_history enabled"
export PYTHONSTARTUP="${HOME}/.pythonstartup"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export TZ=UTC # Set time zone to UTC

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
[ -n "$BASH_VERSION" ] && shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

[ -f "${HOME}/.aliases" ] && source "${HOME}/.aliases"
[ -f "${HOME}/.functions" ] && source "${HOME}/.functions"
[ -f "${HOME}/.git-prompt.sh" ] && source "${HOME}/.git-prompt.sh"
[ -f "${HOME}/.bash_prompt" ] && source "${HOME}/.bash_prompt"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

[ -f "${HOME}/.bundler-exec.sh" ] && source "${HOME}/.bundler-exec.sh"

# Exercism
if [ -f "${HOME}/.completions/exercism/exercism_completion.bash" ]; then
  source "${HOME}/.completions/exercism/exercism_completion.bash"
fi

# [[ -f "${HOME}/.linux_init/init" ]] && "${HOME}/.linux_init/init"

[[ -f "${HOME}/.local/bin/mise" ]] && eval "$(${HOME}/.local/bin/mise activate bash)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/vekh/.miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "${HOME}/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
