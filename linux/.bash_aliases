# General
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias vi='vim'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias gput='nvidia-smi -q -d temperature'
alias setclip='xclip -selection c'
alias getclip='xclip -selection c -o'
alias update-configs='ansible-playbook "$CONFIGS_DIR/ansible/update_configs.yml" -K'
alias install-packages='ansible-playbook "$CONFIGS_DIR/ansible/install_packages.yml" -K'
alias wifi-manager='nm-connection-editor'

# Programming
alias python3m='python3 -m cProfile'
alias python='python3'
alias haskell='ghc'
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.11.1-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.11.1-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'
