# zshrc - options
#
# mel@thestack.co

# changing directories
setopt auto_pushd               # cd pushes to dir stack
setopt pushd_minus              # inverts meaning of + and - for cd/pushd/popd
setopt pushd_silent             # doesn't print the stack post manipulation
setopt pushd_to_home            # pushes ~ onto the stack
setopt pushd_ignore_dups        # ignore duplicate pushes

# completion
setopt auto_param_slash         # add trailing slash to completions that are dirs
setopt complete_in_word         # complete from both ends of words
setopt hash_list_all            # hash command path before completion
setopt list_types               # trail completions with identifying mark

# expansion and globbing
setopt bad_pattern              # print errors for bad patterns
setopt equals                   # =COMMAND expands to full path of COMMAND
setopt extended_glob            # #~^ are pattern chars
setopt no_glob_dots             # globs don't match dotfiles
setopt nonomatch                # bash-style no glob match behaviour (supress no-match error)

# history
setopt extended_history         # saves timestamps and runtime info
setopt hist_allow_clobber       # > and >> become >! and >>! in hist
setopt hist_expire_dups_first   # purge duplicates first
# setopt hist_fcntl_lock          # use fcntl for locking the history file (as opposed to ad-hoc locking)
setopt hist_ignore_all_dups     # unique history items only
setopt hist_ignore_space        # don't add lines that start with a space
setopt hist_reduce_blanks       # remove superfluous spaces from history entries
setopt inc_append_history       # add to history file incrementally (rather than at shell exit)
setopt share_history            # shares history across sessions

# input/output
setopt noclobber                # do not truncate existing files via redirects
setopt noflowcontrol            # disable start/stop tty doodads (^S/^Q)
setopt interactive_comments     # allow comments in interactive sessions

# job control
setopt long_list_jobs           # list jobs in the long format
setopt nohup                    # don't send HUP to background jobs on shell exit
setopt notify                   # report status of background jobs immediately

# prompting
setopt prompt_subst             # do expansion and substitution in prompts
setopt prompt_percent           # mystery option

# zle
setopt beep                     # beep on error in zle
