if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim

set -x JAVA_HOME /usr/lib/jvm/java-24-openjdk
set -x PATH $PATH $JAVA_HOME/bin

set -x MAVEN_HOME /usr/share/java/maven
set -x PATH $PATH $MAVEN_HOME/bin

set -x JETBRAINS_TOOLBOX $HOME/.local/share/JetBrains/Toolbox/scripts
set -x PATH $PATH $GOROOT/bin $JETBRAINS_TOOLBOX

set -x GOROOT /usr/local/go
set -x PATH $PATH $GOROOT/bin
set -x GOPATH $HOME/golibs
set -x PATH $PATH $GOPATH/bin

set -x PATH $PATH $HOME/.local/bin

set -U fish_greeting

starship init fish | source

# Keybind
bind --mode insert \cf 'tmux-sessionizer'

# Alias
alias ssh="kitten ssh"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"
alias lsl="eza --color=always --icons=always --long --group-directories-first"
alias lst="eza -T --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"

# Abbreviation
abbr -a cls clear
abbr -a sps sudo pacman -S
abbr -a ehypr nvim $HOME/.config/hypr/hyprland.conf

# VI Mode
function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
alias ll ll --group-directories-first
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end
