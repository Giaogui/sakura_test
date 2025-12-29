-- Giaogui Hub Loader (FIXED WINDOW CREATION & URLs)

warn(">>> Giaogui Loader EXECUTED <<<")

-- Wait for game to fully load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Base URL (simplified, works with Roblox HttpGet)
local BASE = "https://raw.githubusercontent.com/Giaogui/sakura_test/main"

-- Safe loader function
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

-- Load UI libraries
local DrRayLibrary = safeLoad(BASE .. "/UILibs/DrayLib_Giaogui.lua", "DrayLib")
local BoredLibrary = safeLoad(BASE .. "/UILibs/BoredLib_Giaogui.lua", "BoredLib")
if not DrRayLibrary or not BoredLibrary then return end

warn("Creating main window")

-- Create main window from DrRayLibrary
local Window
local ok, err = pcall(function()
    Window = DrRayLibrary:Load("Giaogui Hub 🌸", "Default")
end)

if not ok or not Window then
    warn("FAILED to create main window:", err)
    return
end

warn("Main window created")

-- Create Home tab
local HomeTab
pcall(function()
    HomeTab = Window:NewTab("Home", "http://www.roblox.com/asset/?id=9405923687")
end)

if not HomeTab then
    warn("FAILED to create Home tab")
    return
end

warn("Home tab created")

-- Add example label
HomeTab:NewLabel("Giaogui Hub Loaded Successfully ✅")

-- Add Animation Grabber button
HomeTab:NewButton("Animation Grabber", "Utility", function()
    warn("AnimGrabber pressed")
    loadstring(game:HttpGet(BASE .. "/utils/AnimGrabber.lua"))()
end)

warn(">>> Giaogui Hub READY <<<")
