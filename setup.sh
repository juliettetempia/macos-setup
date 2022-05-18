q
echo "starting machine setup"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed 
brew install gnu-tar
brew install gnu-indent
brew install gnu-which
brew install gnu-grep

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

PACKAGES=(
    ack
    autoconf
    automake
    boot2docker
    ffmpeg
    gettext
    gifsicle
    git
    graphviz
    hub
    imagemagick
    jq
    libjpeg
    libmemcached 
    lynx
    markdown
    memcached
    mercurial
    npm
    pkg-config
    postgresql
    python
    python3
    rabbitmq
    rename
    ssh-copy-id
    terminal-notifier
    the_silver_searcher
    tmux
    tree
    vim
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask apps..."
CASKS=(
    adobe-creative-cloud-cleaner-tool
    google-chrome
    google-drive
    iterm2
    macvim
    miro
    notion
    skype
    slack
    spectacle
    vagrant
    vlc
)

brew install ${CASKS[@]} --cask

echo "Installing fonts..."
FONTS=(
    font-roboto
    font-clear-sans
)
brew install ${FONTS[@]} --cask

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
pip install --upgrade setuptools
pip install --upgrade pip

echo "Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    Matplotlib
    NLTK
    NumPy
    pandas
    Pillow
    pytest
    Requests
    Seaborn
    scikit-learn
    urllib3
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Installing global npm packages..."
npm install marked -g

echo "Configuring OSX..."

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Dock size
defaults write com.apple.dock tilesize -int 32

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "Creating folder structure..."
[[ ! -d Wiki ]] && mkdir Wiki
[[ ! -d Workspace ]] && mkdir Workspace

echo "setup complete"

echo "Ready to restart machine"

while true; do
    read -p "Do you want to restart this comput4er now?" yn
    case $yn in
        [Yy]* )  osascript -e 'tell application "System Events" to restart'; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done