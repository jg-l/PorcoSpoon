-- ======================================= Reload on save
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")


-- ======================================= Define Hyper
local hyper = {"ctrl", "alt", "cmd"}

-- Caps lock is remapped in Karabiner elements to hyper on hold, alfred toggle (non-us-backslash) on hold
-- https://brettterpstra.com/2017/06/15/a-hyper-key-with-karabiner-elements-full-instructions/

-- ======================================= Window and Space Management

    -- Use ctrl + right/left to move spaces right or left
    hs.hotkey.bind('ctrl', 'right', function()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, true):post()
        hs.eventtap.event.newKeyEvent('right', true):post()
        hs.eventtap.event.newKeyEvent('right', false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, false):post()
        -- hs.execute("/usr/local/bin/yabai -m space --focus next")
    end)
    
    hs.hotkey.bind('ctrl', 'left', function()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, true):post()
        hs.eventtap.event.newKeyEvent('left', true):post()
        hs.eventtap.event.newKeyEvent('left', false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, false):post()
        -- hs.execute("/usr/local/bin/yabai -m space --focus prev")
    end)

--  // Mirow Window Manager
hs.loadSpoon("MiroWindowsManager")

    hs.window.animationDuration = 0.3
    spoon.MiroWindowsManager:bindHotkeys({
      up = {hyper, "up"},
      right = {hyper, "right"},
      down = {hyper, "down"},
      left = {hyper, "left"},
      fullscreen = {hyper, "f"}
    })
    
    -- Move window to center
    hs.hotkey.bind(hyper, 'escape', function()
      local win = hs.window.focusedWindow()
      local frame = win:frame()
      local screen = win:screen():frame()
      local x = frame
      x.x = ((screen.w - frame.w) / 2) + screen.x
      x.y = ((screen.h - frame.h) / 2) + screen.y
      win:setFrame(x)
    end)

--  // Static Window positions

    -- Move window to left 1/4
    hs.hotkey.bind(hyper, '1', function()
      hs.window.focusedWindow():moveToUnit({ 0, 0, 0.25, 1 })
    end)
    -- Move window to center 1/2
    hs.hotkey.bind(hyper, '2', function()
      hs.window.focusedWindow():moveToUnit({ 0.25, 0, 0.5, 1 })
    end)
    -- Move window to right 1/4
    hs.hotkey.bind(hyper, '3', function()
      hs.window.focusedWindow():moveToUnit({ .75, 0, 0.25, 1 })
    end)

--  // Mission control Mod

    -- Hyper+home Opens mission control with spaces visible. 
    -- Still buggy, so doesn't work every time.
    -- Would appreciate any help on getting sleep timers working.
    
    hs.hotkey.bind({"ctrl", "alt", "cmd"},'home', function()
       local mousepoint = hs.mouse.absolutePosition()
       hs.mouse.absolutePosition({x=0,y=0})
       hs.eventtap.event.newKeyEvent('ctrl', true):post()
       hs.eventtap.event.newKeyEvent('up', true):post()
       hs.timer.usleep(30000)
       hs.mouse.absolutePosition({x=mousepoint.x,y=mousepoint.y})
       hs.eventtap.event.newKeyEvent('up', false):post()
       hs.eventtap.event.newKeyEvent('ctrl', false):post()
    end)

-- ======================================= Switcher
    --  // Window switcher
    local switcher  = require('switcher')
    -- Alt-B is bound to the switcher dialog for all apps.
    -- Alt-shift-B is bound to the switcher dialog for the current app.
    
    -- Hyper + "app key" launches/switches to the window of the app or cycles through its open windows if already focused
      -- switcherfunc() cycles through all widows of the frontmost app.
    -- Hyper + tab cycles to the previously focused app.
    
    --  function to either open apps or switch through them using switcher
    function openswitch(name)
        return function()
            if hs.application.frontmostApplication():name() == name then
              switcherfunc()
            else
              hs.application.launchOrFocus(name)
            end
        end
    end
    
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "X", openswitch("Finder"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "V", openswitch("Vivaldi"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "M", openswitch("Firefox"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "W", openswitch("Whatsapp"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "T", openswitch("Telegram"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "S", openswitch("MatterMost"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Z", openswitch("zoom.us"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "E", openswitch("Microsoft Excel"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "P", openswitch("Microsoft PowerPoint"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "C", openswitch("Calendar"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "A", openswitch("Anytype"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "D", openswitch("DeepL"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Q", openswitch("Preview"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "B", openswitch("Bike"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "I", openswitch("iTerm.app"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "N", openswitch("New Finder.app"))
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, "H", openswitch("Home Assistant.app"))
    
    
-- ======================================= Load Spoons and .lua files

--  // Rounded Corners
hs.loadSpoon("RoundedCorners")
spoon.RoundedCorners.radius = 8
spoon.RoundedCorners:start()

--  // resize and move windows with mouse
local SkyRocket = hs.loadSpoon("SkyRocket")
sky = SkyRocket:new({
  -- Which modifiers to hold to move a window?
  moveModifiers = {'ctrl','shift'},

  -- Which modifiers to hold to resize a window?
  resizeModifiers = {'alt', 'shift'},
})

-- // application cheatsheet
-- Triggered with hyper + ` (tilda key)
hs.loadSpoon("KSheetDark")
spoon.KSheetDark:init()
hs.hotkey.bind(hyper, 50, function()
  spoon.KSheetDark:toggle()
end)

-- ======================================= Utilities
-- // disable window animations
hs.window.animationDuration = 0

