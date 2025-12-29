-- // Giaogui Hub Loader (COMPAT FIXED) 🌸 --

warn(">>> Giaogui Loader EXECUTED <<<")

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- ========== URLS ==========
local BASE = "https://raw.githubusercontent.com/Giaogui/sakura_test/main"
local UILIB = BASE .. "/UILibs"

-- safe HttpGet
local function safeHttpGet(url)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)
    if ok and type(res) == "string" then
        return res
    end
    warn("HttpGet failed:", url)
    return nil
end

-- ========== LOAD UI LIBS ==========
local drayCode = safeHttpGet(UILIB .. "/DrayLib_Giaogui.lua")
local boredCode = safeHttpGet(UILIB .. "/BoredLib_Giaogui.lua")

if not drayCode or not boredCode then
    warn("Failed to download UI libraries")
    return
end

-- Execute libraries (they DO NOT return anything)
loadstring(drayCode)()
local BoredLibrary = loadstring(boredCode)()

-- ========== DRAY COMPAT WRAPPER ==========
-- This replaces the missing return API from DrayLib
local DrRayLibrary = {}

function DrRayLibrary:Load(title, theme)
    local window = {}

    function window:NewTab(tabName, icon)
        local tab = {}

        function tab:NewLabel(text)
            print("[Label]:", text)
        end

        function tab:NewButton(text, desc, callback)
            if typeof(callback) == "function" then
                callback()
            end
        end

        return tab
    end

    return window
end

-- ========== STARTLOADING (ORIGINAL BEHAVIOR) ==========
getgenv().StartLoading = function(flag)
    return function(func)
        if getgenv()[flag] and type(getgenv()[func]) == "function" then
            task.spawn(getgenv()[func])
        end
    end
end

-- ========== CREATE WINDOW ==========
local Window
local ok, err = pcall(function()
    Window = DrRayLibrary:Load("Giaogui Hub 🌸", "Default")
end)

if not ok or not Window then
    warn("FAILED to create window:", err)
    return
end

-- ========== HOME TAB ==========
local HomeTab = Window:NewTab("Home", "http://www.roblox.com/asset/?id=9405923687")
HomeTab:NewLabel("Giaogui Hub Loaded Successfully ✅")

HomeTab:NewButton("Animation Grabber", "Utility", function()
    local animCode = safeHttpGe
