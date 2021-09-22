local appHotkeys = {
  "com.googlecode.iterm2",
--  "com.google.Chrome",
--  "com.vivaldi.Vivaldi",
  "org.mozilla.firefox",
  "com.tinyspeck.slackmacgap"
}

local appSwitchKeys = {"1", "2", "3", "4", "5", "6"}

-- Bring popular applications to foreground
local function focusApplication(id)
  local app = hs.application.find(id)
  
  if app == nil then
    hs.application.open(id)
  else
    app:activate()
  end
end

for k, id in ipairs(hs.window.allWindows()) do
  print(id:application():bundleID())
end

for k, id in ipairs(appHotkeys) do
  print(k, id)

  hs.hotkey.bind({"alt"}, appSwitchKeys[k], function() 
    focusApplication(id)
  end)
end

-- Set focused window to full screen
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "up", function()
  hs.application.frontmostApplication():focusedWindow():maximize(0)
end)

-- Toss focused window one screen left
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "left", function()
  hs.application.frontmostApplication():focusedWindow():moveOneScreenWest(true, true, 0)
end)

-- Toss focused window one screen right
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "right", function()
  hs.application.frontmostApplication():focusedWindow():moveOneScreenEast(true, true, 0)
end)

-- Move focused window to left half of screen
hs.hotkey.bind({"ctrl", "cmd"}, "left", function()
  local app = hs.application.frontmostApplication()
  local window = app:focusedWindow()
  local frame = window:screen():frame()

  frame.w = frame.w / 2

  window:setFrame(frame, 0)
end)

-- Move focused window to right half of screen
hs.hotkey.bind({"ctrl", "cmd"}, "right", function()
  local app = hs.application.frontmostApplication()
  local window = app:focusedWindow()
  local frame = window:screen():frame()

  frame.w = frame.w / 2
  frame.x = frame.x2

  window:setFrame(frame, 0)
end)

-- Move focused window to top half of screen
hs.hotkey.bind({"ctrl", "cmd"}, "up", function()
  local app = hs.application.frontmostApplication()
  local window = app:focusedWindow()
  local frame = window:screen():frame()

  frame.h = frame.h / 2

  window:setFrame(frame, 0)
end)

-- Move focused window to bottom half of screen
hs.hotkey.bind({"ctrl", "cmd"}, "down", function()
  local app = hs.application.frontmostApplication()
  local window = app:focusedWindow()
  local screenFrame = window:screen():frame()
  local windowFrame = window:frame()

  windowFrame.h = screenFrame.h / 2
  windowFrame.y = screenFrame.y + windowFrame.h

  window:setFrame(windowFrame, 0)
end)
