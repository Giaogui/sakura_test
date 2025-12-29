-- DrayLib_Giaogui.lua (GLOBAL FIX)

local BoredLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Giaogui/sakura_test/main/UILibs/BoredLib_Giaogui.lua"
))()

local DrRayLibrary = {}

function DrRayLibrary.newTab(name, icon)
    return BoredLib.newTab(name, icon)
end

-- 🔴 THIS IS THE MISSING PART 🔴
getgenv().DrRayLibrary = DrRayLibrary
_G.DrRayLibrary = DrRayLibrary
shared = shared or {}
shared.DrRayLibrary = DrRayLibrary

return DrRayLibrary
