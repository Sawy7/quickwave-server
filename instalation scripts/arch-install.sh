#!/bin/bash
sudo pacman -Syu --noconfirm
sudo pacman -S openssh apache git cdparanoia cd-discid vorbis-tools python-eyed3 python2-pathlib dconf-editor --noconfirm
sudo systemctl enable sshd.socket
sudo systemctl start sshd.socket
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
sleep 10
sudo chmod -R 777 /srv/http
cd /tmp
git clone --recursive https://github.com/Sawy7/quickwave-server.git
cp -rf quickwave-server/base-install/* /srv/http
cd /srv/http
chmod a+x quickwave-server.sh abcde/abcde-modified abcde/cddb-tool-modified
mkdir cds cds/anglictina cds/nemcina cds/francouzstina cds/spanelstina cds/ostatni
