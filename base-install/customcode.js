$("#anglictina").load("cds/anglictina/loader.html");
$("#francouzstina").load("cds/francouzstina/loader.html");
$("#nemcina").load("cds/nemcina/loader.html");
$("#spanelstina").load("cds/spanelstina/loader.html");
$("#ostatni").load("cds/ostatni/loader.html");

function refresh() {
  location.reload()
}

function testplayinit() {
  document.getElementById("test-source").src = "audio/soundtest.mp3";
  if (typeof testplayer == 'undefined') {
    testplayer = new MediaElementPlayer("testplay");
  }
}

function testplay() {
  testplayer.setSrc("audio/soundtest.mp3");
  testplayer.load();
  testplayer.play();
  document.getElementById("navbar").style = "display: none";
  document.getElementById("audio-bar").style = "display: none"
  electron = require('electron');
  win = electron.remote.getCurrentWindow();
  win.setFullScreen(true);
  player.pause();
}

function teststop() {
  testplayer.pause();
  win.setFullScreen(false);
  document.getElementById("navbar").style = "";
  document.getElementById("audio-bar").style = "";
}

function executor() {
  var child = require('child_process').execFile;
  var executablePath = "C:\\Program Files (x86)\\PuTTY\\putty.exe";

  child(executablePath, function(err, data) {
    if(err){
       console.error(err);
       return;
    }

    console.log(data.toString());
  });
}
