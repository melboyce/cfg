# zshrc - aws things

export AWS_REGION=ap-southeast-2
export AWS_DEFAULT_REGION=ap-southeast-2
export AWS_PAGER=""

autoload bashcompinit
bashcompinit
complete -C '/usr/local/bin/aws_completer' aws
