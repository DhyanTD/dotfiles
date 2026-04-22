set -x PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin $PATH
# oh-my-posh init fish --config $HOME/.poshthemes/catppuccin.omp.json | source
oh-my-posh init fish --config $HOME/.poshthemes/M365Princess.omp.json | source


if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x ANDROID_HOME $HOME/Android/Sdk
set -x PATH $PATH $ANDROID_HOME/emulator
set -x PATH $PATH $ANDROID_HOME/tools
set -x PATH $PATH $ANDROID_HOME/tools/bin
set -x PATH $PATH $ANDROID_HOME/platform-tools
set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
set -x TERM tmux-256color
export XDG_DATA_DIRS="/home/linuxbrew/.linuxbrew/share:$XDG_DATA_DIRS"
set -x PATH $ANDROID_HOME/emulator $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools $PATH

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/dhyan/.cache/lm-studio/bin

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8


# cargo
fish_add_path $HOME/.cargo/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME

# fnm
# fish_add_path $HOME/.fnm
# eval (fnm env)

zoxide init fish | source

# tmuxifier
set -gx PATH ~/.tmuxifier/bin $PATH
eval (tmuxifier init - fish)

set -g theme_powerline_fonts yes 
set -g theme_nerd_fonts yes

export EDITOR='nvim'
export VISUAL='nvim'
# function fish_greeting
#   pokemon-colorscripts --no-title --shiny -n charizard
# end


# string match -q "$TERM_PROGRAM" "kiro" and . (kiro --locate-shell-integration-path fish)

# fish_add_path ~/.local/bin
# function fish_greeting
#     pokemon-colorscripts -r
#     hyfetch --backend neofetch # Or neofetch
# end

# function fish_greeting
    # pokemon-colorscripts -r --no-title
    # pokeshell -b pikachu
    # hyfetch --backend neofetch
# end

#pokeshell
set -gx PATH ~/.config/pokeshell $PATH

# pnpm
set -gx PNPM_HOME "/home/dhyan/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# opencode
fish_add_path /home/dhyan/.opencode/bin
