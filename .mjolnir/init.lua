local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local screen = require "mjolnir.screen"
local fnutils = require "mjolnir.fnutils"
local keycodes = require "mjolnir.keycodes"
local grid = require "mjolnir.bg.grid"
local appfinder = require "mjolnir.cmsj.appfinder"

-- Push Configs
hotkey.bind({"ctrl", "alt"}, "right", grid.pushwindow_nextscreen)
hotkey.bind({"ctrl", "alt"}, "left", grid.pushwindow_prevscreen)

-- Push & Maximize Configs
hotkey.bind({"cmd", "ctrl", "alt"}, "right", function()
  grid.pushwindow_nextscreen()
  grid.maximize_window()
end)
hotkey.bind({"cmd", "ctrl", "alt"}, "left", function()
  grid.pushwindow_prevscreen()
  grid.maximize_window()
end)

-- Full Screen
hotkey.bind({"cmd", "ctrl", "alt"}, "up", grid.maximize_window)

-- Half Window Configs
hotkey.bind({"cmd", "ctrl"}, "left", function()
  local win = window.focusedwindow()
  local winfrm = win:frame()
  local scrn = win:screen()
  local scrnframe = scrn:frame()
  winfrm.w = scrnframe.w / 2
  winfrm.h = scrnframe.h
  winfrm.x = scrnframe.x
  winfrm.y = scrnframe.y
  win:setframe(winfrm)
end)

hotkey.bind({"cmd", "ctrl"}, "right", function()
  local win = window.focusedwindow()
  local winfrm = win:frame()
  local scrn = win:screen()
  local scrnframe = scrn:frame()
  winfrm.w = scrnframe.w / 2
  winfrm.h = scrnframe.h
  winfrm.x = scrnframe.x + winfrm.w
  winfrm.y = scrnframe.y
  win:setframe(winfrm)
end)

hotkey.bind({"cmd", "ctrl"}, "down", function()
  local win = window.focusedwindow()
  local winfrm = win:frame()
  local scrn = win:screen()
  local scrnframe = scrn:frame()
  winfrm.w = scrnframe.w
  winfrm.h = scrnframe.h / 2
  winfrm.x = scrnframe.x
  winfrm.y = scrnframe.y + winfrm.h
  win:setframe(winfrm)
end)

hotkey.bind({"cmd", "ctrl"}, "up", function()
  local win = window.focusedwindow()
  local winfrm = win:frame()
  local scrn = win:screen()
  local scrnframe = scrn:frame()
  winfrm.w = scrnframe.w
  winfrm.h = scrnframe.h / 2
  winfrm.x = scrnframe.x
  winfrm.y = scrnframe.y
  win:setframe(winfrm)
end)

-- App launch/open hotkeys

hotkey.bind({"ctrl"}, "1", function()
  --local app = appfinder.app_from_name("iTerm")
  application.launchorfocus("iTerm") 
end)

hotkey.bind({"ctrl"}, "2", function()
  --local app = appfinder.app_from_name("iTerm")
  application.launchorfocus("Google Chrome") 
end)

hotkey.bind({"ctrl"}, "3", function()
  --local app = appfinder.app_from_name("iTerm")
  application.launchorfocus("Slack") 
end)
