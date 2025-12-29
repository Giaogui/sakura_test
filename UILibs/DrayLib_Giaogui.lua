-- DrayLib_Giaogui.lua (FIXED WRAPPER)

local HttpService = game:GetService("HttpService")

local BoredLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Giaogui/sakura_test/main/UILibs/BoredLib_Giaogui.lua"
))()

local DrRayLibrary = {}

function DrRayLibrary.newTab(name, icon)
    return BoredLib.newTab(name, icon)
end

return DrRayLibrary
