slate.configAll({
  defaultToCurrentScreen: true,
  nudgePercentOf: 'screenSize',
  resizePercentOf: 'screenSize',
  orderScreensLeftToRight: true
});


///////// Operations /////////

// Sizing and position
var fullscreen = slate.operation("move", {
  x: 'screenOriginX',
  y: 'screenOriginY',
  width: 'screenSizeX',
  height: 'screenSizeY'
});

var halfLeft = slate.operation('push', {
  direction: 'left',
  style: 'bar-resize:screenSizeX/2'
});

var halfRight = slate.operation('push', {
  direction: 'right',
  style: 'bar-resize:screenSizeX/2'
});

var halfTop = slate.operation('push', {
  direction: 'up',
  style: 'bar-resize:screenSizeY/2'
});

var halfBottom = slate.operation('push', {
  direction: 'down',
  style: 'bar-resize:screenSizeY/2'
});

// Window
var windowRight = slate.operation('throw', {
  screen: 'right'
});

var windowLeft = slate.operation('throw', {
  screen: 'left'
});

var windowCutDown = slate.operation('move', {
  x: 'windowTopLeftX',
  y: 'windowTopLeftY+(windowSizeY/2)',
  height: 'windowSizeY/2',
  width: 'windowSizeX'
});

var windowCutUp = slate.operation('move', {
  x: 'windowTopLeftX',
  y: 'windowTopLeftY-(windowSizeY/2)',
  height: 'windowSizeY/2',
  width: 'windowSizeX'
});

// Quick app opens
// 
// set an index to false, if you don't want anything bound to that num
var appsToLaunch = [
  {
    name: 'iTerm',
    path: '/Applications/iTerm.app'
  },
  {
    name: 'Google Chrome',
    path: '/Applications/Google Chrome.app'
  },
  {
    name: 'Slack',
    path: '/Applications/Slack.app'
  }
]

var quickLaunch = function(app, win) {
  if(isOpen(app.name)) {
    win.doOperation(slate.operation('focus', {app: app.name}));    
  } else {
    launchApp(app.path);    
  }
}


//////// Bindings //////////

slate.bind('up:ctrl;alt;cmd', fullscreen);
slate.bind('left:ctrl;cmd', halfLeft)
slate.bind('right:ctrl;cmd', halfRight)
slate.bind('up:ctrl;cmd', halfTop)
slate.bind('down:ctrl;cmd', halfBottom)
slate.bind('right:ctrl;alt;cmd', windowRight);
slate.bind('left:ctrl;alt;cmd', windowLeft);
slate.bind('down:cmd', windowCutDown);
slate.bind('up:cmd', windowCutUp);


for(var i=0,max=appsToLaunch.length; i<max; i++) {
  var app = appsToLaunch[i];

  if(app) {
    slate.bind((i+1)+':ctrl', quickLaunch.bind(slate, app))
  }
}


//////// Utilities /////////

function isOpen(app) {
  var open = false;

  slate.eachApp(function (currApp) {
    if(app.name() === app) {
      open = true;
    }
  });

  return open;
}

function launchApp(path) {
  slate.shell("/usr/bin/open \"" + path + "\"", true, "~/");
}
