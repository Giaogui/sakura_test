-- // Giaogui Hub Loader (FINAL DEBUG & SAFE) 🌸 \\ --

warn(">>> Giaogui Loader EXECUTED <<<")

-- Wait for game to fully load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local BASE = "https://raw.githubusercontent.com/Giaogui/sakura_test/main"

-- Safe load function with verbose warnings
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

-- Load UI Libraries
local DrRayLibrary = safeLoad(BASE .. "/UILibs/DrayLib_Giaogui.lua", "DrayLib")
if not DrRayLibrary then return end

local BoredLibrary = safeLoad(BASE .. "/UILibs/BoredLib_Giaogui.lua", "BoredLib")
if not BoredLibrary then return end

warn("Creating main window...")

-- Create main window safely
local Window
local ok, err = pcall(function()
    Window = DrRayLibrary:Load("Giaogui Hub 🌸", "Default")
end)

if not ok or not Window then
    warn("FAILED to create main window:", err)
    return
end
warn("Main window created successfully")

-- Create Home Tab safely
local HomeTab
ok, err = pcall(function()
    HomeTab = Window:NewTab("Home", "http://www.roblox.com/asset/?id=9405923687")
end)

if not ok or not HomeTab then
    warn("FAILED to create Home tab:", err)
    return
end
warn("Home tab created successfully")

-- Quick status label
HomeTab:NewLabel("Giaogui Hub Loaded Successfully ✅")

-- AnimGrabber button
HomeTab:NewButton("Animation Grabber", "Utility", function()
    warn("AnimGrabber pressed")
    local animOk, animErr = pcall(function()
        loadstring(game:HttpGet(BASE .. "/utils/AnimGrabber.lua"))()
    end)
    if not animOk then
        warn("FAILED to load AnimGrabber:", animErr)
    end
end)

warn(">>> Giaogui Hub READY <<<")
