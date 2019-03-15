#!/usr/bin/env bash



# URL_BREW='https://raw.githubusercontent.com/Homebrew/install/master/install'
# #URL_GVM='https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer'

# echo -n '- Installing Homebrew ... '
# echo | /usr/bin/ruby -e "$(curl -fsSL $URL_BREW)" > /dev/null
# if [ $? -eq 0 ]; then echo 'Brew Installation Successful'; else echo 'Brew Installation Unsuccessful'; fi

# echo -n '- Installing Mercurial ... '
# echo | brew install mercurial > /dev/null 
# if [ $? -eq 0 ]; then echo 'Mercurial Installation Successful'; else echo 'Mercurial Installation Unsuccessful'; fi

# rm -rf /Users/$whoami/.gvm
# echo -n '- Installing Golang Version Manager (GVM) ... '
# echo | bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
#  > /dev/null 
# if [ $? -eq 0 ]; then echo 'GVM Installation Successful'; else echo 'GVM Installation Unsuccessful'; fi

# # Restarting shell with gvm variables
# source /Users/$(whoami)/.gvm/scripts/gvm

# echo -n '- Installing Golang v.1.12 ... '
# echo | gvm install go1.12 --binary > /dev/null
# if [ $? -eq 0 ]; then echo 'Golang v.1.12 Installation Successful'; else echo 'Golang v.1.12  Installation Unsuccessful'; fi

# Set go lang version with GVM
# gvm use go1.12 --default

echo -n '- Downloading & Installing Cosmos ... '
echo | mkdir -p $GOPATH/src/github.com/cosmos && cd $GOPATH/src/github.com/cosmos && git clone https://github.com/cosmos/cosmos-sdk \
&& cd cosmos-sdk && git checkout v0.33.0 && make update_tools && make vendor-deps && make install > /dev/null
if [ $? -eq 0 ]; then echo 'Cosmos Download & Install Successful'; else echo 'Cosmos Download & Install Unsuccessful'; fi


gaiad version --long

gaiacli version --long

gaiad init $(whoami)

rm .gaiad/config/genesis.json

curl https://raw.githubusercontent.com/cosmos/launch/master/genesis.json > $HOME/.gaiad/config/genesis.json

# Adding Persistent Peer to genesis.json
sed -i '' 's/persistent_peers = ""/persistent_peers = "d0869a3e443f27ee71d13308e3c505a97b25886a@144.76.155.231:26656"/' $HOME/.gaiad/config/config.toml


#Starting Gaia
gaiad start --log_level="*:info"