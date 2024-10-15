#! /bin/bash 

# Snap Install:
sudo mv /etc/apt/preferences.d/nosnap.pref ~/Documents/nosnap.backup

# Update system
sudo apt-get update

# Simple Tools:
sudo apt install -y \
    cupp \
    whatweb \
    john \
    hashcat \
    masscan \
    socat \
    wafw00f \
    openssl \
    hydra \
    cewl \
    hashid \
    wine \
    sqlmap \
    git \
    gem \
    python3 \
    python3-pip \
    python3-argcomplete \
    xclip \
    openvpn \
    smbclient \
    ftp \
    nmap \
    steghide \
    binwalk \
    arpwatch \
    yara \
    wfuzz \
    tcpdump \
    gdb \
    jq \
    snapd 

# Python Sim Link:
sudo ln -s /usr/bin/python3 /usr/bin/python

# GDB Plugin:
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

# Docker Install:
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources: (Ubuntu Specific)
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$UBUNTU_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Caido Install:
cd tmp
mkdir caido
cd caido
wget $(curl -s https://api.caido.io/releases/latest | jq -r '.links[] | select(.link | contains("cli") and contains("linux") and contains("x86")) | .link')
tar -xf $(curl -s https://api.caido.io/releases/latest | jq -r '.links[] | select(.link | contains("cli") and contains("linux") and contains("x86")) | .link' | cut -d "/" -f6)
sudo mv ./caido-cli /usr/bin/caido
cd ..
rm -rf caido

# Snap Stuff:
sudo snap install cherrytree\
  amass \
  metasploit-framework \
  responder \
  impacket-scripts \
  sqlmap \

# Android Studio:



# Install Go:
wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz && export PATH=$PATH:/usr/local/go/bin

# Go Tools:
go install github.com/ffuf/ffuf/v2@latest
go install github.com/tomnomnom/waybackurls@latest
go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest
go install github.com/BishopFox/jsluice/cmd/jsluice@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/httprobe@latest
go install -v github.com/tomnomnom/anew@latest

# mkdir ~/.go
# cd /home/lag_skip/go/bin
# sleep 10
# pdtm -ia
# cd ~
# mv go .go 

cd ~
mkdir -p .tools/bin
cd .tools

# Shadow Clone: ADD LINK TO BIN
git clone https://github.com/fyoorer/ShadowClone.git

# Decodify:
git clone https://github.com/s0md3v/Decodify.git && chmod +x Decodify/dcode && cp Decodify/dcode bin

# Wordlist Gen: ADD LINK TO BIN
git clone https://github.com/urbanadventurer/username-anarchy.git 
git clone https://github.com/pentester-io/commonspeak.git

# Endpoint Disco:
git clone https://github.com/GerbenJavado/LinkFinder.git

# Attack Specific:
git clone https://github.com/enjoiz/XXEinjector.git
git clone https://github.com/epinna/tplmap.git
git clone https://github.com/Bashfuscator/Bashfuscator

# Wordlists:
mkdir ~/.wordlists
cd ~/.wordlists
mkdir assetnote
cd assetnote
wget -r --no-parent -R "index.html*" https://wordlists-cdn.assetnote.io/data/ -nH -e robots=off

cd .. && git clone https://github.com/danielmiessler/SecLists.git

