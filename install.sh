#! /bin/bash

# BREW
/usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
brew doctor
brew update
brew install elasticsearch phantomjs wget axel redis mongodb git mysql imagemagick memcached

# RVM
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm pkg install readline
rvm install 1.9.3
rvm use 1.9.3 --default
gem install passenger bundler foreman rails

# Node/NPM
brew install node
curl http://npmjs.org/install.sh | sh
# npm install coffee-script


# bash-it
git clone http://github.com/revans/bash-it.git ~/.bash_it
~/.bash_it/install.sh

