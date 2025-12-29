-- Giaogui Hub Loader (FIXED & CLEAN)

warn(">>> Giaogui Loader EXECUTED <<<")

-- Wait for game to fully load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Base URL for HttpGet
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

-- Load main UI library
local DrRayLibrary = safeLoad(BASE .. "/UILibs/DrayLib_Giaogui.lua", "DrayLib")
if not DrRayLibrary then
    warn("DrRayLibrary failed to load. Aborting.")
    return
end

warn("Creating main window...")

-- Create main window
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
local okTab, errTab = pcall(function()
    HomeTab = Window:NewTab("Home", "http://www.roblox.com/asset/?id=9405923687")
end)
if not okTab or not HomeTab then
    warn("FAILED to create Home tab:", errTab)
    return
end

warn("Home tab created")

-- Add example label
HomeTab:NewLabel("Giaogui Hub Loaded Successfully ✅")

-- Add Animation Grabber button
HomeTab:NewButton("Animation Grabber", "Utility", function()
    warn("Animation Grabber pressed")
    local okAnim, errAnim = pcall(function()
        loadstring(game:HttpGet(BASE .. "/utils/AnimGrabber.lua"))()
    end)
    if not okAnim then
        warn("Failed to load Animation Grabber:", errAnim)
    end
end)

warn(">>> Giaogui Hub READY <<<")
