-- // Giaogui Hub Loader (RECODE‑STYLE FIXED) 🌸 --

warn(">>> Giaogui Loader EXECUTED <<<")

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- ========== BASE URLS ========== --
local BASE = "https://raw.githubusercontent.com/Giaogui/sakura_test/main"
local UILIB = BASE .. "/UILibs"

-- safeHttpGet that doesn’t crash
local function safeHttpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and type(res) == "string" and #res > 10 then
        return res
    end
    warn("HttpGet failed:", url)
    return nil
end

-- load DrayLib and BoredLib
local DrRayLibrary = nil
local BoredLibrary = nil

do
    local drayCode = safeHttpGet(UILIB .. "/DrayLib_Giaogui.lua")
    if drayCode then
        DrRayLibrary = loadstring(drayCode)()
    end

    local boredCode = safeHttpGet(UILIB .. "/BoredLib_Giaogui.lua")
    if boredCode then
        BoredLibrary = loadstring(boredCode)()
    end
end

if not DrRayLibrary or not BoredLibrary then
    warn("Failed to load UI libraries — check URLs in your repo!")
    return
end

-- Recreate StartLoading pattern from original
getgenv().StartLoading = function(z)
    return function(x)
        return function()
            if getgenv()[z] == true then
                if type(getgenv()[x]) == "function" then
                    task.spawn(getgenv()[x])
                end
            end
        end
    end
end

-- Main Window
local Window
do
    local ok, err = pcall(function()
        Window = DrRayLibrary:Load("Giaogui Hub 🌸", "Default")
    end)
    if not ok or not Window then
        warn("FAILED to create main window:", err)
        return
    end
end

-- Home Tab
local HomeTab
do
    local status, result = pcall(function()
        HomeTab = Window:NewTab("Home", "http://www.roblox.com/asset/?id=9405923687")
    end)
    if not status or not HomeTab then
        warn("FAILED to create Home tab:", result)
        return
    end
end

HomeTab:NewLabel("Giaogui Hub Loaded Successfully ✅")

-- Animation Grabber Button
HomeTab:NewButton("Animation Grabber", "Utility", function()
    local animCode = safeHttpGet(BASE .. "/utils/AnimGrabber.lua")
    if animCode then
        loadstring(animCode)()
    else
        warn("Failed to load AnimGrabber")
    end
end)

warn(">>> Giaogui Hub READY <<<")
