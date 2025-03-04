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
    pip \
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
    snapd \
    wireshark \
    maven \
    openjdk-11-jdk \
    dos2unix \
    htop \
    npm


# Python Sim Link:
sudo ln -s /usr/bin/python3 /usr/bin/python

# Snap Stuff:
sudo snap install cherrytree \
  amass \
  metasploit-framework \
  sqlmap 

# Set Pip Config:
echo "[install]" > ~/.config/pip/pip.conf && \
  echo "break-system-packages = true" >> ~/.config/pip/pip.conf && \
  echo "user = true" >> ~/.config/pip/pip.conf  

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

# PPrettier:
npm install -g @mixer/parallel-prettier

cd ~
mkdir -p .tools/bin
cd .tools

# Responder Tools:
git clone https://github.com/lgandx/Responder.git && \
  pip install -r Responder/requirements.txt && \
  ln -s $(pwd)/Responder/Responder.py ~/.tools/bin/responder && \
  ln -s $(pwd)/Responder/DumpHash.py ~/.tools/bin/responder-dumphash && \
  ln -s $(pwd)/Responder/Report.py ~/.tools/bin/responder-report

# Impacket Tools:
git clone https://github.com/fortra/impacket.git && cd impacket && \
  pip install -r requirements.txt && \
  python3 setup.py build && \
  IMPACKET_PATH="$(ls build | grep 'scripts')"
  for x in $(ls build/$IMPACKET_PATH); do ln -s $(pwd)/$x ~/.tools/bin/$(echo "$x" | cut -d "." -f1); done && \
  cd ..
  
# Decodify:
git clone https://github.com/s0md3v/Decodify.git && chmod +x Decodify/dcode && cp Decodify/dcode bin

# Wordlist Gen: 
git clone https://github.com/urbanadventurer/username-anarchy.git && \
  ln -s $(pwd)/username-anarchy/username-anarchy bin/username-anarchy
git clone https://github.com/pentester-io/commonspeak.git

# XXE Injector:
git clone https://github.com/enjoiz/XXEinjector.git && \
  ln -s $(pwd)/XXEinjector/XXEinjector.rb bin/XXEinjector

# TPL Map:
git clone https://github.com/epinna/tplmap.git

# Bashfuscator:
git clone https://github.com/Bashfuscator/Bashfuscator && \
  pip install pyperclip && \
  python3 Bashfuscator/setup.py build && \
  cp $(find ./Bashfuscator -name "bashfuscator" | grep scripts) bin

# XSS Strike:
git clone https://github.com/s0md3v/XSStrike.git && \
  pip install -r XSStrike/requirements.txt && \
  chmod +x XSStrike/xsstrike.py && \
  ln -s $(pwd)/XSStrike/xsstrike.py bin/xsstrike

# Pad Buster:
git clone https://github.com/AonCyberLabs/PadBuster.git && \
  ln -s $(pwd)/PadBuster/padbuster.pl bin/padbuster

# TLS-Breaker:
git clone https://github.com/tls-attacker/TLS-Breaker.git && \
  echo "[!] PICK JAVA 11" && sleep 10 && \
  sudo update-alternatives --config java && \
  cd TLS-Breaker && mvn clean install -DskipTests=true && \
  cd app && mkdir bin 

for x in *.jar; do
  script_name="bin/$(echo "$x" | awk -F'-[0-9]' '{print $1}')"
  echo '#!/bin/bash' > $script_name
  echo "java -jar $(pwd)/$x \"\$@\"" >> $script_name
  chmod +x $script_name
  ln -sf $(pwd)/$script_name ~/.tools/bin/$(basename $script_name)
done

cd ~/.tools

# JWT Foprgery:
git clone https://github.com/silentsignal/rsa_sign2n && \
  echo "RUN chmod +x jwt_forgery.py" >> rsa_sign2n/standalone/Dockerfile
  echo "ENTRYPOINT [\"python3\", \"jwt_forgery.py\"]" >> rsa_sign2n/standalone/Dockerfile
  cd rsa_sign2n/standalone && \
  docker build . -t jwt_forgery && \
  echo '#!/bin/bash' > ~/.tools/bin/jwt_forgery && \
  echo 'docker run --rm jwt_forgery "$@"' >> ~/.tools/bin/jwt_forgery && \
  chmod +x ~/.tools/bin/jwt_forgery && cd ~/.tools

# Test SSL:
git clone https://github.com/testssl/testssl.sh.git && \
  cp testssl.sh/testssl.sh bin/testssl

# Radamsa:
git clone https://gitlab.com/akihe/radamsa.git && cd radamsa && make && sudo make install
cd ~/.tools

# AFL++:
git clone https://github.com/AFLplusplus/AFLplusplus.git
docker pull aflplusplus/aflplusplus

# Bloodhound:
mkdir BloodHound && curl -L 'https://ghst.ly/getbhce' > ./BloodHound/docker-compose.yml && \ 
  cd BloodHound && docker compose pull && cd .. && \
  echo '#!/bin/bash' > bin/start-bloodhound > bin/stop-bloodhound && \
  echo "cd ~/.tools/bloodhound && docker compose start && cd ~" >> bin/start-bloodhound && \
  echo "cd ~/.tools/bloodhound && docker compose stop && cd ~" >> bin/stop-bloodhound && \
  chmod +x bin/start-bloodhound && chmod +x bin/stop-bloodhound

# Sysreptor:
bash <(curl -s https://docs.sysreptor.com/install.sh) && \
  cd ~/.tools/sysreptor/deploy && docker compose stop && \
  cd ~/.tools && \
  echo '#!/bin/bash' > bin/start-sysreptor > bin/stop-sysreptor && \
  echo "cd ~/.tools/sysreptor/deploy && docker compose start && cd ~" >> bin/start-sysreptor && \
  echo "cd ~/.tools/sysreptor/deploy && docker compose stop && cd ~" >> bin/stop-sysreptor && \
  chmod +x bin/start-sysreptor && chmod +x bin/stop-sysreptor && \
  rm -rf sysreptor.tar.gz

# Villain C2:
cd ~/.tools && git clone https://github.com/t3l3machus/Villain.git && \
  cd Villain && chmod +x Villain.py && ln -s $(pwd)/Villain.py ~/.tools/bin/villain

# Wordlists:
mkdir ~/.wordlists
cd ~/.wordlists
mkdir assetnote
cd assetnote
wget -r --no-parent -R "index.html*" https://wordlists-cdn.assetnote.io/data/ -nH -e robots=off

cd .. && git clone https://github.com/danielmiessler/SecLists.git

