function tprint(tbl, indent)
  if not indent then indent = 0 end
  local toprint = ""
  for k, v in pairs(tbl) do
    local formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      toprint = toprint .. formatting .. "\n" .. tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      toprint = toprint .. formatting .. tostring(v) .. "\n"
    else
      toprint = toprint .. formatting .. tostring(v) .. "\n"
    end
  end
  return toprint
end

-- load env file
local home = os.getenv("HOME")
local envvars = {}
local function dotenv(filepath)
  -- Open the file
  local file = assert(io.open(filepath, "r"), "Failed to open file: " .. filepath)
  
  -- Read the file line by line
  for line in file:lines() do
      -- Trim whitespace from the line
      line = line:match("^%s*(.-)%s*$")
      
      -- Skip empty lines and comments
      if line ~= "" and line:sub(1, 1) ~= "#" then
          -- Split the line into key and value
          local key, value = line:match("([^=]+)=(.*)")
          
          if key and value then
              -- Trim quotes from the value if present
              value = value:match("^[\"'](.-)[\"\']$") or value
              
              -- Set the environment variable
              envvars[key] = value
          end
      end
  end
  
  -- Close the file
  file:close()
end
dotenv(home .. '/.config/.openai')

local function setTaskEnv(task)
  task:setEnvironment(envvars)
end

local appHotkeys = {
    "com.culturedcode.ThingsMac",
--  "com.googlecode.iterm2",
  "org.mozilla.firefox",
  "com.tinyspeck.slackmacgap"
}

local appSwitchKeys = {"q", "w", "e", "r", "t", "y"}

-- Bring popular applications to foreground
local function focusApplication(id)
  local app = hs.application.find(id)
  
  if app == nil then
    hs.application.open(id)
  else
    if id == "com.tinyspeck.slackmacgap" then
      mainWindow = app:findWindow("Main")
      if mainWindow == nil then
        app:activate()
      else
        mainWindow:focus()
      end
    else
      app:activate()
    end
  end
end

for k, id in ipairs(hs.window.allWindows()) do
  print(id:application():bundleID())
end

for k, id in ipairs(appHotkeys) do
  print(k, id)

  hs.hotkey.bind({"cmd"}, appSwitchKeys[k], function() 
    focusApplication(id)
  end)
end

AI_PATH = "/Users/joseph.wegner/.pyenv/shims"
runAITool = function(runPath, callback, args)
  if args == nil then
    args = {}
  end

  print("Run AI Tool: " .. AI_PATH .. '/' .. runPath .. ' -- ' .. hs.inspect(args))

  transcribedText = ""

  local streamingCallback = function(task, stdOut, stdErr)
    -- Accumulate the text instead of sending immediately
    transcribedText = transcribedText .. stdOut
    return true
  end

  local task = hs.task.new(
    AI_PATH .. '/' .. runPath,
    function(exitCode, stdOut, stdErr)
      if exitCode == 0 then
        -- Only send the chat when the process completes successfully
        callback(transcribedText)
      else
        print('error with AI tool', exitCode)
        print(stdOut)
        print(stdErr)
        hs.notify.show('Local AI Utils - AI Error', stdOut, stdErr)
      end
    end,
    streamingCallback,
    args
  )

  setTaskEnv(task)
  task:start()
end


hs.hotkey.bind({"cmd"}, "m", function()
  local chatCallback = function(text)
    print("Chat callback: ", text)
    hs.notify.show("Local AI Utils", "", text)
  end
  
  local sendChat = function(prompt)
    hs.notify.show("Local AI Utils", "", "Prompting...")
    runAITool("assist", chatCallback, {'prompt', prompt})
  end

  runAITool("listen", sendChat)
end)

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
