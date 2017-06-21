#!/bin/bash
cwd=$(pwd)
dconf write /org/mate/panel/toplevels/bottom/auto-hide true
dconf write /org/mate/caja/desktop/computer-icon-visible false
dconf write /org/mate/caja/desktop/home-icon-visible false
dconf write /org/mate/caja/desktop/trash-icon-visible false
dconf write /org/mate/desktop/background/color-shading-type "'solid'"
dconf write /org/mate/desktop/background/picture-options "'centered'"
dconf write /org/mate/desktop/background/picture-filename "'$cwd/plocha/click.png'"
codename=$(zenity --entry --text "Zadejte pracovni nazev (např.: solutions-intermediate):")
serie=$(zenity --entry --text "Zadejte název série, ze které je kniha (např: Solutions):")
fullname=$(zenity --entry --text "Zadejte úplný název (např.: Maturita Solutions Intermediate):")
cislovydani=$(zenity --entry --text "Zadejte podtitul nebo čislo vydání slovy (např.: 2nd edition):")
jazykvolba=$(zenity  --list  --text "V jakém jazyce je tento disk?" --radiolist  --column "Volba" --column "Jazyk" TRUE "Angličtina"  FALSE "Francouzština" FALSE "Němčina" FALSE "Španělština" FALSE "Ostatní")
if [ $jazykvolba = "Angličtina" ]; then
	jazyk="anglictina";
	elif [ $jazykvolba = "Francouzština" ]; then
		jazyk="francouzstina"
		elif [ $jazykvolba = "Němčina" ]; then
		jazyk="nemcina"
			elif [ $jazykvolba = "Španělština" ]; then
			jazyk="spanelstina"
			else
				jazyk=ostatni	
fi
listname=$codename"-list"
listfunction=$codename"list()"
backbutton=$codename"back()"
upozorneni=$(zenity --info --text "Vložte CD a stiskněte klávesu")
dconf write /org/mate/desktop/background/picture-filename "'$cwd/plocha/waiting.png'"
mkdir cds/$jazyk/$codename
mkdir cds/$jazyk/$codename/Audio
cd cds/$jazyk/$codename/Audio
cp ../../../../abcde/cddb-tool cddb-tool
cp ../../../../abcde/abcde.conf abcde.conf
read -n 1 -s
./../../../../abcde/abcde-modified
rm cddb-tool
rm abcde.conf
p=$(ls -1 | wc -l)
zenity --info --text "Z disku bylo zkopírováno $p skladeb."
cd ../..
echo -e "<div class='col-sm-3' id='$codename'>
\t <div class='product-image-wrapper'>
\t \t <div class='single-products'>
\t \t \t <div class='productinfo text-center'>
\t \t \t \t <img src='graphics/empty.png' alt=''>
\t \t \t \t <h2>$serie</h2>
\t \t \t \t <p>$fullname</p>
\t \t \t \t <p>($cislovydani)</p>
\t \t \t \t <button onclick='$listfunction' class='btn btn-default btn-list'><i class='fa fa-play'></i>Přehrát</button>
\t \t \t </div>
\t \t </div>
\t </div>
</div>
<div class='col-sm-3' style='display: none' id='$listname'>
\t <div class='list-group'>
\t \t <a href='#' onclick='$backbutton' class='list-group-item'>
\t \t \t <p class='list-group-item-text'><i class='fa fa-level-up'></i> Jít zpět</p>
\t \t </a>" >> loader.html
cd ../..
echo -e "function $listfunction {
  \t document.getElementById('$codename').style = 'display: none';
  \t document.getElementById('$listname').style = 'overflow-y: scroll; height: 350px';
  \t document.getElementById('player-source').src = 'cds/$jazyk/$codename/Audio%20(01).mp3';
  \t if (typeof player == 'undefined') {
  \t \t player = new MediaElementPlayer('audio-player');
  \t };
  };
function $backbutton {
\t document.getElementById('$codename').style = '';
\t document.getElementById('$listname').style = 'display: none';
}" >> alltracks.js
for i in $(seq 1 $p)
do
fname=$codename"track"$i
cd cds/$jazyk
echo -e "<a href='#' onclick='$fname()' class='list-group-item'>
\t <p class='list-group-item-text'>Track $i</p>
</a>" >> loader.html
cd ../..
echo -e "function $fname() {
\t player.setSrc('cds/$jazyk/$codename/Audio/Audio%20(0$i).mp3');
\t player.load();
\t player.play()}" >> alltracks.js
done
cd cds/$jazyk
echo -e "\t </div>
</div>" >> loader.html
cd ../..
dconf write /org/mate/desktop/background/picture-filename "'$cwd/plocha/success.png'"
zenity --info --text "Všechny operace dokončeny!"
dconf write /org/mate/desktop/background/picture-filename "'$cwd/plocha/click.png'"