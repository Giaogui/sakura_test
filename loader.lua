-- Giaogui Hub Loader (SAFE DEBUG VERSION)
-- This version adds checks + console output so the UI WILL show or tell you why it didn't.

warn(">>> Giaogui Loader EXECUTED <<<")

-- Ensure game is loaded
if not game:IsLoaded() then
    warn("Waiting for game to load...")
    game.Loaded:Wait()
end

warn("Game loaded, starting UI libs")

-- Base paths (ONLY these)
local BASE = "https://raw.githubusercontent.com/Giaogui/sakura_test/main"

local function safeLoad(url, name)
    warn("Loading:", name)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not ok then
        warn("FAILED loading", name, result)
        return nil
    end
    if result == nil then
        warn("ERROR:", name, "returned nil")
    end
    return result
end

-- Load UI Libraries
local DrRayLibrary = safeLoad(BASE .. "/UILibs/DrayLib_Giaogui.lua", "DrayLib")
local BoredLibrary = safeLoad(BASE .. "/UILibs/BoredLib_Giaogui.lua", "BoredLib")

if not DrRayLibrary then
    warn("STOPPING: DrRayLibrary failed to load")
    return
end

warn("UI libraries loaded successfully")

-- Create UI
local ok, MainWindow = pcall(function()
    return DrRayLibrary:Load("Giaogui Hub 🌸", "Default")
end)

if not ok or not MainWindow then
    warn("FAILED to create MainWindow")
    return
end

warn("Main window created")

-- Create tab safely
local HomeTab
pcall(function()
    HomeTab = DrRayLibrary.newTab("Home", "http://www.roblox.com/asset/?id=9405923687")
end)

if not HomeTab then
    warn("FAILED to create Home tab")
    return
end

warn("Home tab created")

-- Add test label
pcall(function()
    HomeTab.newLabel("Giaogui Hub Loaded Successfully ✅")
end)

-- AnimGrabber button
pcall(function()
    HomeTab.newButton("Animation Grabber", "Test utility", function()
        warn("AnimGrabber button pressed")
        loadstring(game:HttpGet(BASE .. "/utils/AnimGrabber.lua"))()
    end)
end)

warn(">>> Giaogui Hub READY <<<")
