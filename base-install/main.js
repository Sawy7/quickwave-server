const {app, BrowserWindow} = require("electron")
const path = require("path")
const url = require("url")

let win

function createWindow () {
  win = new BrowserWindow({width: 1050, height: 550, backgroundColor: "#4c4c4b", show: false})

  win.setMenu(null)

  win.loadURL(url.format({
    pathname: path.join(__dirname, "index.html"),
    protocol: "file:",
    slashes: true
  }))

  win.on('ready-to-show', function() {
      win.show();
      win.focus();
  });

  win.on("closed", () => {
    win = null
  })
}

app.on("ready", createWindow)

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit()
  }
})

app.on("activate", () => {
  if (win === null) {
    createWindow()
  }
})
