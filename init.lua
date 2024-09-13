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
local hyper = {"ctrl", "alt", "cmd", "shift"}

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
    
    hs.hotkey.bind(hyper, "A", openswitch("Arc"))
    hs.hotkey.bind(hyper, "S", openswitch("Spotify"))
    hs.hotkey.bind(hyper, "V", openswitch("Visual Studio Code"))
    hs.hotkey.bind(hyper, "I", openswitch("iTerm"))
    hs.hotkey.bind(hyper, "O", openswitch("Obsidian"))
    
