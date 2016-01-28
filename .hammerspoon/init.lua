-- [[
--    Options
-- ]]

-- Shorten the animation duration, less jerky
hs.window.animationDuration = 0.01

-- Don't show window titles in hints
hs.hints.showTitleThresh = 0

-- Set up window hints characters to be in this order
--   right hand center row
--   left hand center row
--   right hand top row
--   left hand top row
--   center bottom row
hs.hints.hintChars =
  { "H", "J", "K", "L",
    "A", "S", "D", "F", "G",
    "Y", "U", "I", "O", "P",
    "Q", "W", "E", "R", "T",
    "C", "V", "B", "N" }


-- [[
--    Window Control
--
-- ]]

function alertShowCannotMoveWindow()
  hs.alert.show("Can't move window")
end


-- Move current window to full screen
hs.hotkey.bind({"shift", "ctrl"}, "K", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()


  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- Move current window to left half of screen
hs.hotkey.bind({"cmd", "ctrl"}, "H", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()


  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Move current window to right half of screen
hs.hotkey.bind({"cmd", "ctrl"}, "L", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()


  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Move current window to bottom half of screen
hs.hotkey.bind({"cmd", "ctrl"}, "J", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()


  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Move current window to top half of screen
hs.hotkey.bind({"cmd", "ctrl"}, "K", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()


  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)


-- Window Hints like slate
--   I used Karabiner to change cmd+tab to emmit F19
hs.hotkey.bind({""}, "F19", function ()
  hs.hints.windowHints(nil)
end)


-- [[
--    Spotify Hotkeys
-- ]]
hs.hotkey.bind({"ctrl", "shift"}, "P", function()
  hs.spotify.playpause()
end)


-- [[
--    Other stuff
-- ]]

-- Automatically reload config when init is saved
function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")