Big thanks
==
>An essential part of this thing is very much dependent on piece of sofrware called abcde. It enabled me to implement one of the features pretty easily and for this all the people that participated on abcde rock!

Link to their page: https://abcde.einval.com/wiki/

Dokumentace Ripperu [CZ - EN version comming soon(ish)]
===
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
  sudo pacman -Syu
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

- Nyní stáhenem a překopírujeme base instalaci backendové části do složky Apache web serveru
  - Tato část lze provést několika způsoby - tato sada příkazů ale zaručí vždy nejnovější verzi a jednoduchý postup
  - Mějte tedy na paměti, že pří stahování jiným způsobem je třeba pohlídat si, jestli byly staženy i balíčky z jiných repositářů (což se při obyčejném klonování repositáře do zipu nestane)

  ``` shell
  sudo pacman -S git
  cd /tmp
  git clone --recursive https://github.com/Sawy7/quickwave-server.git
  cp -rf quickwave-server/base-install/* /srv/http
  ```

- Přesuneme se do složky, kam jsme nahráli soubory a začneme povolovat spouštění skriptů nutných k běhu programu a taky vytvoříme pár složek

  ``` shell
  cd /srv/http
  chmod a+x quickwave-server.sh abcde/abcde-modified abcde/cddb-tool-modified
  mkdir cds cds/anglictina cds/nemcina cds/francouzstina cds/spanelstina cds/ostatni
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
