# zshrc - modules

# colors
autoload -U colors zsh/terminfo
colors

# automatically quote unsafe chars in URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# rename files; hardcore mode - examples: http://strcat.de/zsh/#zmv
autoload -Uz zmv

# schedule a command: sched [+]HH:MM COMMAND ...
autoload -Uz zsh/sched

# more than just spaces
autoload -U select-word-style
select-word-style bash

# add strftime builtin
# strftime format epochtime
zmodload zsh/datetime

# run-help: esc+h => in-line man page
autoload run-help
