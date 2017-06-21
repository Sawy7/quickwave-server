Dokumentace Ripperu
==
Základní informace
--
- Jádro programu je Bash script
  - Nejlepší podpora v Unixovém systému (testováno pouze pod Linuxem)
- Grafické uživatelské rozhraní je z velké části závislé na GTK (Zenity)
  - Naše nastavení užívá okenní manažer Mate z Arch Linux repositáře
- Doporučujeme užívat LTS jádro a případně LTS vydání zvoleného OS

>Je možno využít téměř jakýkoliv operační systém a prostředí - tyto změny se ale velice pravděpodobně neobejdou bez úprav kódu

Instalace
--
>Tyto příkazy jsou použitelné pouze při instalaci na Arch Linuxu. S menší úpravou systaxe by měly jít bez ptoblému apllikovat na jakoukoliv distibuci Linuxu pod Sluncem.


- Je třeba nainstalovat a spustit Apache server
  ``` shell
  pacman -Syu
  sudo pacman -S apache
  sudo systemctl enable httpd.service
  sudo systemctl start httpd.service
  ```

- (Volitelné!) Dále jsem se rozhodl zbavit firewall softwaru, který byl nainstalován Cinchi instalátorem při instalaci systému

  ``` shell
  sudo pacman -Rs gufw ufw
  ```

- Nastavíme přístupová práva do složky, kterou Apache servíruje

  ``` shell
  sudo chmod -R 777 /srv/http
  ```

- Nyní překopírujeme base instalaci backendové části do složky Apache web serveru

  ``` shell
  cd /tmp
  wget https://github.com/Sawy7/quickwave-server/archive/master.zip
  unzip master.zip
  cp -rf quickwave-server-master/base-install/* /srv/http
  ```

- Přesuneme se do složky, kam jsme nahráli soubory a začneme povolovat spouštění skriptů nutných k běhu programu

  ``` shell
  cd /srv/http
  chmod a+x quickwave-server.sh
  chmod a+x abcde/abcde
  chmod a+x abcde/cddb-tool
  ```

- Nainstalujeme ještě některé závislosti nutné k běhu, které získáme z Arch repositářů

  ``` shell
  sudo pacman -S cdparanoia lame cd-discid vorbis-tools python-eyed3 python2-pathlib dconf-editor
  ```

Užitečné maličkosti
--
>Je tady dalších pár věcí, které doporučujeme, abyste si nainstalovali a nastavili. Nejsou povinné a ani nutné, ale velice užitečné.

- Nainstalovat a nastavit SSH server

  ``` shell
  sudo pacman -S openssh
  sudo systemctl enable sshd.socket
  sudo systemctl start sshd.socket
  ```
