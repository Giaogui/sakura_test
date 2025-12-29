-- Giaogui Hub Loader (FULLY FIXED / COMPILE SAFE)

warn("Giaogui Loader EXECUTED")

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- URLs
local BASE = "https://raw.githubusercontent.com/Giaogui/sakura_test/main"
local UILIB = BASE .. "/UILibs"

-- Safe HttpGet
local function safeHttpGet(url)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)
    if ok and type(res) == "string" then
        return res
    end
    return nil
end

-- Load UI libraries
local drayCode = safeHttpGet(UILIB .. "/DrayLib_Giaogui.lua")
local boredCode = safeHttpGet(UILIB .. "/BoredLib_Giaogui.lua")

if not drayCode or not boredCode then
    warn("Failed to download UI libraries")
    return
end

-- Execute UI libs (DrayLib does NOT return anything)
loadstring(drayCode)()
pcall(function()
    loadstring(boredCode)()
end)

-- DrRay compatibility wrapper
local DrRayLibrary = {}

function DrRayLibrary:Load(title, theme)
    local window = {}

    function window:NewTab(tabName, icon)
        local tab = {}

        function tab:NewLabel(text)
            print("[Label]", text)
        end

        function tab:NewButton(text, desc, callback)
            if type(callback) == "function" then
                callback()
            end
        end

        return tab
    end

    return window
end

-- StartLoading compatibility
getgenv().StartLoading = function(flag)
    return function(funcName)
        if getgenv()[flag] == true then
            local f = getgenv()[funcName]
            if type(f) == "function" then
                task.spawn(f)
            end
        end
    end
end

-- Create window
local Window
local ok, err = pcall(function()
    Window = DrRayLibrary:Load("Giaogui Hub", "Default")
end)

if not ok or not Window then
    warn("Failed to create window", err)
    return
end

-- Home tab
local HomeTab = Window:NewTab("Home", "")
HomeTab:NewLabel("Giaogui Hub Loaded Successfully")

HomeTab:NewButton("Animation Grabber", "Utility", function()
    local animCode = safeHttpGet(BASE .. "/utils/AnimGrabber.lua")
    if animCode then
        loadstring(animCode)()
    else
        warn("Failed to load AnimGrabber")
    end
end)

warn("Giaogui Hub READY")
