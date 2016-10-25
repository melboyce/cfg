# zshrc - options

# changing directories
setopt auto_pushd               # cd pushes to dir stack
setopt cdable_vars              # if dirname doesn't exist, try with ~ in front
setopt pushd_minus              # inverts meaning of + and - for cd/pushd/popd
setopt pushd_silent             # doesn't print the stack post manipulation
setopt pushd_to_home            # pushd with no args == `pushd $HOME`
setopt pushd_ignore_dups        # ignore duplicate pushes

# completion
setopt no_auto_param_keys       # don't remove the trailing space for "keys"
setopt auto_param_slash         # add trailing slash to completions that are dirs
setopt complete_in_word         # complete from both ends of words
setopt hash_list_all            # hash command path before completion
setopt no_list_beep             # don't beep for ambiguous completions
setopt list_types               # trail completions with identifying mark

# expansion and globbing
setopt bad_pattern              # print errors for bad patterns
setopt equals                   # =COMMAND expands to full path of COMMAND
setopt extended_glob            # #~^ are pattern chars
setopt no_glob_dots             # globs don't match dotfiles
setopt magic_equal_subst        # allow expansion immediately after '='
setopt nonomatch                # bash-style no glob match behaviour (supress no-match error)

# history
setopt extended_history         # saves timestamps and runtime info
setopt hist_allow_clobber       # > and >> become >! and >>! in hist
setopt hist_fcntl_lock          # use fcntl for locking the history file (as opposed to ad-hoc locking)
setopt hist_ignore_all_dups     # unique history items only
setopt hist_ignore_space        # don't add lines that start with a space
setopt hist_reduce_blanks       # remove superfluous spaces from history entries
setopt share_history            # shares history across sessions

# input/output
setopt no_clobber               # do not truncate existing files via redirects
setopt no_flow_control          # disable start/stop tty doodads (^S/^Q)
setopt interactive_comments     # allow comments in interactive sessions

# job control
setopt long_list_jobs           # list jobs in the long format
setopt nohup                    # don't send HUP to background jobs on shell exit
setopt notify                   # report status of background jobs immediately

# prompting
setopt prompt_percent           # make '%' special in prompts
setopt prompt_subst             # do expansion and substitution in prompts

# scripts and functions
setopt pipe_fail                # exit status is that of the right-most non-zero element

# zle
setopt beep                     # beep on error in zle
