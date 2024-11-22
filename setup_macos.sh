#!/bin/bash

# Function to show a spinner while a command is running
show_spinner() {
    local pid=$1
    local message=$2
    local delay=0.1
    local spin='/-\|'
    local i=0

    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} $message..."
        sleep "$delay"
    done
    printf "\rDone!        \n"
}

# Function to check if the script is run with sudo
check_sudo() {
    if [ "$EUID" -eq 0 ]; then
        echo "Please run this script without 'sudo'."
        exit 1
    fi
}

# Function to check and install Homebrew
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &
        show_spinner $! "Installing Homebrew"
        wait $!
        if [ $? -ne 0 ]; then
            echo "Error: Homebrew installation failed."
            exit 1
        fi
    else
        echo "Homebrew is already installed."
    fi
}

# Function to install Homebrew packages
install_brew_packages() {
    local packages=("$@")
    for package in "${packages[@]}"; do
        if ! brew list --formula | grep -q "^$package\$"; then
            echo "Installing Homebrew package: $package"
            brew install "$package" &
            show_spinner $! "Installing Homebrew package: $package"
            wait $!
            if [ $? -ne 0 ]; then
                echo "Error: Failed to install $package."
            fi
        else
            echo "$package is already installed."
        fi
    done
}

# Function to install Homebrew Cask packages with sudo if required
install_cask_packages() {
    local cask_packages=("$@")
    for package in "${cask_packages[@]}"; do
        if ! brew list --cask | grep -q "^$package\$"; then
            echo "Installing Cask package: $package"
            if [[ "$package" == "adobe-acrobat-reader" || "$package" == "microsoft-office" || "$package" == "tailscale" || "$package" == "wireshark" || "$package" == "tuxera-ntfs" ]]; then
                # Prompt for sudo password securely
                sudo -v
                if [ $? -ne 0 ]; then
                    echo "Error: sudo permissions are required."
                    exit 1
                fi
                sudo brew install --cask "$package" &
                show_spinner $! "Installing Cask package: $package"
                wait $!
                if [ $? -ne 0 ]; then
                    echo "Error: Failed to install Cask package: $package."
                fi
            else
                brew install --cask "$package" &
                show_spinner $! "Installing Cask package: $package"
                wait $!
                if [ $? -ne 0 ]; then
                    echo "Error: Failed to install Cask package: $package."
                fi
            fi
        else
            echo "$package is already installed."
        fi
    done
}

# Function to install Mac App Store applications
install_mac_apps() {
    local app_ids=("$@")
    for app_id in "${app_ids[@]}"; do
        echo "Installing app with ID: $app_id"
        mas install "$app_id" &
        show_spinner $! "Installing app with ID: $app_id"
        wait $!
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install app with ID $app_id."
        fi
    done
}

# Main script execution
check_sudo
install_homebrew

# Define Homebrew packages to install
homebrew_packages=(
    git
    htop
    python3
    tree
    curl
    mas
)

# Install Homebrew packages
install_brew_packages "${homebrew_packages[@]}"

# Check if Cask is installed and install it if it's not
if ! brew list --cask &> /dev/null; then
    echo "Cask is not installed. Installing..."
    brew tap homebrew/cask &
    show_spinner $! "Tapping Homebrew Cask"
    wait $!
    if [ $? -ne 0 ]; then
        echo "Error: Failed to tap Homebrew Cask."
        exit 1
    fi
fi

# Define Cask packages to install
cask_packages=(
    adobe-acrobat-reader
    microsoft-office
    tailscale
    wireshark
    tuxera-ntfs
    mountain-duck
    hazel
    vlc
    appcleaner
    iterm2
    firefox
    stremio
    rectangle
    Vscodium
)

# Install Cask packages
install_cask_packages "${cask_packages[@]}"

# List of Apple IDs you want to install
mac_apps=(
    1564384601 # Evermusic
    897118787  # Shazam
    1295203466 # Remote Desktop
)

# Install Mac App Store applications
install_mac_apps "${mac_apps[@]}"

# Set mouse tracking speed to fast
echo "Setting mouse tracking speed to fast..."
defaults write -g com.apple.mouse.scaling 3.0

# Disable .DS_Store file creation on network volumes
echo "Disabling .DS_Store file creation on network volumes..."
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# Restart SystemUIServer to apply the changes
echo "Restarting SystemUIServer to apply changes..."
killall SystemUIServer

# Check if Zsh Auto setup is installed and install it if it's not
if [ ! -d "$HOME/.Zsh Auto setup" ]; then
    echo "Zsh Auto setup is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/gustavohellwig/gh-zsh/main/gh-zsh.sh)" &
    show_spinner $! "Installing Zsh Auto setup"
    wait $!
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Zsh Auto setup."
    fi
else
    echo "Zsh Auto setup is already installed."
fi

echo "Setup complete!"
