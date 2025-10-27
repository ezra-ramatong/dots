XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"

# Default Programs
export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERMINAL="alacritty"
export BROWSER="firefox"
export GIT_EDITOR="$EDITOR"
export ELECTRON_OZONE_PLATFORM_HINT="wayland"
export QT_QPA_PLATFORMTHEME="qt6ct"
export GOPATH="$HOME/go"
export GOBIN=""
export GDK_BACKEND=wayland gimp
export JAVA_HOME="$HOME/.sdkman/candidates/java/23.0.1-open"
export JAVA_SRC_DIR="src"
export JAVA_MAIN_CLASS="Main"
export PGDATA=/var/lib/postgres/data
export PGADMIN_DEFAULT_EMAIL='ezra@lol.com'
export PGADMIN_DEFAULT_PASSWORD='1234'
# FZF Colors
# Catpuccin
export FZF_DEFAULT_OPTS=" \
 --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
 --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
 --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
 --color=selected-bg:#45475A \
 --color=border:#313244,label:#CDD6F4"

# Rosepine Dawn
# export FZF_DEFAULT_OPTS="
# 	--color=fg:#797593,bg:#faf4ed,hl:#d7827e
# 	--color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
# 	--color=border:#dfdad9,header:#286983,gutter:#faf4ed
# 	--color=spinner:#ea9d34,info:#56949f
# 	--color=pointer:#907aa9,marker:#b4637a,prompt:#797593"




# PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/bin"
#export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/home/ezra/.dotnet/tools"
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/apps/intellij-idea-community-edition/bin"
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/apps/rider/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/Dev/projects/boilerplate/"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
