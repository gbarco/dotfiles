# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# ============================================================================
# set PATH so it includes user's private bin if it exists
# ============================================================================
if [ -d "${HOME}/bin" ] ; then
	PATH="${HOME}/bin:${PATH}"
fi

# ============================================================================
# If not running interactively, don't do anything
# ============================================================================
[ -z "${PS1}" ] && return

# ============================================================================
# Pre hook
# ============================================================================
if [ -f ~/.bash_pre ]; then
	. ~/.bash_pre
fi

# ============================================================================
export EDITOR=/usr/bin/vim
export PAGER="less -MIR"

# ============================================================================
# Bash history management
# ============================================================================
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# ============================================================================
# Prompt customization
# ============================================================================
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	C_RESET='\[\e[0m\]'

	: ${C_HOST:='\[\e[1;34m\]'}
	: ${C_PATH:='\[\e[1;35m\]'}

	if test "${UID}" -eq 0; then
		C_ROOT='\[\e[1;31m\]'
		PS1="${C_ROOT}[\u at ${C_HOST}\h ${C_PATH}\w${C_ROOT}]\n#${C_RESET} "
	else
		: ${C_LINE:='\[\e[1;33m\]'}
		PS1="${C_LINE}[\u at ${C_HOST}\h ${C_PATH}\w${C_LINE}]\n\$${C_RESET} "
	fi

	unset C_LINE C_ROOT C_RESET C_HOST C_PATH

fi

# If this is an xterm set the title
if [[ "${TERM}" == 'xterm' ]]; then
	PS1="\[\e]0;\u@\h: \w\a\]${PS1}"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ============================================================================
# Bash aliases
# ============================================================================
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# ============================================================================
# Bash completion
# ============================================================================
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

# ============================================================================
# MySQL
# ============================================================================
export MYSQL_PS1="[\u@\h] \d> "

# ============================================================================
# Less color config
# ============================================================================
. ~/.lessrc

# ============================================================================
# Post hook
# ============================================================================
if [ -f ~/.bash_post ]; then
	. ~/.bash_post
fi

# ============================================================================
# END
# ============================================================================

