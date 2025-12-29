-- Giaogui Hub Loader (FIXED WINDOW CREATION)

warn(">>> Giaogui Loader EXECUTED <<<")

-- Wait for game
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local BASE = "https://raw.githubusercontent.com/Giaogui/sakura_test/main"

local function safeLoad(url, name)
    warn("Loading:", name)
    local ok, lib = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not ok then
        warn("FAILED loading", name, lib)
        return nil
    end
    if not lib then
        warn(name, "returned nil")
        return nil
    end
    return lib
end

-- Load UI lib
local DrRayLibrary = safeLoad(BASE .. "/UILibs/DrayLib_Giaogui.lua", "DrayLib")
if not DrRayLibrary then return end

warn("Creating main window")

-- IMPORTANT: DrRay API returns a window object
local Window
local ok, err = pcall(function()
    Window = DrRayLibrary:Load("Giaogui Hub 🌸", "Default")
end)

if not ok or not Window then
    warn("FAILED to create main window:", err)
    return
end

warn("Main window created")

-- Tabs are created from the WINDOW, not the library
local HomeTab
pcall(function()
    HomeTab = Window:NewTab("Home", "http://www.roblox.com/asset/?id=9405923687")
end)

if not HomeTab then
    warn("FAILED to create Home tab")
    return
end

warn("Home tab created")

HomeTab:NewLabel("Giaogui Hub Loaded Successfully ✅")

HomeTab:NewButton("Animation Grabber", "Utility", function()
    warn("AnimGrabber pressed")
    loadstring(game:HttpGet(BASE .. "/utils/AnimGrabber.lua"))()
end)

warn(">>> Giaogui Hub READY <<<")
